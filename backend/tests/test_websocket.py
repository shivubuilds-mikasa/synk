"""Tests for WebSocket functionality."""

import json
import pytest
from httpx import AsyncClient
from starlette.testclient import TestClient
from starlette.websockets import WebSocketDisconnect

from app.main import app
from app.core.ws_manager import manager, ConnectionManager


@pytest.fixture(autouse=True)
async def clear_manager():
    """Clear the connection manager before each test."""
    # Create a fresh manager for each test
    manager._active_connections.clear()
    yield
    manager._active_connections.clear()


def test_websocket_connection():
    """Test basic WebSocket connection and disconnection."""
    with TestClient(app) as client:
        with client.websocket_connect("/ws/test-device-1") as websocket:
            # Connection should be established
            assert manager.is_connected("test-device-1")
            assert manager.get_connection_count("test-device-1") == 1


def test_websocket_message_echo():
    """Test sending a message and receiving an echo response."""
    with TestClient(app) as client:
        with client.websocket_connect("/ws/test-device-2") as websocket:
            # Send a JSON message
            test_message = {"action": "test", "data": "hello"}
            websocket.send_text(json.dumps(test_message))

            # Receive the echo response
            response_text = websocket.receive_text()
            response = json.loads(response_text)

            # Verify the response format
            assert response["type"] == "echo"
            assert response["original"] == test_message
            assert response["device_id"] == "test-device-2"
            assert "timestamp" in response


def test_websocket_multiple_messages():
    """Test sending multiple messages in sequence."""
    with TestClient(app) as client:
        with client.websocket_connect("/ws/test-device-3") as websocket:
            for i in range(3):
                test_message = {"sequence": i, "data": f"message-{i}"}
                websocket.send_text(json.dumps(test_message))

                response_text = websocket.receive_text()
                response = json.loads(response_text)

                assert response["type"] == "echo"
                assert response["original"] == test_message
                assert response["device_id"] == "test-device-3"


def test_websocket_invalid_json():
    """Test handling of invalid JSON messages."""
    with TestClient(app) as client:
        with client.websocket_connect("/ws/test-device-4") as websocket:
            # Send invalid JSON
            websocket.send_text("not valid json")

            # Receive error response
            response_text = websocket.receive_text()
            response = json.loads(response_text)

            assert response["type"] == "error"
            assert "Invalid JSON format" in response["message"]
            assert response["received"] == "not valid json"


def test_websocket_normal_disconnect():
    """Test normal WebSocket disconnection."""
    with TestClient(app) as client:
        with client.websocket_connect("/ws/test-device-5") as websocket:
            assert manager.is_connected("test-device-5")
            assert manager.get_connection_count("test-device-5") == 1

        # After context exit, connection should be closed
        assert not manager.is_connected("test-device-5")
        assert manager.get_connection_count("test-device-5") == 0


def test_websocket_multiple_devices():
    """Test multiple devices connecting simultaneously."""
    with TestClient(app) as client:
        with client.websocket_connect("/ws/device-a") as ws_a:
            with client.websocket_connect("/ws/device-b") as ws_b:
                assert manager.is_connected("device-a")
                assert manager.is_connected("device-b")
                assert manager.get_connection_count("device-a") == 1
                assert manager.get_connection_count("device-b") == 1
                assert manager.get_connection_count() == 2


def test_websocket_multiple_connections_same_device():
    """Test multiple connections from the same device_id."""
    with TestClient(app) as client:
        with client.websocket_connect("/ws/multi-device") as ws1:
            with client.websocket_connect("/ws/multi-device") as ws2:
                assert manager.get_connection_count("multi-device") == 2

        # Both connections should be cleaned up
        assert manager.get_connection_count("multi-device") == 0


def test_connection_manager_send_personal_message():
    """Test ConnectionManager.send_personal_message directly."""
    # This test uses a fresh manager instance
    test_manager = ConnectionManager()

    # Mock WebSocket for testing
    class MockWebSocket:
        def __init__(self):
            self.sent_messages = []
            self.closed = False

        async def accept(self):
            pass

        async def send_text(self, data: str):
            self.sent_messages.append(data)

        async def close(self):
            self.closed = True

    import asyncio

    async def run_test():
        ws = MockWebSocket()
        await test_manager.connect("test-device", ws)

        # Send a message
        message = {"type": "test", "content": "direct"}
        result = await test_manager.send_personal_message("test-device", message)

        assert result is True
        assert len(ws.sent_messages) == 1
        sent = json.loads(ws.sent_messages[0])
        assert sent == message

        # Test sending to non-existent device
        result = await test_manager.send_personal_message("non-existent", message)
        assert result is False

    asyncio.run(run_test())


def test_connection_manager_broadcast():
    """Test ConnectionManager.broadcast directly."""
    test_manager = ConnectionManager()

    class MockWebSocket:
        def __init__(self, name):
            self.name = name
            self.sent_messages = []

        async def accept(self):
            pass

        async def send_text(self, data: str):
            self.sent_messages.append(data)

    import asyncio

    async def run_test():
        ws1 = MockWebSocket("ws1")
        ws2 = MockWebSocket("ws2")
        ws3 = MockWebSocket("ws3")

        await test_manager.connect("device-1", ws1)
        await test_manager.connect("device-2", ws2)
        await test_manager.connect("device-3", ws3)

        message = {"broadcast": True, "data": "test"}
        count = await test_manager.broadcast(message)

        assert count == 3
        assert len(ws1.sent_messages) == 1
        assert len(ws2.sent_messages) == 1
        assert len(ws3.sent_messages) == 1

        # Verify all received the same message
        for ws in [ws1, ws2, ws3]:
            sent = json.loads(ws.sent_messages[0])
            assert sent == message

    asyncio.run(run_test())


def test_connection_manager_broadcast_exclude():
    """Test ConnectionManager.broadcast with exclude_device."""
    test_manager = ConnectionManager()

    class MockWebSocket:
        def __init__(self, name):
            self.name = name
            self.sent_messages = []

        async def accept(self):
            pass

        async def send_text(self, data: str):
            self.sent_messages.append(data)

    import asyncio

    async def run_test():
        ws1 = MockWebSocket("ws1")
        ws2 = MockWebSocket("ws2")

        await test_manager.connect("device-1", ws1)
        await test_manager.connect("device-2", ws2)

        message = {"broadcast": True}
        count = await test_manager.broadcast(message, exclude_device="device-1")

        assert count == 1
        assert len(ws1.sent_messages) == 0  # Excluded
        assert len(ws2.sent_messages) == 1

    asyncio.run(run_test())


def test_connection_manager_get_connection_count():
    """Test ConnectionManager.get_connection_count."""
    test_manager = ConnectionManager()

    class MockWebSocket:
        async def accept(self):
            pass
        async def send_text(self, data):
            pass

    import asyncio

    async def run_test():
        ws1 = MockWebSocket()
        ws2 = MockWebSocket()
        ws3 = MockWebSocket()

        assert test_manager.get_connection_count() == 0
        assert test_manager.get_connection_count("device-1") == 0

        await test_manager.connect("device-1", ws1)
        assert test_manager.get_connection_count() == 1
        assert test_manager.get_connection_count("device-1") == 1

        await test_manager.connect("device-1", ws2)
        assert test_manager.get_connection_count() == 2
        assert test_manager.get_connection_count("device-1") == 2

        await test_manager.connect("device-2", ws3)
        assert test_manager.get_connection_count() == 3
        assert test_manager.get_connection_count("device-2") == 1

        await test_manager.disconnect("device-1", ws1)
        assert test_manager.get_connection_count() == 2
        assert test_manager.get_connection_count("device-1") == 1

        await test_manager.disconnect("device-1", ws2)
        assert test_manager.get_connection_count() == 1
        assert test_manager.get_connection_count("device-1") == 0

    asyncio.run(run_test())