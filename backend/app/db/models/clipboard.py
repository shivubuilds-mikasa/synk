"""Clipboard history SQLAlchemy ORM model."""

import uuid
from datetime import datetime, timezone
from typing import TYPE_CHECKING, Optional

from sqlalchemy import DateTime, ForeignKey, Index, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.db.models.base import Base, TimestampMixin

if TYPE_CHECKING:
    from app.db.models.device import DeviceModel


class ClipboardHistoryModel(Base, TimestampMixin):
    """SQLAlchemy ORM model for clipboard history entries.

    Stores clipboard synchronization history for each device.
    Used for deduplication and potential future features like
    clipboard history sync across devices.
    """

    __tablename__ = "clipboard_history"

    id: Mapped[uuid.UUID] = mapped_column(
        primary_key=True,
        default=uuid.uuid4,
        nullable=False,
    )
    device_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("devices.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    message_id: Mapped[str] = mapped_column(
        String(64),
        nullable=False,
        index=True,
    )
    content_type: Mapped[str] = mapped_column(
        String(32),
        nullable=False,
        default="text",
    )
    content_hash: Mapped[str] = mapped_column(
        String(64),  # SHA-256 hex
        nullable=False,
    )
    content_text: Mapped[Optional[str]] = mapped_column(
        Text,
        nullable=True,  # Store actual content for small entries, NULL for large
    )
    source_device_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("devices.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    delivered_count: Mapped[int] = mapped_column(
        nullable=False,
        default=0,
    )

    # Relationships
    device: Mapped["DeviceModel"] = relationship(
        "DeviceModel",
        foreign_keys=[device_id],
        back_populates="clipboard_history",
        lazy="selectin",
    )
    source_device: Mapped[Optional["DeviceModel"]] = relationship(
        "DeviceModel",
        foreign_keys=[source_device_id],
        lazy="selectin",
    )

    # Constraints and indexes
    __table_args__ = (
        # Unique constraint on device + message_id for deduplication
        Index("ix_clipboard_history_device_message", "device_id", "message_id", unique=True),
        # Index for looking up by content hash (deduplication)
        Index("ix_clipboard_history_content_hash", "content_hash"),
        # Index for time-based queries
        Index("ix_clipboard_history_created_at", "created_at"),
    )

    def __repr__(self) -> str:
        return f"<ClipboardHistoryModel(id={self.id}, device_id={self.device_id}, message_id={self.message_id})>"