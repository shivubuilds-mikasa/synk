"""Pytest configuration for Synk backend tests."""

import os
hfhyftgfdtg
from typing import AsyncGenerator

import pytest
import pytest_asyncio
from httpx import AsyncClient, ASGITransport
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine

from app.main import app
from app.db.database import database
from app.db.models import Base
from app.core.config import settings
from app.core.ws_manager import manager

# Ensure pytest-asyncio is configured
pytest_plugins = ["pytest_asyncio"]


# Test database URL - use the same PostgreSQL instance on port 5432
# Override via environment variable for CI
TEST_DATABASE_URL = os.getenv(
    "TEST_DATABASE_URL",
    "postgresql+asyncpg://synk:synk@localhost:5432/synk_test",
)


@pytest.fixture(scope="function")
async def test_engine():
    """Create a test database engine per test to avoid event loop issues."""
    engine = create_async_engine(TEST_DATABASE_URL, echo=False, pool_pre_ping=False)
    yield engine
    await engine.dispose()


@pytest.fixture(scope="function")
async def test_db_setup(test_engine):
    """Set up the test database schema."""
    async with test_engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
        await conn.run_sync(Base.metadata.create_all)
    yield
    async with test_engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)


@pytest.fixture
async def db_session(test_engine, test_db_setup) -> AsyncGenerator[AsyncSession, None]:
    """Provide a transactional database session for each test."""
    async with test_engine.connect() as conn:
        trans = await conn.begin()
        session_factory = async_sessionmaker(
            bind=conn,
            class_=AsyncSession,
            expire_on_commit=False,
            autoflush=False,
        )
        async with session_factory() as session:
            yield session
        await trans.rollback()


@pytest.fixture(autouse=True)
async def override_database(db_session):
    """Override the global database instance for tests.

    This ensures that services using database.session() will use the test database.
    """
    # Store original engine and session_factory
    original_engine = database._engine
    original_session_factory = database._session_factory

    # Create new session factory bound to test connection
    test_session_factory = async_sessionmaker(
        bind=db_session.bind,
        class_=AsyncSession,
        expire_on_commit=False,
        autoflush=False,
    )

    # Replace database's session_factory
    database._session_factory = test_session_factory
    database._engine = db_session.bind.engine

    yield

    # Restore original
    database._engine = original_engine
    database._session_factory = original_session_factory


@pytest.fixture(autouse=True)
async def override_get_db(db_session):
    """Override the get_db dependency for tests."""
    from app.db.database import get_db

    async def _get_test_db():
        yield db_session

    app.dependency_overrides[get_db] = _get_test_db
    yield
    app.dependency_overrides.clear()


@pytest.fixture
async def async_client(db_session) -> AsyncGenerator[AsyncClient, None]:
    """Create an async test client that depends on db_session to ensure proper event loop."""
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
        yield client


@pytest.fixture(autouse=True)
async def clear_registries():
    """Clear in-memory registries before each test."""
    from app.services.device_registry import device_registry
    from app.services.pairing_registry import pairing_registry

    # Clear in-memory pending pairings
    pairing_registry._pending_pairings.clear()
    yield
    # Clear again after test
    pairing_registry._pending_pairings.clear()


@pytest.fixture
async def registered_device(async_client):
    """Register a test device and return its info."""
    response = await async_client.post(
        "/api/v1/devices/register",
        json={"device_name": "Test Device", "device_type": "mobile"},
    )
    assert response.status_code == 201
    return response.json()


@pytest.fixture
def auth_headers(registered_device):
    """Return auth headers for the registered device."""
    return {"Authorization": f"Bearer {registered_device['auth_token']}"}


@pytest.fixture
async def ws_client(registered_device):
    """Create a WebSocket connection for testing."""
    from httpx import ASGITransport, AsyncClient
    import websockets

    # For now, return a mock - we'll use direct manager testing for clipboard tests
    # Actual WS integration tests would need a running server
    class MockWSClient:
        def __init__(self):
            self.device_id = registered_device["device_id"]
            self.auth_token = registered_device["auth_token"]
            self.messages = []

        async def send_json(self, data):
            # Directly call the websocket handler logic
            pass

        async def receive_json(self):
            return {}

    return MockWSClient()
