"""Authentication SQLAlchemy ORM model."""

import uuid
from datetime import datetime, timezone
from typing import TYPE_CHECKING, Optional

from sqlalchemy import DateTime, ForeignKey, String, Index
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.db.models.base import Base, TimestampMixin

if TYPE_CHECKING:
    from app.db.models.device import DeviceModel


class AuthTokenModel(Base, TimestampMixin):
    """SQLAlchemy ORM model for device authentication tokens.

    Stores a secure hash of the authentication token, never the raw token.
    The raw token is only returned to the client once at registration time.
    """

    __tablename__ = "auth_tokens"

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
    token_hash: Mapped[str] = mapped_column(
        String(256),  # SHA-256 hex = 64 chars, but leave room for future algorithms
        nullable=False,
    )
    expires_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True),
        nullable=True,  # Null means no expiration
    )
    revoked_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
    last_used_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )

    # Relationship
    device: Mapped["DeviceModel"] = relationship(
        "DeviceModel",
        back_populates="auth_tokens",
        lazy="selectin",
    )

    # Constraints and indexes
    __table_args__ = (
        # Index for looking up tokens by hash (for verification)
        Index("ix_auth_tokens_token_hash", "token_hash"),
        # Index for finding active tokens for a device
        Index("ix_auth_tokens_device_active", "device_id", "revoked_at", "expires_at"),
    )

    def __repr__(self) -> str:
        status = "revoked" if self.revoked_at else ("expired" if self.expires_at and self.expires_at < datetime.now(timezone.utc) else "active")
        return f"<AuthTokenModel(id={self.id}, device_id={self.device_id}, status={status})>"

    @property
    def is_active(self) -> bool:
        """Check if token is currently active (not revoked, not expired)."""
        now = datetime.now(timezone.utc)
        if self.revoked_at is not None:
            return False
        if self.expires_at is not None and self.expires_at < now:
            return False
        return True