"""In-memory device registry service for Synk backend.

This service manages device registration and lookup without a database.
For production, this would be replaced with a persistent storage solution.
"""

import asyncio
import uuid
from typing import Optional

from app.models.device import Device, DeviceType, DeviceRegistrationRequest


class DeviceRegistry:
    """In-memory device registry with thread-safe operations."""

    def __init__(self) -> None:
        """Initialize the registry with an empty device store."""
        self._devices: dict[str, Device] = {}
        self._lock = asyncio.Lock()

    def _generate_device_id(self) -> str:
        """Generate a unique device ID using UUID4."""
        return str(uuid.uuid4())

    async def register(self, request: DeviceRegistrationRequest) -> Device:
        """Register a new device.

        Args:
            request: Device registration request with name and type.

        Returns:
            The registered device with generated device_id.
        """
        device_id = self._generate_device_id()
        device = Device(
            device_id=device_id,
            device_name=request.device_name,
            device_type=request.device_type,
        )

        async with self._lock:
            self._devices[device_id] = device

        return device

    async def get(self, device_id: str) -> Optional[Device]:
        """Retrieve a device by its ID.

        Args:
            device_id: The unique device identifier.

        Returns:
            The device if found, None otherwise.
        """
        async with self._lock:
            return self._devices.get(device_id)

    async def exists(self, device_id: str) -> bool:
        """Check if a device exists in the registry.

        Args:
            device_id: The unique device identifier.

        Returns:
            True if device exists, False otherwise.
        """
        async with self._lock:
            return device_id in self._devices

    async def list_devices(self) -> list[Device]:
        """List all registered devices.

        Returns:
            List of all devices.
        """
        async with self._lock:
            return list(self._devices.values())

    async def count(self) -> int:
        """Get the total number of registered devices.

        Returns:
            Number of devices in registry.
        """
        async with self._lock:
            return len(self._devices)

    async def clear(self) -> None:
        """Clear all devices from the registry. Primarily for testing."""
        async with self._lock:
            self._devices.clear()


# Global device registry instance
device_registry = DeviceRegistry()