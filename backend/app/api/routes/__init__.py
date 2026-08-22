"""HTTP route modules for the Synk backend."""

from app.api.routes import devices, health, pairing, websocket

__all__ = ["devices", "health", "pairing", "websocket"]