"""Pytest configuration for Synk backend tests."""

import pytest
import pytest_asyncio

# Ensure pytest-asyncio is configured
pytest_plugins = ["pytest_asyncio"]


@pytest.fixture(scope="session")
def event_loop():
    """Create an event loop for the test session."""
    import asyncio

    loop = asyncio.new_event_loop()
    yield loop
    loop.close()