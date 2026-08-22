"""Database connection and session management for Synk backend."""

from contextlib import asynccontextmanager
from typing import AsyncGenerator

from sqlalchemy.ext.asyncio import (
    AsyncEngine,
    AsyncSession,
    async_sessionmaker,
    create_async_engine,
)

from app.core.config import settings


class Database:
    """Database connection manager."""

    def __init__(self, database_url: str) -> None:
        """Initialize the database connection.

        Args:
            database_url: SQLAlchemy async database URL.
        """
        self._engine: AsyncEngine = create_async_engine(
            database_url,
            echo=settings.DEBUG,
            pool_pre_ping=True,
        )
        self._session_factory = async_sessionmaker(
            self._engine,
            class_=AsyncSession,
            expire_on_commit=False,
            autoflush=False,
        )

    @property
    def engine(self) -> AsyncEngine:
        """Get the async engine."""
        return self._engine

    @asynccontextmanager
    async def session(self) -> AsyncGenerator[AsyncSession, None]:
        """Provide a transactional session.

        Usage:
            async with database.session() as session:
                # use session
        """
        async with self._session_factory() as session:
            try:
                yield session
                await session.commit()
            except Exception:
                await session.rollback()
                raise
            finally:
                await session.close()

    async def close(self) -> None:
        """Close the database connection pool."""
        await self._engine.dispose()


# Global database instance
database = Database(settings.DATABASE_URL)


async def get_db() -> AsyncGenerator[AsyncSession, None]:
    """FastAPI dependency for database sessions.

    Usage:
        @app.get("/devices")
        async def get_devices(db: AsyncSession = Depends(get_db)):
            ...
    """
    async with database.session() as session:
        yield session