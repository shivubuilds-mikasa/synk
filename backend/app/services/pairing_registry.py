"""Pairing registry service for Synk backend.

This service manages device pairing using temporary 6-digit codes
with expiration and one-time use. Pairing relationships are persisted
in PostgreSQL. All business logic is contained here, separate from API routes.
"""

import asyncio
import secrets
import time
from dataclasses import dataclass, field
from typing import Optional
from uuid import UUID

from sqlalchemy.ext.asyncio import AsyncSession

from app.db.database import database
from app.models.device import Device
from app.models.pairing import PairedDeviceInfo
from app.repositories.pairing_repository import PairingRepository
from app.services.device_registry import device_registry


@dataclass
class PendingPairing:
    """Represents a pending pairing request waiting for confirmation."""

    code: str
    initiator_device_id: str
    initiator_device: Device
    created_at: float = field(default_factory=time.time)
    expires_at: float = field(default_factory=lambda: time.time() + 300)  # 5 minutes
    consumed: bool = False

    def is_expired(self) -> bool:
        """Check if the pairing code has expired."""
        return time.time() > self.expires_at

    def is_valid(self) -> bool:
        """Check if the pairing request is still valid (not expired, not consumed)."""
        return not self.consumed and not self.is_expired()


class PairingRegistry:
    """Pairing registry with thread-safe operations.

    Manages:
    - Pending pairing requests with 6-digit codes (in-memory, temporary)
    - Expiration of pairing codes (5 minutes)
    - One-time use of pairing codes
    - Pairing relationships between devices (persisted in PostgreSQL)
    """

    # 5 minutes in seconds
    PAIRING_CODE_TTL = 300
    PAIRING_CODE_LENGTH = 6

    def __init__(self) -> None:
        """Initialize the registry with empty stores."""
        self._pending_pairings: dict[str, PendingPairing] = {}
        self._lock = asyncio.Lock()

    def _generate_code(self) -> str:
        """Generate a secure random 6-digit pairing code.

        Uses secrets module for cryptographically secure random numbers.
        Returns exactly 6 numeric digits (000000-999999).
        """
        # Generate a random number between 0 and 999999, zero-padded to 6 digits
        return f"{secrets.randbelow(10**self.PAIRING_CODE_LENGTH):0{self.PAIRING_CODE_LENGTH}d}"

    async def create_pairing_request(self, device_id: str) -> PendingPairing:
        """Create a new pairing request for the given device.

        Args:
            device_id: ID of the device requesting a pairing code.

        Returns:
            PendingPairing with generated code and expiration info.

        Raises:
            ValueError: If device does not exist.
        """
        # Verify device exists
        device = await device_registry.get(device_id)
        if device is None:
            raise ValueError(f"Device with ID '{device_id}' not found")

        async with self._lock:
            # Generate a unique code (retry if collision)
            code = self._generate_code()
            while code in self._pending_pairings:
                code = self._generate_code()

            # Create pending pairing
            pending = PendingPairing(
                code=code,
                initiator_device_id=device_id,
                initiator_device=device,
            )
            self._pending_pairings[code] = pending

            return pending

    async def confirm_pairing(self, device_id: str, code: str) -> tuple[Device, Device]:
        """Confirm a pairing using the provided code.

        Args:
            device_id: ID of the device confirming the pairing.
            code: 6-digit pairing code.

        Returns:
            Tuple of (initiator_device, confirming_device) representing the pairing.

        Raises:
            ValueError: If device doesn't exist, code is invalid/expired/used,
                       device tries to pair with itself, or devices already paired.
        """
        # Verify confirming device exists
        confirming_device = await device_registry.get(device_id)
        if confirming_device is None:
            raise ValueError(f"Device with ID '{device_id}' not found")

        async with self._lock:
            # Find the pending pairing
            pending = self._pending_pairings.get(code)
            if pending is None:
                raise ValueError("Invalid or expired pairing code")

            # Check if code is valid (not expired, not consumed)
            if not pending.is_valid():
                # Clean up expired/consumed codes
                if pending.consumed:
                    raise ValueError("Pairing code has already been used")
                if pending.is_expired():
                    del self._pending_pairings[code]
                    raise ValueError("Pairing code has expired")

            # Prevent self-pairing
            if pending.initiator_device_id == device_id:
                raise ValueError("A device cannot pair with itself")

            # Check for duplicate pairing in database
            async with database.session() as session:
                repo = PairingRepository(session)
                already_paired = await repo.are_paired(
                    UUID(pending.initiator_device_id),
                    UUID(device_id),
                )
                if already_paired:
                    raise ValueError("These devices are already paired")

                # Create the pairing relationship in database
                await repo.create(
                    UUID(pending.initiator_device_id),
                    UUID(device_id),
                )
                await session.commit()

            # Mark the code as consumed (keep in registry to detect reuse)
            pending.consumed = True

            return pending.initiator_device, confirming_device

    async def get_paired_devices(self, device_id: str) -> list[PairedDeviceInfo]:
        """Get all devices paired with the given device.

        Args:
            device_id: ID of the device to get pairings for.

        Returns:
            List of PairedDeviceInfo for each paired device.

        Raises:
            ValueError: If device does not exist.
        """
        # Verify device exists
        device = await device_registry.get(device_id)
        if device is None:
            raise ValueError(f"Device with ID '{device_id}' not found")

        async with database.session() as session:
            repo = PairingRepository(session)
            paired_devices = await repo.get_paired_devices(UUID(device_id))

            return [
                PairedDeviceInfo(
                    device_id=str(p.id),
                    device_name=p.device_name,
                    device_type=p.device_type.value,
                )
                for p in paired_devices
            ]

    async def are_paired(self, device_id_1: str, device_id_2: str) -> bool:
        """Check if two devices are paired with each other.

        Args:
            device_id_1: First device ID.
            device_id_2: Second device ID.

        Returns:
            True if devices are paired, False otherwise.
        """
        async with database.session() as session:
            repo = PairingRepository(session)
            return await repo.are_paired(UUID(device_id_1), UUID(device_id_2))

    async def clear(self) -> None:
        """Clear all pairings and pending requests. Primarily for testing."""
        async with self._lock:
            self._pending_pairings.clear()
            # Also clear database pairings (for testing only)
            async with database.session() as session:
                repo = PairingRepository(session)
                pairings = await repo.list_all()
                for pairing in pairings:
                    await repo.delete(pairing.device_a_id, pairing.device_b_id)
                await session.commit()

    async def cleanup_expired(self) -> int:
        """Remove expired pending pairing requests.

        Returns:
            Number of expired requests removed.
        """
        async with self._lock:
            expired_codes = [
                code for code, pending in self._pending_pairings.items()
                if pending.is_expired()
            ]
            for code in expired_codes:
                del self._pending_pairings[code]
            return len(expired_codes)


# Global pairing registry instance
pairing_registry = PairingRegistry()