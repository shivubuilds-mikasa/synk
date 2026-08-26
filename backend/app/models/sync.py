"""Clipboard synchronization protocol models for Synk backend.

This module defines the message protocol for clipboard synchronization
between devices via WebSocket.
"""

from datetime import datetime, timezone
from enum import Enum
from typing import Annotated, Literal, Optional, Union

from pydantic import BaseModel, Field, field_validator


class SyncMessageType(str, Enum):
    """Types of synchronization messages."""

    # Client -> Server
    CLIPBOARD_UPDATE = "clipboard.update"
    PING = "ping"
    DELIVERY_RECEIPT = "delivery.receipt"
    HISTORY_SYNC_REQUEST = "history.sync.request"

    # Server -> Client
    AUTH_SUCCESS = "auth.success"
    CLIPBOARD_UPDATE_RECEIVED = "clipboard.update.received"
    CLIPBOARD_UPDATE_RELAY = "clipboard.update.relay"
    PONG = "pong"
    ERROR = "error"
    ACK = "ack"
    HISTORY_SYNC_RESPONSE = "history.sync.response"
    DEVICE_ONLINE = "device.online"
    DEVICE_OFFLINE = "device.offline"


class ContentType(str, Enum):
    """Supported content types for synchronization."""

    TEXT = "text"
    # Future: IMAGE = "image", FILE = "file", LINK = "link"


class ClipboardPayload(BaseModel):
    """Payload for clipboard synchronization."""

    content_type: ContentType = ContentType.TEXT

    text: Annotated[
        str,
        Field(
            min_length=1,
            max_length=100000,
            description="Text content to synchronize",
        ),
    ]

    @field_validator("text")
    @classmethod
    def validate_text_not_empty(cls, v: str) -> str:
        if not v or not v.strip():
            raise ValueError("text content cannot be empty")
        return v


class SyncMessageBase(BaseModel):
    """Base synchronization message with common fields."""

    type: SyncMessageType
    version: int = 1

    message_id: Annotated[
        str,
        Field(
            min_length=1,
            max_length=64,
            description="Unique message identifier for deduplication",
        ),
    ]

    device_id: Annotated[
        str,
        Field(
            min_length=1,
            max_length=64,
            description="Sender device ID",
        ),
    ]

    timestamp: Annotated[
        str,
        Field(
            description="ISO 8601 timestamp of message creation",
        ),
    ]

    @staticmethod
    def generate_timestamp() -> str:
        """Generate current UTC timestamp in ISO 8601 format."""
        return datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")


class ClipboardUpdateMessage(SyncMessageBase):
    """Client -> Server: Clipboard content update."""

    type: Literal[SyncMessageType.CLIPBOARD_UPDATE] = SyncMessageType.CLIPBOARD_UPDATE

    payload: ClipboardPayload


class PingMessage(SyncMessageBase):
    """Client -> Server: Ping for connection health."""

    type: Literal[SyncMessageType.PING] = SyncMessageType.PING

    payload: Optional[dict] = None


class DeliveryReceiptMessage(SyncMessageBase):
    """Client -> Server: Confirm delivery of a clipboard update."""

    type: Literal[SyncMessageType.DELIVERY_RECEIPT] = SyncMessageType.DELIVERY_RECEIPT

    payload: Annotated[
        dict,
        Field(description="Delivery receipt details"),
    ]


class HistorySyncRequestMessage(SyncMessageBase):
    """Client -> Server: Request clipboard history sync."""

    type: Literal[SyncMessageType.HISTORY_SYNC_REQUEST] = (
        SyncMessageType.HISTORY_SYNC_REQUEST
    )

    payload: Annotated[
        dict,
        Field(description="Sync request parameters"),
    ]


# Union of all client-to-server messages
ClientMessage = Union[
    ClipboardUpdateMessage,
    PingMessage,
    DeliveryReceiptMessage,
    HistorySyncRequestMessage,
]


class ClipboardUpdateReceivedMessage(SyncMessageBase):
    """Server -> Client: Acknowledgment that clipboard update was received."""

    type: Literal[SyncMessageType.CLIPBOARD_UPDATE_RECEIVED] = (
        SyncMessageType.CLIPBOARD_UPDATE_RECEIVED
    )

    payload: dict = Field(default_factory=dict)


class ClipboardUpdateRelayMessage(SyncMessageBase):
    """Server -> Client: Relayed clipboard update from paired device."""

    type: Literal[SyncMessageType.CLIPBOARD_UPDATE_RELAY] = (
        SyncMessageType.CLIPBOARD_UPDATE_RELAY
    )

    payload: ClipboardPayload

    source_device_id: Annotated[
        str,
        Field(
            min_length=1,
            max_length=64,
            description="Original sender device ID",
        ),
    ]


class PongMessage(SyncMessageBase):
    """Server -> Client: Ping response."""

    type: Literal[SyncMessageType.PONG] = SyncMessageType.PONG

    payload: Optional[dict] = None


class ErrorMessage(SyncMessageBase):
    """Server -> Client: Error response."""

    type: Literal[SyncMessageType.ERROR] = SyncMessageType.ERROR

    payload: Annotated[
        dict,
        Field(description="Error details"),
    ]


class AckMessage(SyncMessageBase):
    """Server -> Client: Generic acknowledgment."""

    type: Literal[SyncMessageType.ACK] = SyncMessageType.ACK

    payload: Annotated[
        dict,
        Field(description="Acknowledgment details"),
    ]


class DeliveryReceiptMessageServer(SyncMessageBase):
    """Server -> Client: Delivery receipt for a clipboard update."""

    type: Literal[SyncMessageType.DELIVERY_RECEIPT] = (
        SyncMessageType.DELIVERY_RECEIPT
    )

    payload: Annotated[
        dict,
        Field(description="Delivery receipt details"),
    ]


class HistorySyncResponseMessage(SyncMessageBase):
    """Server -> Client: Clipboard history sync response."""

    type: Literal[SyncMessageType.HISTORY_SYNC_RESPONSE] = (
        SyncMessageType.HISTORY_SYNC_RESPONSE
    )

    payload: Annotated[
        dict,
        Field(description="History sync response data"),
    ]


class DeviceOnlineMessage(SyncMessageBase):
    """Server -> Client: Notification that a paired device came online."""

    type: Literal[SyncMessageType.DEVICE_ONLINE] = SyncMessageType.DEVICE_ONLINE

    payload: Annotated[
        dict,
        Field(description="Online device info"),
    ]


class DeviceOfflineMessage(SyncMessageBase):
    """Server -> Client: Notification that a paired device went offline."""

    type: Literal[SyncMessageType.DEVICE_OFFLINE] = SyncMessageType.DEVICE_OFFLINE

    payload: Annotated[
        dict,
        Field(description="Offline device info"),
    ]


# Union of all server-to-client messages
ServerMessage = Union[
    ClipboardUpdateReceivedMessage,
    ClipboardUpdateRelayMessage,
    PongMessage,
    ErrorMessage,
    AckMessage,
    DeliveryReceiptMessageServer,
    HistorySyncResponseMessage,
    DeviceOnlineMessage,
    DeviceOfflineMessage,
]


# All possible messages
SyncMessage = Union[ClientMessage, ServerMessage]


class MessageValidator:
    """Validates and parses incoming WebSocket messages."""

    MAX_MESSAGE_SIZE = 200000
    MAX_TEXT_SIZE = 100000

    @classmethod
    def validate_raw_message(cls, raw: str) -> dict:
        """Validate raw JSON message size and parse."""

        if len(raw) > cls.MAX_MESSAGE_SIZE:
            raise ValueError(
                f"Message too large: {len(raw)} bytes "
                f"(max {cls.MAX_MESSAGE_SIZE})"
            )

        import json

        try:
            return json.loads(raw)
        except json.JSONDecodeError as e:
            raise ValueError(f"Invalid JSON: {e}")

    @classmethod
    def parse_client_message(cls, data: dict) -> ClientMessage:
        """Parse and validate a client-to-server message."""

        msg_type = data.get("type")

        if not msg_type:
            raise ValueError("Missing message type")

        try:
            if msg_type == SyncMessageType.CLIPBOARD_UPDATE:
                return ClipboardUpdateMessage(**data)

            elif msg_type == SyncMessageType.PING:
                return PingMessage(**data)

            elif msg_type == SyncMessageType.DELIVERY_RECEIPT:
                return DeliveryReceiptMessage(**data)

            elif msg_type == SyncMessageType.HISTORY_SYNC_REQUEST:
                return HistorySyncRequestMessage(**data)

            else:
                raise ValueError(f"Unknown message type: {msg_type}")

        except Exception as e:
            raise ValueError(
                f"Invalid message format for type {msg_type}: {e}"
            )


def create_error_message(
    message_id: str,
    device_id: str,
    error_code: str,
    error_message: str,
    original_message_id: Optional[str] = None,
) -> ErrorMessage:
    """Create a standardized error message."""

    return ErrorMessage(
        type=SyncMessageType.ERROR,
        message_id=message_id,
        device_id=device_id,
        timestamp=SyncMessageBase.generate_timestamp(),
        payload={
            "error_code": error_code,
            "error_message": error_message,
            "original_message_id": original_message_id,
        },
    )


def create_ack_message(
    message_id: str,
    device_id: str,
    acknowledged_message_id: str,
    status: str = "received",
) -> AckMessage:
    """Create an acknowledgment message."""

    return AckMessage(
        type=SyncMessageType.ACK,
        message_id=message_id,
        device_id=device_id,
        timestamp=SyncMessageBase.generate_timestamp(),
        payload={
            "acknowledged_message_id": acknowledged_message_id,
            "status": status,
        },
    )