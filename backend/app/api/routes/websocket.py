"""WebSocket route for device connections."""

import json
import logging
from typing import Any

from fastapi import APIRouter, WebSocket, WebSocketDisconnect

from app.core.ws_manager import manager

logger = logging.getLogger(__name__)

router = APIRouter(tags=["websocket"])


@router.websocket("/ws/{device_id}")
async def websocket_endpoint(websocket: WebSocket, device_id: str) -> None:
    """WebSocket endpoint for device communication.

    Args:
        websocket: The WebSocket connection.
        device_id: Unique identifier for the connecting device.
    """
    await manager.connect(device_id, websocket)

    try:
        while True:
            # Receive message from client
            data = await websocket.receive_text()

            try:
                message = json.loads(data)
            except json.JSONDecodeError:
                # Handle invalid JSON gracefully
                await websocket.send_text(
                    json.dumps(
                        {
                            "type": "error",
                            "message": "Invalid JSON format",
                            "received": data[:200],  # Truncate long messages
                        }
                    )
                )
                continue

            # Echo the message back with a predictable format for testing
            response = {
                "type": "echo",
                "original": message,
                "device_id": device_id,
                "timestamp": "2026-01-01T00:00:00Z",  # Placeholder, real implementation would use datetime
            }

            await websocket.send_text(json.dumps(response))

    except WebSocketDisconnect:
        # Normal disconnect handling
        await manager.disconnect(device_id, websocket)
        logger.info(f"Device {device_id} disconnected normally")
    except Exception as e:
        # Unexpected disconnect or error handling
        logger.error(f"Unexpected error for device {device_id}: {e}")
        await manager.disconnect(device_id, websocket)