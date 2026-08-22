"""Pairing SQLAlchemy ORM model."""

import uuid
from datetime import datetime, timezone
from typing import TYPE_CHECKING

from sqlalchemy import ForeignKey, String, UniqueConstraint, Index
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.db.models.base import Base, TimestampMixin

if TYPE_CHECKING:
    from app.db.models.device import DeviceModel


class PairingModel(Base, TimestampMixin):
    """SQLAlchemy ORM model for device pairings.

    Represents a bidirectional pairing relationship between two devices.
    Normalized as a single row with device_a_id < device_b_id to prevent duplicates.
    """

    __tablename__ = "pairings"

    id: Mapped[uuid.UUID] = mapped_column(
        primary_key=True,
        default=uuid.uuid4,
        nullable=False,
    )
    device_a_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("devices.id", ondelete="CASCADE"),
        nullable=False,
    )
    device_b_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("devices.id", ondelete="CASCADE"),
        nullable=False,
    )

    # Relationships
    device_a: Mapped["DeviceModel"] = relationship(
        "DeviceModel",
        foreign_keys=[device_a_id],
        back_populates="pairings_as_a",
        lazy="selectin",
    )
    device_b: Mapped["DeviceModel"] = relationship(
        "DeviceModel",
        foreign_keys=[device_b_id],
        back_populates="pairings_as_b",
        lazy="selectin",
    )

    # Constraints
    __table_args__ = (
        # Ensure device_a_id < device_b_id for consistent ordering (prevents duplicates)
        # This is enforced at the application level in the repository
        UniqueConstraint("device_a_id", "device_b_id", name="uq_pairing_devices"),
        # Indexes for efficient lookup
        Index("ix_pairings_device_a_id", "device_a_id"),
        Index("ix_pairings_device_b_id", "device_b_id"),
    )

    def __repr__(self) -> str:
        return f"<PairingModel(id={self.id}, device_a={self.device_a_id}, device_b={self.device_b_id})>"

    @property
    def devices(self) -> tuple["DeviceModel", "DeviceModel"]:
        """Return the two devices in this pairing."""
        return (self.device_a, self.device_b)

    def get_other_device(self, device_id: uuid.UUID) -> "DeviceModel | None":
        """Get the other device in the pairing.

        Args:
            device_id: One of the device IDs in this pairing.

        Returns:
            The other device, or None if device_id is not part of this pairing.
        """
        if self.device_a_id == device_id:
            return self.device_b
        elif self.device_b_id == device_id:
            return self.device_a
        return None