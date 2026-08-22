"""Device repository for database operations."""

from typing import Optional
from uuid import UUID

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.db.models.device import DeviceModel


class DeviceRepository:
    """Repository for device database operations."""

    def __init__(self, session: AsyncSession) -> None:
        """Initialize with a database session.

        Args:
            session: Async SQLAlchemy session.
        """
        self._session = session

    async def create(
        self,
        device_name: str,
        device_type: str,
        device_id: Optional[UUID] = None,
    ) -> DeviceModel:
        """Create a new device.

        Args:
            device_name: Human-readable device name.
            device_type: Device type (mobile/desktop).
            device_id: Optional specific UUID (generated if not provided).

        Returns:
            Created DeviceModel.
        """
        device = DeviceModel(
            id=device_id,
            device_name=device_name,
            device_type=device_type,
        )
        self._session.add(device)
        await self._session.flush()
        await self._session.refresh(device)
        return device

    async def get(self, device_id: UUID) -> Optional[DeviceModel]:
        """Get a device by ID.

        Args:
            device_id: Device UUID.

        Returns:
            DeviceModel if found, None otherwise.
        """
        result = await self._session.execute(
            select(DeviceModel).where(DeviceModel.id == device_id)
        )
        return result.scalar_one_or_none()

    async def get_by_name(self, device_name: str) -> Optional[DeviceModel]:
        """Get a device by name.

        Args:
            device_name: Device name.

        Returns:
            DeviceModel if found, None otherwise.
        """
        result = await self._session.execute(
            select(DeviceModel).where(DeviceModel.device_name == device_name)
        )
        return result.scalar_one_or_none()

    async def exists(self, device_id: UUID) -> bool:
        """Check if a device exists.

        Args:
            device_id: Device UUID.

        Returns:
            True if device exists, False otherwise.
        """
        result = await self._session.execute(
            select(DeviceModel.id).where(DeviceModel.id == device_id)
        )
        return result.scalar_one_or_none() is not None

    async def list_all(self) -> list[DeviceModel]:
        """List all devices.

        Returns:
            List of all DeviceModel instances.
        """
        result = await self._session.execute(select(DeviceModel))
        return list(result.scalars().all())

    async def count(self) -> int:
        """Get total device count.

        Returns:
            Number of devices.
        """
        result = await self._session.execute(select(DeviceModel.id))
        return len(list(result.scalars().all()))

    async def delete(self, device_id: UUID) -> bool:
        """Delete a device.

        Args:
            device_id: Device UUID.

        Returns:
            True if deleted, False if not found.
        """
        device = await self.get(device_id)
        if device is None:
            return False
        await self._session.delete(device)
        await self._session.flush()
        return True