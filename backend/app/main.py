"""Synk backend FastAPI application entry point."""

from contextlib import asynccontextmanager

from fastapi import FastAPI

from app.api.routes import devices, health, pairing, websocket, clipboard
from app.core.config import settings
from app.db.database import database


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Application lifespan manager."""
    # Startup
    yield
    # Shutdown
    await database.close()


app = FastAPI(title=settings.APP_NAME, version="0.1.0", lifespan=lifespan)

app.include_router(health.router)
app.include_router(devices.router)
app.include_router(pairing.router)
app.include_router(websocket.router)
app.include_router(clipboard.router)
