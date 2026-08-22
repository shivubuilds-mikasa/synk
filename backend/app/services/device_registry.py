"""Device registry service for Synk backend.

This service manages device registration and lookup using PostgreSQL.
"""

import asyncio
from typing import Optional

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import IntegrityError
from uuid import UUID

from app.db.database import database
from app.models.device import Device, DeviceType, DeviceRegistrationRequest
from app.repositories.device_repository import DeviceRepository
from app.services.auth_service import auth_service


class DeviceRegistry:
    """PostgreSQL-backed device registry."""

    def __init__(self) -> None:
        """Initialize the registry."""
        self._lock = asyncio.Lock()

    async def _get_session(self) -> AsyncSession:
        """Get a database session."""
        return database._session_factory()

    async def register(self, request: DeviceRegistrationRequest) -> tuple[Device, str]:
        """Register a new device and generate an authentication token.

        Args:
            request: Device registration request with name and type.

        Returns:
            Tuple of (Device, auth_token) where auth_token is the raw token
            that must be stored securely by the client. Only returned once.
        """
        async with self._lock:
            async with database.session() as session:
                repo = DeviceRepository(session)
                device_model = await repo.create(
                    device_name=request.device_name,
                    device_type=request.device_type.value,
                )
                # Create auth token for the device
                raw_token, _ = await auth_service.create_token(session, device_model.id)
                await session.commit()
                return self._model_to_device(device_model), raw_token

    async def get(self, device_id: str) -> Optional[Device]:
        """Retrieve a device by its ID.

        Args:
            device_id: The unique device identifier.

        Returns:
            The device if found, None otherwise.
        """
        # Validate UUID format before querying
        import uuid
        try:
            uuid.UUID(device_id)
        except ValueError:
            return None

        async with database.session() as session:
            repo = DeviceRepository(session)
            device_model = await repo.get(device_id)
            if device_model:
                return self._model_to_device(device_model)
            return None

    async def exists(self, device_id: str) -> bool:
        """Check if a device exists in the registry.

        Args:
            device_id: The unique device identifier.

        Returns:
            True if device exists, False otherwise.
        """
        # Validate UUID format before querying
        import uuid
        try:
            uuid.UUID(device_id)
        except ValueError:
            return False

        async with database.session() as session:
            repo = DeviceRepository(session)
            return await repo.exists(device_id)

    async def list_devices(self) -> list[Device]:
        """List all registered devices.

        Returns:
            List of all devices.
        """
        async with database.session() as session:
            repo = DeviceRepository(session)
            models = await repo.list_all()
            return [self._model_to_device(m) for m in models]

    async def count(self) -> int:
        """Get the total number of registered devices.

        Returns:
            Number of devices in registry.
        """
        async with database.session() as session:
            repo = DeviceRepository(session)
            return await repo.count()

    async def clear(self) -> None:
        """Clear all devices from the registry. Primarily for testing."""
        # Note: This is only used in tests. In production, don't clear the DB.
        async with database.session() as session:
            repo = DeviceRepository(session)
            devices = await repo.list_all()
            for device in devices:
                await repo.delete(device.id)
            await session.commit()

    @staticmethod
    def _model_to_device(model) -> Device:
        """Convert SQLAlchemy model to Pydantic Device."""
        return Device(
            device_id=str(model.id),
            device_name=model.device_name,
            device_type=model.device_type,
        )


# Global device registry instance
device_registry = DeviceRegistry()