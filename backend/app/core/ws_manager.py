"""WebSocket connection manager for handling client connections."""

import asyncio
import json
import logging
from typing import Dict, Set

from fastapi import WebSocket

logger = logging.getLogger(__name__)


class ConnectionManager:
    """Manages WebSocket connections for the Synk backend."""

    def __init__(self) -> None:
        """Initialize the connection manager."""
        # Map of device_id to set of WebSocket connections
        self._active_connections: Dict[str, Set[WebSocket]] = {}
        self._lock = asyncio.Lock()

    async def connect(self, device_id: str, websocket: WebSocket) -> None:
        """Accept a new WebSocket connection and track it.

        Args:
            device_id: Unique identifier for the connecting device.
            websocket: The WebSocket connection to accept.
        """
        await websocket.accept()
        async with self._lock:
            if device_id not in self._active_connections:
                self._active_connections[device_id] = set()
            self._active_connections[device_id].add(websocket)
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

    async def broadcast(self, message: dict, exclude_device: str | None = None) -> int:
        """Broadcast a message to all connected devices.

        Args:
            message: Dictionary to send as JSON.
            exclude_device: Optional device_id to exclude from broadcast.

        Returns:
            Number of devices that received the message.
        """
        async with self._lock:
            devices = {k: v.copy() for k, v in self._active_connections.items()}

        if exclude_device:
            devices.pop(exclude_device, None)

        message_json = json.dumps(message)
        success_count = 0

        for device_id, connections in devices.items():
            for websocket in connections:
                try:
                    await websocket.send_text(message_json)
                    success_count += 1
                except Exception as e:
                    logger.error(f"Failed to broadcast to {device_id}: {e}")
                    await self.disconnect(device_id, websocket)

        return success_count

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


# Global connection manager instance
manager = ConnectionManager()