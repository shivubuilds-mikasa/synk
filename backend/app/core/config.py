"""Application configuration, sourced from environment variables and .env.

Settings are read from the process environment first, then from a `.env`
file in the backend directory (when running from there). Adding a new
setting here automatically exposes it via environment variables, so future
features (auth, database, pairing, etc.) can extend this without changes.
"""

from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import field_validator


class Settings(BaseSettings):
    """Application settings."""

    APP_NAME: str = "synk-backend"
    ENVIRONMENT: str = "development"
    DEBUG: bool = False
    DATABASE_URL: str = "postgresql+asyncpg://synk:synk@localhost:5432/synk"

    @field_validator("DATABASE_URL", mode="before")
    @classmethod
    def use_asyncpg_driver(cls, value: str) -> str:
        """Render provides a standard PostgreSQL URL; SQLAlchemy needs asyncpg."""
        if value.startswith("postgres://"):
            return "postgresql+asyncpg://" + value.removeprefix("postgres://")
        if value.startswith("postgresql://"):
            return "postgresql+asyncpg://" + value.removeprefix("postgresql://")
        return value

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
    )


settings = Settings()
