"""WebSocket route for authenticated device connections and clipboard synchronization."""

import asyncio
import hashlib
import json
import logging
import secrets
import uuid as uuid_mod
from datetime import datetime, timezone
from typing import Any, Optional

from fastapi import APIRouter, WebSocket, WebSocketDisconnect

from app.core.ws_manager import manager
from app.db.database import database
from app.models.sync import (
    ClipboardUpdateMessage,
    ClipboardUpdateRelayMessage,
    PingMessage,
    SyncMessageType,
    SyncMessageBase,
    MessageValidator,
    create_error_message,
    create_ack_message,
    DeliveryReceiptMessage,
    HistorySyncRequestMessage,
    ClipboardUpdateReceivedMessage,
    DeliveryReceiptMessageServer,
    DeviceOnlineMessage,
    DeviceOfflineMessage,
)
from app.repositories.clipboard_repository import ClipboardRepository
from app.services.auth_service import auth_service
from app.services.pairing_registry import pairing_registry

logger = logging.getLogger(__name__)

router = APIRouter(tags=["websocket"])

# Authentication timeout in seconds
AUTH_TIMEOUT_SECONDS = 10

# Maximum clipboard content length to store in DB (larger entries only store hash)
MAX_CONTENT_STORE_LENGTH = 10000


class AuthenticatedConnection:
    """Represents an authenticated WebSocket connection."""

    def __init__(self, device_id: str, websocket: WebSocket) -> None:
        self.device_id = device_id
        self.websocket = websocket


async def authenticate_websocket(websocket: WebSocket) -> Optional[str]:
    """Authenticate a WebSocket connection using a token message.

    The client must send an authentication message within AUTH_TIMEOUT_SECONDS:
        {"type": "auth", "token": "synk_..."}

    This approach was chosen over query-string tokens because tokens in URLs
    can leak via access logs, proxy logs, and browser history. A first-message
    handshake keeps the token out of any URL or log.

    Args:
        websocket: The WebSocket connection to authenticate.

    Returns:
        The device_id if authentication succeeded, None otherwise.
    """
    try:
        # Wait for auth message with timeout
        raw = await asyncio.wait_for(websocket.receive_text(), timeout=AUTH_TIMEOUT_SECONDS)

        data = json.loads(raw)
        msg_type = data.get("type")

        if msg_type != "auth":
            await websocket.send_json({
                "type": "error",
                "payload": {
                    "error_code": "expected_auth",
                    "error_message": "First message must be authentication",
                },
            })
            return None

        token = data.get("token")
        if not token or not isinstance(token, str):
            await websocket.send_json({
                "type": "error",
                "payload": {
                    "error_code": "invalid_token",
                    "error_message": "Missing or invalid token",
                },
            })
            return None

        # Verify token against database
        async with database.session() as session:
            auth_token = await auth_service.verify_token_string(session, token)
            if auth_token is None:
                await websocket.send_json({
                    "type": "error",
                    "payload": {
                        "error_code": "authentication_failed",
                        "error_message": "Invalid or expired token",
                    },
                })
                return None

            device_id = str(auth_token.device_id)

        # Send success response
        auth_success = {
            "type": SyncMessageType.AUTH_SUCCESS.value,
            "version": 1,
            "message_id": secrets.token_hex(16),
            "device_id": device_id,
            "timestamp": SyncMessageBase.generate_timestamp(),
            "payload": {},
        }
        await websocket.send_json(auth_success)

        return device_id

    except asyncio.TimeoutError:
        logger.warning("WebSocket authentication timeout")
        return None
    except json.JSONDecodeError:
        logger.warning("WebSocket auth message was not valid JSON")
        return None
    except Exception as e:
        logger.error(f"WebSocket authentication error: {e}")
        return None


@router.websocket("/ws/{claimed_device_id}")
async def websocket_endpoint(websocket: WebSocket, claimed_device_id: str) -> None:
    """Authenticated WebSocket endpoint for device communication.

    Flow:
    1. Client connects to /ws/{claimed_device_id}
    2. Server accepts connection
    3. Client sends auth message: {"type": "auth", "token": "synk_..."}
    4. Server verifies token; the authenticated device_id from the token
       overrides whatever device_id was claimed in the URL.
    5. Connection registered for the real device_id
    6. Clipboard updates relayed only to paired devices

    Args:
        websocket: The WebSocket connection.
        claimed_device_id: Device ID claimed by client in URL (verified against token).
    """
    # Accept the connection first (required before receiving messages)
    await websocket.accept()

    # Authenticate after accepting
    device_id = await authenticate_websocket(websocket)

    if device_id is None:
        # Reject connection - close with policy violation code
        await websocket.close(code=4401, reason="Authentication failed")
        return

    # Verify claimed device_id matches authenticated identity when it's a UUID;
    # otherwise trust the authenticated identity from the token.
    try:
        claimed_uuid = uuid_mod.UUID(claimed_device_id)
        auth_uuid = uuid_mod.UUID(device_id)
        if claimed_uuid != auth_uuid:
            logger.warning(
                f"Device ID mismatch: claimed {claimed_device_id}, token says {device_id}"
            )
    except ValueError:
        # Non-UUID path - trust token identity
        pass

    # Register connection under authenticated identity
    await manager.connect(device_id, websocket)

    # Sync undelivered clipboard entries for this device (re-sync missed updates)
    async with database.session() as session:
        clipboard_repo = ClipboardRepository(session)
        device_uuid = uuid_mod.UUID(device_id)
        undelivered = await clipboard_repo.get_undelivered_for_device(device_uuid)
        if undelivered:
            logger.info(f"Syncing {len(undelivered)} undelivered entries to {device_id} on connect")
            for entry in undelivered:
                try:
                    # Skip entries with NULL content_text (large entries >10000 chars not stored in full)
                    if entry.content_text is None:
                        logger.warning(
                            f"Skipping undelivered entry {entry.message_id} for {device_id}: "
                            f"content_text is NULL (large entry)"
                        )
                        # Still increment delivered count so we don't retry
                        await clipboard_repo.increment_delivered_count(device_uuid, entry.message_id)
                        continue

                    # Build relay message for each undelivered entry
                    relay = ClipboardUpdateRelayMessage(
                        message_id=entry.message_id,
                        device_id=device_id,
                        timestamp=entry.created_at.isoformat().replace("+00:00", "Z"),
                        payload={"content_type": entry.content_type, "text": entry.content_text},
                        source_device_id=str(entry.source_device_id) if entry.source_device_id else device_id,
                    )
                    await manager.send_personal_message(device_id, json.loads(relay.model_dump_json()))
                    # Increment delivered count
                    await clipboard_repo.increment_delivered_count(device_uuid, entry.message_id)
                except Exception as e:
                    logger.error(
                        f"Failed to sync undelivered entry {entry.message_id} to {device_id}: {e}"
                    )
                    # Continue with other entries
            await session.commit()

    # Notify paired devices that this device is online
    online_msg = DeviceOnlineMessage(
        message_id=secrets.token_hex(16),
        device_id=device_id,
        timestamp=SyncMessageBase.generate_timestamp(),
        payload={"device_id": device_id},
    )
    await manager.send_to_paired_devices(device_id, json.loads(online_msg.model_dump_json()))

    try:
        while True:
            raw = await websocket.receive_text()

            try:
                data = MessageValidator.validate_raw_message(raw)
            except ValueError as e:
                error_msg = create_error_message(
                    message_id=secrets.token_hex(16),
                    device_id=device_id,
                    error_code="invalid_message",
                    error_message=str(e),
                )
                await websocket.send_text(error_msg.model_dump_json())
                continue

            msg_type = data.get("type")

            # Handle clipboard update
            if msg_type == SyncMessageType.CLIPBOARD_UPDATE:
                try:
                    clipboard_msg = ClipboardUpdateMessage(**data)
                except Exception as e:
                    error_msg = create_error_message(
                        message_id=secrets.token_hex(16),
                        device_id=device_id,
                        error_code="invalid_clipboard_update",
                        error_message=str(e),
                        original_message_id=data.get("message_id"),
                    )
                    await websocket.send_text(error_msg.model_dump_json())
                    continue

                # Verify sender identity matches authenticated device
                if clipboard_msg.device_id != device_id:
                    error_msg = create_error_message(
                        message_id=secrets.token_hex(16),
                        device_id=device_id,
                        error_code="identity_mismatch",
                        error_message="Message device_id does not match authenticated device",
                        original_message_id=clipboard_msg.message_id,
                    )
                    await websocket.send_text(error_msg.model_dump_json())
                    continue

                # Persist clipboard history with deduplication
                async with database.session() as session:
                    clipboard_repo = ClipboardRepository(session)

                    # Check for duplicate message_id (deduplication)
                    device_uuid = uuid_mod.UUID(device_id)
                    exists = await clipboard_repo.exists_by_message_id(
                        device_uuid, clipboard_msg.message_id
                    )
                    if exists:
                        logger.info(
                            f"Duplicate clipboard message_id {clipboard_msg.message_id} from {device_id}, "
                            f"acknowledging without relay"
                        )
                        ack = create_ack_message(
                            message_id=secrets.token_hex(16),
                            device_id=device_id,
                            acknowledged_message_id=clipboard_msg.message_id,
                            status="duplicate",
                        )
                        await websocket.send_text(ack.model_dump_json())
                        continue

                    # Create clipboard history entry
                    source_device_uuid = None
                    try:
                        source_device_uuid = uuid_mod.UUID(device_id)
                    except ValueError:
                        pass

                    await clipboard_repo.create(
                        device_id=device_uuid,
                        message_id=clipboard_msg.message_id,
                        content_type=clipboard_msg.payload.content_type.value,
                        content_text=clipboard_msg.payload.text,
                        source_device_id=source_device_uuid,
                    )
                    await session.commit()

                # Build relay message for paired devices
                relay = ClipboardUpdateRelayMessage(
                    message_id=clipboard_msg.message_id,
                    device_id=device_id,
                    timestamp=clipboard_msg.timestamp,
                    payload=clipboard_msg.payload,
                    source_device_id=device_id,
                )

                # Relay to all paired devices
                delivered = await manager.send_to_paired_devices(
                    device_id,
                    json.loads(relay.model_dump_json()),
                )

                logger.info(
                    f"Clipboard update {clipboard_msg.message_id} from {device_id}: "
                    f"{len(clipboard_msg.payload.text)} chars, relayed to {delivered} devices"
                )

                # Acknowledge receipt to sender
                ack = create_ack_message(
                    message_id=secrets.token_hex(16),
                    device_id=device_id,
                    acknowledged_message_id=clipboard_msg.message_id,
                    status="relayed" if delivered > 0 else "no_paired_devices_online",
                )
                await websocket.send_text(ack.model_dump_json())

            elif msg_type == SyncMessageType.DELIVERY_RECEIPT:
                # Handle delivery receipt from client
                try:
                    receipt_msg = DeliveryReceiptMessage(**data)
                except Exception as e:
                    error_msg = create_error_message(
                        message_id=secrets.token_hex(16),
                        device_id=device_id,
                        error_code="invalid_delivery_receipt",
                        error_message=str(e),
                        original_message_id=data.get("message_id"),
                    )
                    await websocket.send_text(error_msg.model_dump_json())
                    continue

                # Increment delivery count for the clipboard entry
                received_message_id = receipt_msg.payload.get("received_message_id")
                if received_message_id:
                    async with database.session() as session:
                        clipboard_repo = ClipboardRepository(session)
                        device_uuid = uuid_mod.UUID(device_id)
                        await clipboard_repo.increment_delivered_count(
                            device_uuid, received_message_id
                        )
                        await session.commit()

                    # Acknowledge receipt
                    ack = create_ack_message(
                        message_id=secrets.token_hex(16),
                        device_id=device_id,
                        acknowledged_message_id=receipt_msg.message_id,
                        status="receipt_recorded",
                    )
                    await websocket.send_text(ack.model_dump_json())

            elif msg_type == SyncMessageType.HISTORY_SYNC_REQUEST:
                # Handle clipboard history sync request
                try:
                    history_msg = HistorySyncRequestMessage(**data)
                except Exception as e:
                    error_msg = create_error_message(
                        message_id=secrets.token_hex(16),
                        device_id=device_id,
                        error_code="invalid_history_sync",
                        error_message=str(e),
                        original_message_id=data.get("message_id"),
                    )
                    await websocket.send_text(error_msg.model_dump_json())
                    continue

                # Get recent clipboard history
                async with database.session() as session:
                    clipboard_repo = ClipboardRepository(session)
                    device_uuid = uuid_mod.UUID(device_id)

                    # Get recent entries (limit from request or default 50)
                    limit = history_msg.payload.get("limit", 50)
                    entries = await clipboard_repo.get_recent_by_device(
                        device_uuid, limit=min(limit, 100)
                    )

                    # Build history response
                    history_entries = []
                    for entry in entries:
                        # Skip entries with NULL content_text (large entries >10000 chars)
                        if entry.content_text is None:
                            logger.warning(
                                f"Skipping history entry {entry.message_id} for {device_id}: "
                                f"content_text is NULL (large entry)"
                            )
                            continue
                        history_entries.append({
                            "message_id": entry.message_id,
                            "content_type": entry.content_type,
                            "content_text": entry.content_text,
                            "source_device_id": str(entry.source_device_id) if entry.source_device_id else None,
                            "delivered_count": entry.delivered_count,
                            "created_at": entry.created_at.isoformat() if entry.created_at else None,
                        })

                    # Send history response
                    history_response = {
                        "type": SyncMessageType.HISTORY_SYNC_RESPONSE.value,
                        "version": 1,
                        "message_id": secrets.token_hex(16),
                        "device_id": device_id,
                        "timestamp": SyncMessageBase.generate_timestamp(),
                        "payload": {
                            "entries": history_entries,
                            "count": len(history_entries),
                            "limit": limit,
                        },
                    }
                    await websocket.send_text(json.dumps(history_response))

            elif msg_type == SyncMessageType.PING:
                # Respond to ping
                pong = {
                    "type": SyncMessageType.PONG.value,
                    "version": 1,
                    "message_id": secrets.token_hex(16),
                    "device_id": device_id,
                    "timestamp": SyncMessageBase.generate_timestamp(),
                }
                if "message_id" in data:
                    pong["payload"] = {"original_message_id": data["message_id"]}
                await websocket.send_text(json.dumps(pong))

            else:
                error_msg = create_error_message(
                    message_id=secrets.token_hex(16),
                    device_id=device_id,
                    error_code="unknown_message_type",
                    error_message=f"Unknown message type: {msg_type}",
                )
                await websocket.send_text(error_msg.model_dump_json())

    except WebSocketDisconnect:
        # Notify paired devices that this device is offline
        offline_msg = DeviceOfflineMessage(
            message_id=secrets.token_hex(16),
            device_id=device_id,
            timestamp=SyncMessageBase.generate_timestamp(),
            payload={"device_id": device_id},
        )
        await manager.send_to_paired_devices(device_id, json.loads(offline_msg.model_dump_json()))

        await manager.disconnect(device_id, websocket)
        logger.info(f"Device {device_id} disconnected normally")
    except Exception as e:
        logger.error(f"Unexpected error for device {device_id}: {e}")
        await manager.disconnect(device_id, websocket)