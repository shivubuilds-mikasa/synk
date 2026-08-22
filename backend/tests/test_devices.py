"""Tests for Device Registration API."""

import json
import pytest
from httpx import AsyncClient, ASGITransport

from app.main import app
from app.services.device_registry import device_registry
from app.models.device import DeviceType


class TestDeviceRegistration:
    """Tests for POST /api/v1/devices/register."""

    @pytest.mark.asyncio
    async def test_register_mobile_device(self, async_client):
        """Test successful mobile device registration."""
        response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Shivu's Phone", "device_type": "mobile"},
        )

        assert response.status_code == 201
        data = response.json()

        assert "device_id" in data
        assert len(data["device_id"]) > 0
        assert data["device_name"] == "Shivu's Phone"
        assert data["device_type"] == "mobile"
        assert "auth_token" in data
        assert data["auth_token"].startswith("synk_")
        assert len(data["auth_token"]) == 69  # synk_ + 64 hex chars

        # Verify device is actually stored
        stored = await device_registry.get(data["device_id"])
        assert stored is not None
        assert stored.device_name == "Shivu's Phone"
        assert stored.device_type == DeviceType.MOBILE

    @pytest.mark.asyncio
    async def test_register_desktop_device(self, async_client):
        """Test successful desktop device registration."""
        response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Work Laptop", "device_type": "desktop"},
        )

        assert response.status_code == 201
        data = response.json()

        assert "device_id" in data
        assert len(data["device_id"]) > 0
        assert data["device_name"] == "Work Laptop"
        assert data["device_type"] == "desktop"
        assert "auth_token" in data
        assert data["auth_token"].startswith("synk_")
        assert len(data["auth_token"]) == 69

        # Verify device is actually stored
        stored = await device_registry.get(data["device_id"])
        assert stored is not None
        assert stored.device_name == "Work Laptop"
        assert stored.device_type == DeviceType.DESKTOP

    @pytest.mark.asyncio
    async def test_generated_unique_device_ids(self, async_client):
        """Test that each registration generates a unique device_id."""
        response1 = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device 1", "device_type": "mobile"},
        )
        response2 = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device 2", "device_type": "mobile"},
        )
        response3 = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device 3", "device_type": "desktop"},
        )

        assert response1.status_code == 201
        assert response2.status_code == 201
        assert response3.status_code == 201

        id1 = response1.json()["device_id"]
        id2 = response2.json()["device_id"]
        id3 = response3.json()["device_id"]

        # All IDs should be unique
        assert id1 != id2
        assert id2 != id3
        assert id1 != id3

        # All should be valid UUIDs
        import uuid
        for device_id in [id1, id2, id3]:
            uuid.UUID(device_id)  # Will raise ValueError if not valid UUID

        # All should have unique auth tokens
        token1 = response1.json()["auth_token"]
        token2 = response2.json()["auth_token"]
        token3 = response3.json()["auth_token"]
        assert token1 != token2
        assert token2 != token3
        assert token1 != token3
        for token in [token1, token2, token3]:
            assert token.startswith("synk_")
            assert len(token) == 69

    @pytest.mark.asyncio
    async def test_invalid_device_type(self, async_client):
        """Test that invalid device_type is rejected."""
        response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Test Device", "device_type": "tablet"},
        )

        assert response.status_code == 422
        error_data = response.json()
        assert "detail" in error_data

    @pytest.mark.asyncio
    async def test_invalid_device_type_case_sensitive(self, async_client):
        """Test that device_type is case-sensitive (only lowercase mobile/desktop)."""
        response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Test Device", "device_type": "MOBILE"},
        )

        assert response.status_code == 422

    @pytest.mark.asyncio
    async def test_empty_device_name(self, async_client):
        """Test that empty device_name is rejected."""
        response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "", "device_type": "mobile"},
        )

        assert response.status_code == 422

    @pytest.mark.asyncio
    async def test_whitespace_only_device_name(self, async_client):
        """Test that whitespace-only device_name is rejected."""
        response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "   ", "device_type": "mobile"},
        )

        assert response.status_code == 422

    @pytest.mark.asyncio
    async def test_device_name_too_long(self, async_client):
        """Test that device_name exceeding max length is rejected."""
        long_name = "a" * 101  # Max is 100
        response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": long_name, "device_type": "mobile"},
        )

        assert response.status_code == 422

    @pytest.mark.asyncio
    async def test_missing_device_name(self, async_client):
        """Test that missing device_name is rejected."""
        response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_type": "mobile"},
        )

        assert response.status_code == 422

    @pytest.mark.asyncio
    async def test_missing_device_type(self, async_client):
        """Test that missing device_type is rejected."""
        response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Test Device"},
        )

        assert response.status_code == 422

    @pytest.mark.asyncio
    async def test_device_name_trims_whitespace(self, async_client):
        """Test that device_name leading/trailing whitespace is trimmed."""
        response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "  My Device  ", "device_type": "mobile"},
        )

        assert response.status_code == 201
        assert response.json()["device_name"] == "My Device"


class TestDeviceRetrieval:
    """Tests for GET /api/v1/devices/{device_id}."""

    @pytest.mark.asyncio
    async def test_get_registered_device(self, async_client):
        """Test retrieving a registered device with authentication."""
        # First register a device
        register_response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Test Device", "device_type": "desktop"},
        )
        assert register_response.status_code == 201
        device_id = register_response.json()["device_id"]
        auth_token = register_response.json()["auth_token"]

        # Then retrieve it with authentication
        get_response = await async_client.get(
            f"/api/v1/devices/{device_id}",
            headers={"Authorization": f"Bearer {auth_token}"},
        )

        assert get_response.status_code == 200
        data = get_response.json()
        assert data["device_id"] == device_id
        assert data["device_name"] == "Test Device"
        assert data["device_type"] == "desktop"
        # auth_token should NOT be returned in GET response
        assert "auth_token" not in data

    @pytest.mark.asyncio
    async def test_get_registered_device_without_auth(self, async_client):
        """Test retrieving a device without authentication returns 401."""
        register_response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Test Device", "device_type": "desktop"},
        )
        assert register_response.status_code == 201
        device_id = register_response.json()["device_id"]

        get_response = await async_client.get(f"/api/v1/devices/{device_id}")
        assert get_response.status_code == 401

    @pytest.mark.asyncio
    async def test_get_registered_device_with_invalid_auth(self, async_client):
        """Test retrieving a device with invalid token returns 401."""
        register_response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Test Device", "device_type": "desktop"},
        )
        assert register_response.status_code == 201
        device_id = register_response.json()["device_id"]

        get_response = await async_client.get(
            f"/api/v1/devices/{device_id}",
            headers={"Authorization": "Bearer invalid_token"},
        )
        assert get_response.status_code == 401

    @pytest.mark.asyncio
    async def test_get_another_device_forbidden(self, async_client):
        """Test that a device cannot access another device's info."""
        # Register two devices
        reg1 = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device 1", "device_type": "mobile"},
        )
        reg2 = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device 2", "device_type": "desktop"},
        )
        device1_id = reg1.json()["device_id"]
        device2_id = reg2.json()["device_id"]
        token1 = reg1.json()["auth_token"]

        # Device 1 tries to access Device 2's info - should be forbidden
        response = await async_client.get(
            f"/api/v1/devices/{device2_id}",
            headers={"Authorization": f"Bearer {token1}"},
        )
        assert response.status_code == 403

    @pytest.mark.asyncio
    async def test_unknown_device_lookup(self, async_client):
        """Test retrieving a non-existent device returns 404."""
        # Register a device first to get a valid token
        register_response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Test Device", "device_type": "desktop"},
        )
        auth_token = register_response.json()["auth_token"]

        response = await async_client.get(
            "/api/v1/devices/non-existent-id",
            headers={"Authorization": f"Bearer {auth_token}"},
        )

        assert response.status_code == 404
        error_data = response.json()
        assert "detail" in error_data
        assert "non-existent-id" in error_data["detail"]

    @pytest.mark.asyncio
    async def test_unknown_uuid_lookup(self, async_client):
        """Test retrieving a valid UUID that doesn't exist returns 404."""
        import uuid
        fake_uuid = str(uuid.uuid4())

        # Register a device first to get a valid token
        register_response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Test Device", "device_type": "desktop"},
        )
        auth_token = register_response.json()["auth_token"]

        response = await async_client.get(
            f"/api/v1/devices/{fake_uuid}",
            headers={"Authorization": f"Bearer {auth_token}"},
        )

        assert response.status_code == 404


class TestDeviceRegistryService:
    """Direct tests for the DeviceRegistry service."""

    @pytest.mark.asyncio
    async def test_registry_register_and_get(self):
        """Test registry register and get methods directly."""
        from app.models.device import DeviceRegistrationRequest

        request = DeviceRegistrationRequest(device_name="Direct Test", device_type=DeviceType.MOBILE)
        device, auth_token = await device_registry.register(request)

        assert device.device_name == "Direct Test"
        assert device.device_type == DeviceType.MOBILE
        assert len(device.device_id) > 0
        assert auth_token.startswith("synk_")
        assert len(auth_token) == 69

        # Retrieve it
        retrieved = await device_registry.get(device.device_id)
        assert retrieved is not None
        assert retrieved.device_id == device.device_id
        assert retrieved.device_name == "Direct Test"

    @pytest.mark.asyncio
    async def test_registry_exists(self):
        """Test registry exists method."""
        from app.models.device import DeviceRegistrationRequest

        request = DeviceRegistrationRequest(device_name="Exists Test", device_type=DeviceType.DESKTOP)
        device, _ = await device_registry.register(request)

        assert await device_registry.exists(device.device_id) is True
        assert await device_registry.exists("non-existent") is False

    @pytest.mark.asyncio
    async def test_registry_count(self):
        """Test registry count method."""
        from app.models.device import DeviceRegistrationRequest

        assert await device_registry.count() == 0

        await device_registry.register(DeviceRegistrationRequest(device_name="D1", device_type=DeviceType.MOBILE))
        assert await device_registry.count() == 1

        await device_registry.register(DeviceRegistrationRequest(device_name="D2", device_type=DeviceType.DESKTOP))
        assert await device_registry.count() == 2

    @pytest.mark.asyncio
    async def test_registry_list_devices(self):
        """Test registry list_devices method."""
        from app.models.device import DeviceRegistrationRequest

        await device_registry.register(DeviceRegistrationRequest(device_name="List Test 1", device_type=DeviceType.MOBILE))
        await device_registry.register(DeviceRegistrationRequest(device_name="List Test 2", device_type=DeviceType.DESKTOP))

        devices = await device_registry.list_devices()
        assert len(devices) == 2
        names = {d.device_name for d in devices}
        assert names == {"List Test 1", "List Test 2"}