"""Device SQLAlchemy ORM model."""

import uuid
from datetime import datetime, timezone
from typing import TYPE_CHECKING

from sqlalchemy import String, Enum as SQLEnum
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.db.models.base import Base, TimestampMixin
from app.models.device import DeviceType

if TYPE_CHECKING:
    from app.db.models.pairing import PairingModel
    from app.db.models.auth import AuthTokenModel
    from app.db.models.clipboard import ClipboardHistoryModel


class DeviceModel(Base, TimestampMixin):
    """SQLAlchemy ORM model for devices."""

    __tablename__ = "devices"

    id: Mapped[uuid.UUID] = mapped_column(
        primary_key=True,
        default=uuid.uuid4,
        nullable=False,
    )
    device_name: Mapped[str] = mapped_column(String(100), nullable=False)
    device_type: Mapped[DeviceType] = mapped_column(
        SQLEnum(DeviceType, native_enum=False, values_callable=lambda x: [e.value for e in x]),
        nullable=False,
    )

    # Relationships
    pairings_as_a: Mapped[list["PairingModel"]] = relationship(
        "PairingModel",
        foreign_keys="PairingModel.device_a_id",
        back_populates="device_a",
        lazy="selectin",
    )
    pairings_as_b: Mapped[list["PairingModel"]] = relationship(
        "PairingModel",
        foreign_keys="PairingModel.device_b_id",
        back_populates="device_b",
        lazy="selectin",
    )
    auth_tokens: Mapped[list["AuthTokenModel"]] = relationship(
        "AuthTokenModel",
        back_populates="device",
        lazy="selectin",
    )
    clipboard_history: Mapped[list["ClipboardHistoryModel"]] = relationship(
        "ClipboardHistoryModel",
        foreign_keys="ClipboardHistoryModel.device_id",
        back_populates="device",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<DeviceModel(id={self.id}, name={self.device_name}, type={self.device_type})>"