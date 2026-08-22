"""Pairing repository for database operations."""

from typing import Optional
from uuid import UUID

from sqlalchemy import select, or_, and_
from sqlalchemy.ext.asyncio import AsyncSession

from app.db.models.device import DeviceModel
from app.db.models.pairing import PairingModel


class PairingRepository:
    """Repository for pairing database operations."""

    def __init__(self, session: AsyncSession) -> None:
        """Initialize with a database session.

        Args:
            session: Async SQLAlchemy session.
        """
        self._session = session

    @staticmethod
    def _normalize_device_ids(device_a_id: UUID, device_b_id: UUID) -> tuple[UUID, UUID]:
        """Normalize device IDs so device_a_id < device_b_id.

        Args:
            device_a_id: First device UUID.
            device_b_id: Second device UUID.

        Returns:
            Tuple of (smaller_id, larger_id).
        """
        if device_a_id < device_b_id:
            return device_a_id, device_b_id
        return device_b_id, device_a_id

    async def create(self, device_a_id: UUID, device_b_id: UUID) -> PairingModel:
        """Create a new pairing between two devices.

        Args:
            device_a_id: First device UUID.
            device_b_id: Second device UUID.

        Returns:
            Created PairingModel.

        Raises:
            ValueError: If devices are the same or already paired.
        """
        if device_a_id == device_b_id:
            raise ValueError("A device cannot pair with itself")

        # Normalize for consistent storage
        a_id, b_id = self._normalize_device_ids(device_a_id, device_b_id)

        # Check if already paired
        existing = await self.get_pairing(a_id, b_id)
        if existing:
            raise ValueError("These devices are already paired")

        pairing = PairingModel(device_a_id=a_id, device_b_id=b_id)
        self._session.add(pairing)
        await self._session.flush()
        await self._session.refresh(pairing)
        return pairing

    async def get_pairing(self, device_a_id: UUID, device_b_id: UUID) -> Optional[PairingModel]:
        """Get a specific pairing between two devices.

        Args:
            device_a_id: First device UUID.
            device_b_id: Second device UUID.

        Returns:
            PairingModel if found, None otherwise.
        """
        a_id, b_id = self._normalize_device_ids(device_a_id, device_b_id)
        result = await self._session.execute(
            select(PairingModel).where(
                and_(
                    PairingModel.device_a_id == a_id,
                    PairingModel.device_b_id == b_id,
                )
            )
        )
        return result.scalar_one_or_none()

    async def get_paired_devices(self, device_id: UUID) -> list[DeviceModel]:
        """Get all devices paired with the given device.

        Args:
            device_id: Device UUID.

        Returns:
            List of paired DeviceModel instances.
        """
        # Find pairings where device is either device_a or device_b
        result = await self._session.execute(
            select(PairingModel).where(
                or_(
                    PairingModel.device_a_id == device_id,
                    PairingModel.device_b_id == device_id,
                )
            )
        )
        pairings = list(result.scalars().all())

        paired_devices = []
        for pairing in pairings:
            other = pairing.get_other_device(device_id)
            if other:
                paired_devices.append(other)

        return paired_devices

    async def are_paired(self, device_a_id: UUID, device_b_id: UUID) -> bool:
        """Check if two devices are paired.

        Args:
            device_a_id: First device UUID.
            device_b_id: Second device UUID.

        Returns:
            True if paired, False otherwise.
        """
        pairing = await self.get_pairing(device_a_id, device_b_id)
        return pairing is not None

    async def delete(self, device_a_id: UUID, device_b_id: UUID) -> bool:
        """Delete a pairing between two devices.

        Args:
            device_a_id: First device UUID.
            device_b_id: Second device UUID.

        Returns:
            True if deleted, False if not found.
        """
        pairing = await self.get_pairing(device_a_id, device_b_id)
        if pairing is None:
            return False
        await self._session.delete(pairing)
        await self._session.flush()
        return True

    async def list_all(self) -> list[PairingModel]:
        """List all pairings.

        Returns:
            List of all PairingModel instances.
        """
        result = await self._session.execute(select(PairingModel))
        return list(result.scalars().all())

    async def count(self) -> int:
        """Get total pairing count.

        Returns:
            Number of pairings.
        """
        result = await self._session.execute(select(PairingModel.id))
        return len(list(result.scalars().all()))