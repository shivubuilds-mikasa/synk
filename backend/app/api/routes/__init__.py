"""HTTP route modules for the Synk backend."""

from app.api.routes import devices, health, websocket

__all__ = ["devices", "health", "websocket"]