"""Synk backend FastAPI application entry point."""

from fastapi import FastAPI

from app.api.routes import devices, health, pairing, websocket
from app.core.config import settings

app = FastAPI(title=settings.APP_NAME, version="0.1.0")

app.include_router(health.router)
app.include_router(devices.router)
app.include_router(pairing.router)
app.include_router(websocket.router)
