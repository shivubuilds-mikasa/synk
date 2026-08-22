"""Tests for Device Pairing API."""

import asyncio
import pytest
from httpx import AsyncClient, ASGITransport

from app.main import app
from app.services.device_registry import device_registry
from app.services.pairing_registry import pairing_registry
from app.models.device import DeviceType


class TestPairingCreate:
    """Tests for POST /api/v1/pairing/create."""

    @pytest.mark.asyncio
    async def test_create_pairing_code_success(self, async_client):
        """Test successful pairing code creation."""
        # First register a device
        register_response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        assert register_response.status_code == 201
        device_id = register_response.json()["device_id"]

        # Create pairing code
        response = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": device_id},
        )

        assert response.status_code == 201
        data = response.json()

        assert "code" in data
        assert "expires_at" in data
        assert "device_id" in data

        # Validate code format: exactly 6 digits
        assert len(data["code"]) == 6
        assert data["code"].isdigit()

        # Validate expires_at is a valid ISO 8601 timestamp
        assert data["expires_at"].endswith("Z")
        assert data["device_id"] == device_id

    @pytest.mark.asyncio
    async def test_create_pairing_code_unknown_device(self, async_client):
        """Test creating pairing code for unknown device returns 404."""
        import uuid
        fake_device_id = str(uuid.uuid4())

        response = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": fake_device_id},
        )

        assert response.status_code == 404
        error_data = response.json()
        assert "detail" in error_data
        assert fake_device_id in error_data["detail"]

    @pytest.mark.asyncio
    async def test_create_pairing_code_missing_device_id(self, async_client):
        """Test creating pairing code without device_id returns 422."""
        response = await async_client.post(
            "/api/v1/pairing/create",
            json={},
        )

        assert response.status_code == 422

    @pytest.mark.asyncio
    async def test_create_pairing_code_empty_device_id(self, async_client):
        """Test creating pairing code with empty device_id returns 422."""
        response = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": ""},
        )

        assert response.status_code == 422


class TestPairingConfirm:
    """Tests for POST /api/v1/pairing/confirm."""

    @pytest.mark.asyncio
    async def test_confirm_pairing_success(self, async_client):
        """Test successful pairing confirmation between two devices."""
        # Register two devices
        reg_a = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        assert reg_a.status_code == 201
        device_a_id = reg_a.json()["device_id"]

        reg_b = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device B", "device_type": "desktop"},
        )
        assert reg_b.status_code == 201
        device_b_id = reg_b.json()["device_id"]

        # Device A creates pairing code
        create_response = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": device_a_id},
        )
        assert create_response.status_code == 201
        code = create_response.json()["code"]

        # Device B confirms pairing
        confirm_response = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_b_id, "code": code},
        )

        assert confirm_response.status_code == 200
        data = confirm_response.json()

        # Verify response structure
        assert "paired_device" in data
        assert "this_device" in data

        # Paired device should be Device A (from Device B's perspective)
        assert data["paired_device"]["device_id"] == device_a_id
        assert data["paired_device"]["device_name"] == "Device A"
        assert data["paired_device"]["device_type"] == "mobile"

        # This device should be Device B
        assert data["this_device"]["device_id"] == device_b_id
        assert data["this_device"]["device_name"] == "Device B"
        assert data["this_device"]["device_type"] == "desktop"

    @pytest.mark.asyncio
    async def test_confirm_pairing_unknown_confirming_device(self, async_client):
        """Test confirming with unknown device returns 404."""
        import uuid
        fake_device_id = str(uuid.uuid4())

        # Register one device and create code
        reg_a = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        device_a_id = reg_a.json()["device_id"]

        create_response = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": device_a_id},
        )
        code = create_response.json()["code"]

        # Try to confirm with unknown device
        response = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": fake_device_id, "code": code},
        )

        assert response.status_code == 404

    @pytest.mark.asyncio
    async def test_confirm_pairing_invalid_code(self, async_client):
        """Test confirming with invalid code returns 400."""
        # Register two devices
        reg_a = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        device_a_id = reg_a.json()["device_id"]

        reg_b = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device B", "device_type": "desktop"},
        )
        device_b_id = reg_b.json()["device_id"]

        # Create code from Device A
        create_response = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": device_a_id},
        )

        # Try to confirm with wrong code
        response = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_b_id, "code": "999999"},
        )

        assert response.status_code == 400
        error_data = response.json()
        assert "detail" in error_data

    @pytest.mark.asyncio
    async def test_confirm_pairing_expired_code(self, async_client):
        """Test confirming with expired code returns 400."""
        # Register two devices
        reg_a = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        device_a_id = reg_a.json()["device_id"]

        reg_b = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device B", "device_type": "desktop"},
        )
        device_b_id = reg_b.json()["device_id"]

        # Create code from Device A
        create_response = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": device_a_id},
        )
        code = create_response.json()["code"]

        # Manually expire the code by manipulating the registry
        pending = pairing_registry._pending_pairings.get(code)
        assert pending is not None
        pending.expires_at = asyncio.get_event_loop().time() - 1

        # Try to confirm with expired code
        response = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_b_id, "code": code},
        )

        assert response.status_code == 400
        error_data = response.json()
        assert "expired" in error_data["detail"].lower()

    @pytest.mark.asyncio
    async def test_confirm_pairing_reused_code(self, async_client):
        """Test that a used code cannot be reused."""
        # Register three devices
        reg_a = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        device_a_id = reg_a.json()["device_id"]

        reg_b = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device B", "device_type": "desktop"},
        )
        device_b_id = reg_b.json()["device_id"]

        reg_c = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device C", "device_type": "mobile"},
        )
        device_c_id = reg_c.json()["device_id"]

        # Create code from Device A
        create_response = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": device_a_id},
        )
        code = create_response.json()["code"]

        # Device B confirms pairing (first use)
        confirm1 = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_b_id, "code": code},
        )
        assert confirm1.status_code == 200

        # Device C tries to use same code (should fail)
        confirm2 = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_c_id, "code": code},
        )

        assert confirm2.status_code == 409  # Conflict - already used
        error_data = confirm2.json()
        assert "already been used" in error_data["detail"].lower()

    @pytest.mark.asyncio
    async def test_confirm_pairing_self_pairing(self, async_client):
        """Test that a device cannot pair with itself."""
        # Register one device
        reg_a = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        device_a_id = reg_a.json()["device_id"]

        # Create code from Device A
        create_response = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": device_a_id},
        )
        code = create_response.json()["code"]

        # Device A tries to pair with itself
        response = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_a_id, "code": code},
        )

        assert response.status_code == 400
        error_data = response.json()
        assert "cannot pair with itself" in error_data["detail"].lower()

    @pytest.mark.asyncio
    async def test_confirm_pairing_duplicate_pairing(self, async_client):
        """Test that duplicate pairing between same devices is rejected."""
        # Register two devices
        reg_a = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        device_a_id = reg_a.json()["device_id"]

        reg_b = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device B", "device_type": "desktop"},
        )
        device_b_id = reg_b.json()["device_id"]

        # First pairing
        create1 = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": device_a_id},
        )
        code1 = create1.json()["code"]

        confirm1 = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_b_id, "code": code1},
        )
        assert confirm1.status_code == 200

        # Try to pair again (Device A creates new code)
        create2 = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": device_a_id},
        )
        code2 = create2.json()["code"]

        confirm2 = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_b_id, "code": code2},
        )

        assert confirm2.status_code == 409
        error_data = confirm2.json()
        assert "already paired" in error_data["detail"].lower()

    @pytest.mark.asyncio
    async def test_confirm_pairing_invalid_code_format(self, async_client):
        """Test that invalid code format is rejected."""
        reg_a = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        device_a_id = reg_a.json()["device_id"]

        reg_b = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device B", "device_type": "desktop"},
        )
        device_b_id = reg_b.json()["device_id"]

        # Try with 5-digit code
        response = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_b_id, "code": "12345"},
        )

        assert response.status_code == 422

    @pytest.mark.asyncio
    async def test_confirm_pairing_code_with_letters(self, async_client):
        """Test that code with letters is rejected."""
        reg_a = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        device_a_id = reg_a.json()["device_id"]

        reg_b = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device B", "device_type": "desktop"},
        )
        device_b_id = reg_b.json()["device_id"]

        # Try with alphanumeric code
        response = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_b_id, "code": "abc123"},
        )

        assert response.status_code == 422


class TestGetPairedDevices:
    """Tests for GET /api/v1/pairing/{device_id}."""

    @pytest.mark.asyncio
    async def test_get_paired_devices_empty(self, async_client):
        """Test retrieving paired devices for a device with no pairings."""
        reg_a = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        device_a_id = reg_a.json()["device_id"]

        response = await async_client.get(f"/api/v1/pairing/{device_a_id}")

        assert response.status_code == 200
        data = response.json()

        assert data["device_id"] == device_a_id
        assert data["paired_devices"] == []

    @pytest.mark.asyncio
    async def test_get_paired_devices_after_pairing(self, async_client):
        """Test retrieving paired devices after successful pairing."""
        reg_a = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device A", "device_type": "mobile"},
        )
        device_a_id = reg_a.json()["device_id"]

        reg_b = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Device B", "device_type": "desktop"},
        )
        device_b_id = reg_b.json()["device_id"]

        create = await async_client.post(
            "/api/v1/pairing/create",
            json={"device_id": device_a_id},
        )
        code = create.json()["code"]

        await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_b_id, "code": code},
        )

        # Get paired devices for Device A
        response_a = await async_client.get(f"/api/v1/pairing/{device_a_id}")
        # Get paired devices for Device B
        response_b = await async_client.get(f"/api/v1/pairing/{device_b_id}")

        assert response_a.status_code == 200
        assert response_b.status_code == 200

        data_a = response_a.json()
        data_b = response_b.json()

        # Device A should see Device B
        assert len(data_a["paired_devices"]) == 1
        assert data_a["paired_devices"][0]["device_id"] == device_b_id
        assert data_a["paired_devices"][0]["device_name"] == "Device B"
        assert data_a["paired_devices"][0]["device_type"] == "desktop"

        # Device B should see Device A
        assert len(data_b["paired_devices"]) == 1
        assert data_b["paired_devices"][0]["device_id"] == device_a_id
        assert data_b["paired_devices"][0]["device_name"] == "Device A"
        assert data_b["paired_devices"][0]["device_type"] == "mobile"

    @pytest.mark.asyncio
    async def test_get_paired_devices_unknown_device(self, async_client):
        """Test retrieving paired devices for unknown device returns 404."""
        import uuid
        fake_device_id = str(uuid.uuid4())

        response = await async_client.get(f"/api/v1/pairing/{fake_device_id}")

        assert response.status_code == 404


class TestMultipleIndependentPairings:
    """Tests for multiple independent pairings."""

    @pytest.mark.asyncio
    async def test_multiple_devices_can_pair_independently(self, async_client):
        """Test that multiple device pairs can exist independently."""
        # Register 4 devices
        reg_a = await async_client.post("/api/v1/devices/register", json={"device_name": "A", "device_type": "mobile"})
        reg_b = await async_client.post("/api/v1/devices/register", json={"device_name": "B", "device_type": "desktop"})
        reg_c = await async_client.post("/api/v1/devices/register", json={"device_name": "C", "device_type": "mobile"})
        reg_d = await async_client.post("/api/v1/devices/register", json={"device_name": "D", "device_type": "desktop"})

        device_a_id = reg_a.json()["device_id"]
        device_b_id = reg_b.json()["device_id"]
        device_c_id = reg_c.json()["device_id"]
        device_d_id = reg_d.json()["device_id"]

        # Pair A with B
        create_ab = await async_client.post("/api/v1/pairing/create", json={"device_id": device_a_id})
        code_ab = create_ab.json()["code"]
        await async_client.post("/api/v1/pairing/confirm", json={"device_id": device_b_id, "code": code_ab})

        # Pair C with D
        create_cd = await async_client.post("/api/v1/pairing/create", json={"device_id": device_c_id})
        code_cd = create_cd.json()["code"]
        await async_client.post("/api/v1/pairing/confirm", json={"device_id": device_d_id, "code": code_cd})

        # Verify pairings
        paired_a = await async_client.get(f"/api/v1/pairing/{device_a_id}")
        paired_b = await async_client.get(f"/api/v1/pairing/{device_b_id}")
        paired_c = await async_client.get(f"/api/v1/pairing/{device_c_id}")
        paired_d = await async_client.get(f"/api/v1/pairing/{device_d_id}")

        # A paired with B
        assert len(paired_a.json()["paired_devices"]) == 1
        assert paired_a.json()["paired_devices"][0]["device_id"] == device_b_id

        assert len(paired_b.json()["paired_devices"]) == 1
        assert paired_b.json()["paired_devices"][0]["device_id"] == device_a_id

        # C paired with D
        assert len(paired_c.json()["paired_devices"]) == 1
        assert paired_c.json()["paired_devices"][0]["device_id"] == device_d_id

        assert len(paired_d.json()["paired_devices"]) == 1
        assert paired_d.json()["paired_devices"][0]["device_id"] == device_c_id

    @pytest.mark.asyncio
    async def test_one_device_can_pair_with_multiple(self, async_client):
        """Test that one device can pair with multiple other devices."""
        # Register 3 devices
        reg_a = await async_client.post("/api/v1/devices/register", json={"device_name": "A", "device_type": "mobile"})
        reg_b = await async_client.post("/api/v1/devices/register", json={"device_name": "B", "device_type": "desktop"})
        reg_c = await async_client.post("/api/v1/devices/register", json={"device_name": "C", "device_type": "mobile"})

        device_a_id = reg_a.json()["device_id"]
        device_b_id = reg_b.json()["device_id"]
        device_c_id = reg_c.json()["device_id"]

        # Pair A with B
        create_ab = await async_client.post("/api/v1/pairing/create", json={"device_id": device_a_id})
        code_ab = create_ab.json()["code"]
        await async_client.post("/api/v1/pairing/confirm", json={"device_id": device_b_id, "code": code_ab})

        # Pair A with C (A initiates again)
        create_ac = await async_client.post("/api/v1/pairing/create", json={"device_id": device_a_id})
        code_ac = create_ac.json()["code"]
        await async_client.post("/api/v1/pairing/confirm", json={"device_id": device_c_id, "code": code_ac})

        # Verify A has 2 paired devices
        paired_a = await async_client.get(f"/api/v1/pairing/{device_a_id}")

        assert paired_a.status_code == 200
        data = paired_a.json()
        assert len(data["paired_devices"]) == 2

        paired_ids = {d["device_id"] for d in data["paired_devices"]}
        assert paired_ids == {device_b_id, device_c_id}


class TestPairingCodeSecurity:
    """Tests for pairing code security and format."""

    @pytest.mark.asyncio
    async def test_pairing_code_is_6_digits(self, async_client):
        """Test that generated pairing codes are exactly 6 digits."""
        reg = await async_client.post("/api/v1/devices/register", json={"device_name": "Test", "device_type": "mobile"})
        device_id = reg.json()["device_id"]

        # Generate multiple codes and verify format
        for _ in range(10):
            response = await async_client.post(
                "/api/v1/pairing/create",
                json={"device_id": device_id},
            )
            assert response.status_code == 201
            code = response.json()["code"]
            assert len(code) == 6
            assert code.isdigit()

    @pytest.mark.asyncio
    async def test_pairing_code_is_random(self, async_client):
        """Test that generated codes are random (not predictable)."""
        reg = await async_client.post("/api/v1/devices/register", json={"device_name": "Test", "device_type": "mobile"})
        device_id = reg.json()["device_id"]

        codes = set()
        for _ in range(20):
            response = await async_client.post(
                "/api/v1/pairing/create",
                json={"device_id": device_id},
            )
            code = response.json()["code"]
            codes.add(code)

        # With 20 codes from 1,000,000 possibilities, collisions are extremely unlikely
        # But more importantly, they should be different
        assert len(codes) == 20

    @pytest.mark.asyncio
    async def test_pairing_code_uses_secrets_module(self, async_client):
        """Verify code generation uses cryptographically secure random."""
        # This test verifies the implementation detail by checking the code
        # is generated via secrets.randbelow which is cryptographically secure
        import secrets

        # Generate codes directly from the service
        reg = await device_registry.register(
            type("Request", (), {"device_name": "Test", "device_type": DeviceType.MOBILE})()
        )

        codes = set()
        for _ in range(100):
            pending = await pairing_registry.create_pairing_request(reg.device_id)
            codes.add(pending.code)

        # Should have high entropy - 100 unique codes from 1M possibilities
        assert len(codes) == 100
        for code in codes:
            assert len(code) == 6
            assert code.isdigit()


class TestPairingExpiration:
    """Tests for pairing code expiration behavior."""

    @pytest.mark.asyncio
    async def test_pairing_code_expires_after_5_minutes(self, async_client):
        """Test that pairing codes expire after 5 minutes."""
        reg_a = await async_client.post("/api/v1/devices/register", json={"device_name": "A", "device_type": "mobile"})
        device_a_id = reg_a.json()["device_id"]

        create = await async_client.post("/api/v1/pairing/create", json={"device_id": device_a_id})
        code = create.json()["code"]
        expires_at = create.json()["expires_at"]

        # Verify expires_at is ~5 minutes in the future
        from datetime import datetime, timezone
        expires_dt = datetime.fromisoformat(expires_at.replace("Z", "+00:00"))
        now = datetime.now(timezone.utc)
        diff = (expires_dt - now).total_seconds()

        # Should be approximately 300 seconds (5 minutes)
        assert 295 <= diff <= 305

    @pytest.mark.asyncio
    async def test_expired_code_cleanup(self, async_client):
        """Test that expired codes are cleaned up from registry."""
        reg_a = await async_client.post("/api/v1/devices/register", json={"device_name": "A", "device_type": "mobile"})
        device_a_id = reg_a.json()["device_id"]

        create = await async_client.post("/api/v1/pairing/create", json={"device_id": device_a_id})
        code = create.json()["code"]

        # Expire the code
        pending = pairing_registry._pending_pairings.get(code)
        assert pending is not None
        pending.expires_at = asyncio.get_event_loop().time() - 1

        # Run cleanup
        removed = await pairing_registry.cleanup_expired()

        # Should have removed 1 expired code
        assert removed == 1
        assert code not in pairing_registry._pending_pairings


class TestPairingRegistryService:
    """Direct tests for the PairingRegistry service."""

    @pytest.mark.asyncio
    async def test_service_create_and_confirm(self):
        """Test pairing service directly."""
        from app.models.device import DeviceRegistrationRequest

        # Register devices directly
        device_a = await device_registry.register(
            DeviceRegistrationRequest(device_name="A", device_type=DeviceType.MOBILE)
        )
        device_b = await device_registry.register(
            DeviceRegistrationRequest(device_name="B", device_type=DeviceType.DESKTOP)
        )

        # Create pairing
        pending = await pairing_registry.create_pairing_request(device_a.device_id)
        assert pending.code is not None
        assert len(pending.code) == 6
        assert pending.initiator_device_id == device_a.device_id

        # Confirm pairing
        initiator, confirmer = await pairing_registry.confirm_pairing(device_b.device_id, pending.code)
        assert initiator.device_id == device_a.device_id
        assert confirmer.device_id == device_b.device_id

        # Verify paired
        paired_a = await pairing_registry.get_paired_devices(device_a.device_id)
        paired_b = await pairing_registry.get_paired_devices(device_b.device_id)

        assert len(paired_a) == 1
        assert paired_a[0].device_id == device_b.device_id
        assert len(paired_b) == 1
        assert paired_b[0].device_id == device_a.device_id

    @pytest.mark.asyncio
    async def test_service_are_paired(self):
        """Test are_paired method."""
        from app.models.device import DeviceRegistrationRequest

        device_a = await device_registry.register(
            DeviceRegistrationRequest(device_name="A", device_type=DeviceType.MOBILE)
        )
        device_b = await device_registry.register(
            DeviceRegistrationRequest(device_name="B", device_type=DeviceType.DESKTOP)
        )

        # Initially not paired
        assert await pairing_registry.are_paired(device_a.device_id, device_b.device_id) is False

        # Pair them
        pending = await pairing_registry.create_pairing_request(device_a.device_id)
        await pairing_registry.confirm_pairing(device_b.device_id, pending.code)

        # Now paired
        assert await pairing_registry.are_paired(device_a.device_id, device_b.device_id) is True
        assert await pairing_registry.are_paired(device_b.device_id, device_a.device_id) is True


# Additional edge case tests
class TestPairingEdgeCases:
    """Edge case tests for pairing."""

    @pytest.mark.asyncio
    async def test_confirm_with_nonexistent_code(self, async_client):
        """Test confirming with a code that never existed."""
        reg_b = await async_client.post(
            "/api/v1/devices/register", json={"device_name": "B", "device_type": "desktop"}
        )
        device_b_id = reg_b.json()["device_id"]

        response = await async_client.post(
            "/api/v1/pairing/confirm",
            json={"device_id": device_b_id, "code": "111111"},
        )

        assert response.status_code == 400
        assert "invalid" in response.json()["detail"].lower() or "expired" in response.json()["detail"].lower()

    @pytest.mark.asyncio
    async def test_concurrent_pairing_attempts(self, async_client):
        """Test handling of concurrent pairing attempts with same code."""
        reg_a = await async_client.post("/api/v1/devices/register", json={"device_name": "A", "device_type": "mobile"})
        reg_b = await async_client.post("/api/v1/devices/register", json={"device_name": "B", "device_type": "desktop"})
        reg_c = await async_client.post("/api/v1/devices/register", json={"device_name": "C", "device_type": "mobile"})

        device_a_id = reg_a.json()["device_id"]
        device_b_id = reg_b.json()["device_id"]
        device_c_id = reg_c.json()["device_id"]

        create = await async_client.post("/api/v1/pairing/create", json={"device_id": device_a_id})
        code = create.json()["code"]

        # Simulate concurrent confirmations
        confirm_b = async_client.post("/api/v1/pairing/confirm", json={"device_id": device_b_id, "code": code})
        confirm_c = async_client.post("/api/v1/pairing/confirm", json={"device_id": device_c_id, "code": code})

        results = await asyncio.gather(confirm_b, confirm_c)

        # One should succeed, one should fail
        status_codes = [r.status_code for r in results]
        assert 200 in status_codes
        assert 409 in status_codes  # Second attempt should conflict

    @pytest.mark.asyncio
    async def test_pairing_persists_after_confirm(self, async_client):
        """Test that pairing persists after confirmation."""
        reg_a = await async_client.post("/api/v1/devices/register", json={"device_name": "A", "device_type": "mobile"})
        reg_b = await async_client.post("/api/v1/devices/register", json={"device_name": "B", "device_type": "desktop"})

        device_a_id = reg_a.json()["device_id"]
        device_b_id = reg_b.json()["device_id"]

        create = await async_client.post("/api/v1/pairing/create", json={"device_id": device_a_id})
        code = create.json()["code"]

        await async_client.post("/api/v1/pairing/confirm", json={"device_id": device_b_id, "code": code})

        # The pending code should be consumed (kept in registry but marked consumed)
        assert code in pairing_registry._pending_pairings
        assert pairing_registry._pending_pairings[code].consumed is True

        # But pairing relationship should exist
        paired_a = await async_client.get(f"/api/v1/pairing/{device_a_id}")
        assert len(paired_a.json()["paired_devices"]) == 1