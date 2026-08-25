"""WebSocket connection manager for handling client connections."""

import asyncio
import json
import logging
from typing import Dict, Set

from fastapi import WebSocket

from app.models.sync import SyncMessageType, ClipboardUpdateRelayMessage, PongMessage, ErrorMessage, AckMessage, create_error_message, create_ack_message
from app.services.pairing_registry import pairing_registry

logger = logging.getLogger(__name__)


class ConnectionManager:
    """Manages WebSocket connections for the Synk backend."""

    def __init__(self) -> None:
        """Initialize the connection manager."""
        # Map of device_id to set of WebSocket connections
        self._active_connections: Dict[str, Set[WebSocket]] = {}
        # Map of websocket to device_id for quick lookup
        self._websocket_to_device: Dict[WebSocket, str] = {}
        self._lock = asyncio.Lock()

    async def connect(self, device_id: str, websocket: WebSocket) -> None:
        """Track an already-accepted WebSocket connection.

        Args:
            device_id: Unique identifier for the connecting device.
            websocket: The WebSocket connection (must already be accepted).
        """
        async with self._lock:
            if device_id not in self._active_connections:
                self._active_connections[device_id] = set()
            self._active_connections[device_id].add(websocket)
            self._websocket_to_device[websocket] = device_id
        logger.info(f"Device {device_id} connected. Active connections for device: {len(self._active_connections[device_id])}")

    async def disconnect(self, device_id: str, websocket: WebSocket) -> None:
        """Remove a WebSocket connection from tracking.

        Args:
            device_id: Unique identifier for the device.
            websocket: The WebSocket connection to remove.
        """
        async with self._lock:
            if device_id in self._active_connections:
                self._active_connections[device_id].discard(websocket)
                if not self._active_connections[device_id]:
                    del self._active_connections[device_id]
            self._websocket_to_device.pop(websocket, None)
        logger.info(f"Device {device_id} disconnected. Remaining connections for device: {len(self._active_connections.get(device_id, set()))}")

    async def send_personal_message(self, device_id: str, message: dict) -> bool:
        """Send a message to a specific device.

        Args:
            device_id: Target device identifier.
            message: Dictionary to send as JSON.

        Returns:
            True if at least one connection received the message, False otherwise.
        """
        async with self._lock:
            connections = self._active_connections.get(device_id, set()).copy()

        if not connections:
            logger.warning(f"No active connections for device {device_id}")
            return False

        message_json = json.dumps(message)
        success = False
        for websocket in connections:
            try:
                await websocket.send_text(message_json)
                success = True
            except Exception as e:
                logger.error(f"Failed to send message to {device_id}: {e}")
                # Clean up broken connection
                await self.disconnect(device_id, websocket)

        return success

    async def send_to_paired_devices(
        self,
        source_device_id: str,
        message: dict,
    ) -> int:
        """Send a message to all devices paired with the source device.

        Args:
            source_device_id: The device that originated the message.
            message: Dictionary to send as JSON.

        Returns:
            Number of paired devices that received the message.
        """
        paired_devices = await pairing_registry.get_paired_devices(source_device_id)
        if not paired_devices:
            logger.info(f"No paired devices for {source_device_id} to relay message")
            return 0

        paired_device_ids = [p.device_id for p in paired_devices]
        logger.info(f"Relaying message from {source_device_id} to paired devices: {paired_device_ids}")

        success_count = 0
        for target_device_id in paired_device_ids:
            if await self.send_personal_message(target_device_id, message):
                success_count += 1

        return success_count

    def get_device_id(self, websocket: WebSocket) -> str | None:
        """Get the device_id associated with a websocket.

        Args:
            websocket: The WebSocket connection.

        Returns:
            The device_id if found, None otherwise.
        """
        return self._websocket_to_device.get(websocket)

    def get_connection_count(self, device_id: str | None = None) -> int:
        """Get the number of active connections.

        Args:
            device_id: Optional specific device to count connections for.
                       If None, returns total connections across all devices.

        Returns:
            Number of active connections.
        """
        if device_id:
            return len(self._active_connections.get(device_id, set()))
        return sum(len(conns) for conns in self._active_connections.values())

    def is_connected(self, device_id: str) -> bool:
        """Check if a device has any active connections.

        Args:
            device_id: Device identifier to check.

        Returns:
            True if device has active connections, False otherwise.
        """
        return device_id in self._active_connections and len(self._active_connections[device_id]) > 0

    async def broadcast(self, message: dict, exclude_device: str | None = None) -> int:
        """Broadcast a message to all connected devices.

        Args:
            message: Dictionary to send as JSON.
            exclude_device: Optional device_id to exclude from broadcast.

        Returns:
            Number of devices that received the message.
        """
        async with self._lock:
            device_ids = list(self._active_connections.keys())
            if exclude_device:
                device_ids = [d for d in device_ids if d != exclude_device]

        success_count = 0
        for device_id in device_ids:
            if await self.send_personal_message(device_id, message):
                success_count += 1

        return success_count


# Global connection manager instance
manager = ConnectionManager()