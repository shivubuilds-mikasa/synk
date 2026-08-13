"""Application configuration, sourced from environment variables and .env.

Settings are read from the process environment first, then from a `.env`
file in the backend directory (when running from there). Adding a new
setting here automatically exposes it via environment variables, so future
features (auth, database, pairing, etc.) can extend this without changes.
"""

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Application settings."""

    APP_NAME: str = "synk-backend"
    ENVIRONMENT: str = "development"
    DEBUG: bool = False

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
    )


settings = Settings()
