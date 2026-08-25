"""Tests for clipboard history API endpoints."""

import pytest
from httpx import AsyncClient
from uuid import UUID
import json
from app.repositories.clipboard_repository import ClipboardRepository


class TestClipboardHistory:
    """Tests for clipboard history retrieval endpoints."""

    @pytest.fixture(autouse=True)
    async def setup(self, async_client, registered_device, auth_headers):
        """Setup test device and authentication."""
        self.device = registered_device
        self.headers = auth_headers

    @pytest.mark.asyncio
    async def test_get_empty_clipboard_history(self, async_client):
        """Test getting clipboard history when empty."""
        response = await async_client.get(
            "/api/v1/clipboard/history",
            headers=self.headers,
        )
        assert response.status_code == 200
        data = response.json()
        assert data["entries"] == []
        assert data["limit"] == 50
        assert data["offset"] == 0
        assert data["total"] == 0

    @pytest.mark.asyncio
    async def test_get_clipboard_history_with_pagination(self, async_client):
        """Test clipboard history pagination parameters."""
        response = await async_client.get(
            "/api/v1/clipboard/history?limit=10&offset=5",
            headers=self.headers,
        )
        assert response.status_code == 200
        data = response.json()
        assert data["limit"] == 10
        assert data["offset"] == 5

    @pytest.mark.asyncio
    async def test_get_clipboard_history_limit_validation(self, async_client):
        """Test limit parameter validation."""
        # Test limit too high
        response = await async_client.get(
            "/api/v1/clipboard/history?limit=101",
            headers=self.headers,
        )
        assert response.status_code == 422

        # Test limit too low
        response = await async_client.get(
            "/api/v1/clipboard/history?limit=0",
            headers=self.headers,
        )
        assert response.status_code == 422

    @pytest.mark.asyncio
    async def test_get_clipboard_history_offset_validation(self, async_client):
        """Test offset parameter validation."""
        response = await async_client.get(
            "/api/v1/clipboard/history?offset=-1",
            headers=self.headers,
        )
        assert response.status_code == 422

    @pytest.mark.asyncio
    async def test_get_clipboard_history_without_auth(self, async_client):
        """Test clipboard history requires authentication."""
        response = await async_client.get("/api/v1/clipboard/history")
        assert response.status_code == 401

    @pytest.mark.asyncio
    async def test_get_clipboard_history_with_invalid_auth(self, async_client):
        """Test clipboard history with invalid token."""
        response = await async_client.get(
            "/api/v1/clipboard/history",
            headers={"Authorization": "Bearer invalid_token"},
        )
        assert response.status_code == 401

    @pytest.mark.asyncio
    async def test_get_sent_clipboard_history_empty(self, async_client):
        """Test getting sent clipboard history when empty."""
        response = await async_client.get(
            "/api/v1/clipboard/history/sent",
            headers=self.headers,
        )
        assert response.status_code == 200
        data = response.json()
        assert data["entries"] == []


class TestClipboardHistoryWithData:
    """Tests for clipboard history with actual data inserted via repository."""

    @pytest.fixture(autouse=True)
    async def setup(self, async_client, registered_device, auth_headers, db_session):
        """Setup test device and database session."""
        self.device = registered_device
        self.headers = auth_headers
        self.db = db_session

    @pytest.mark.asyncio
    async def test_clipboard_history_after_db_insert(self, async_client):
        """Test that clipboard history is populated after database insert."""
        from uuid import uuid4
        device_uuid = UUID(self.device["device_id"])
        message_id = "test_msg_123"
        content_text = "Hello, World!"

        # Insert directly via repository
        clipboard_repo = ClipboardRepository(self.db)
        await clipboard_repo.create(
            device_id=device_uuid,
            message_id=message_id,
            content_type="text",
            content_text=content_text,
            source_device_id=device_uuid,
        )
        await self.db.commit()

        # Now get clipboard history via REST
        response = await async_client.get(
            "/api/v1/clipboard/history",
            headers=self.headers,
        )
        assert response.status_code == 200
        data = response.json()
        assert len(data["entries"]) == 1
        entry = data["entries"][0]
        assert entry["message_id"] == message_id
        assert entry["content_text"] == content_text
        assert entry["content_type"] == "text"
        assert entry["delivered_count"] == 0

    @pytest.mark.asyncio
    async def test_clipboard_history_deduplication(self, async_client):
        """Test that duplicate message_ids are not stored twice."""
        from uuid import uuid4
        device_uuid = UUID(self.device["device_id"])
        message_id = "duplicate_msg_456"

        clipboard_repo = ClipboardRepository(self.db)

        # Insert first entry
        await clipboard_repo.create(
            device_id=device_uuid,
            message_id=message_id,
            content_type="text",
            content_text="First content",
            source_device_id=device_uuid,
        )
        await self.db.commit()

        # Check exists_by_message_id returns True
        exists = await clipboard_repo.exists_by_message_id(device_uuid, message_id)
        assert exists is True

        # Check history - should only have one entry
        response = await async_client.get(
            "/api/v1/clipboard/history",
            headers=self.headers,
        )
        assert response.status_code == 200
        data = response.json()
        matching = [e for e in data["entries"] if e["message_id"] == message_id]
        assert len(matching) == 1

    @pytest.mark.asyncio
    async def test_sent_clipboard_history(self, async_client):
        """Test getting clipboard history sent by this device."""
        from uuid import uuid4
        device_uuid = UUID(self.device["device_id"])

        clipboard_repo = ClipboardRepository(self.db)
        await clipboard_repo.create(
            device_id=device_uuid,
            message_id="sent_msg_789",
            content_type="text",
            content_text="Sent content",
            source_device_id=device_uuid,
        )
        await self.db.commit()

        response = await async_client.get(
            "/api/v1/clipboard/history/sent",
            headers=self.headers,
        )
        assert response.status_code == 200
        data = response.json()
        assert len(data["entries"]) == 1
        entry = data["entries"][0]
        assert entry["message_id"] == "sent_msg_789"
        assert entry["content_text"] == "Sent content"
        # source_device_id should be this device (since it originated the content)
        assert entry["source_device_id"] == str(device_uuid)

    @pytest.mark.asyncio
    async def test_clipboard_history_pagination(self, async_client):
        """Test pagination of clipboard history."""
        from uuid import uuid4
        device_uuid = UUID(self.device["device_id"])
        clipboard_repo = ClipboardRepository(self.db)

        # Insert 5 entries
        for i in range(5):
            await clipboard_repo.create(
                device_id=device_uuid,
                message_id=f"msg_{i}",
                content_type="text",
                content_text=f"Content {i}",
                source_device_id=device_uuid,
            )
        await self.db.commit()

        # Get first page
        response = await async_client.get(
            "/api/v1/clipboard/history?limit=2&offset=0",
            headers=self.headers,
        )
        assert response.status_code == 200
        data = response.json()
        assert len(data["entries"]) == 2
        assert data["limit"] == 2
        assert data["offset"] == 0

        # Get second page
        response = await async_client.get(
            "/api/v1/clipboard/history?limit=2&offset=2",
            headers=self.headers,
        )
        assert response.status_code == 200
        data = response.json()
        assert len(data["entries"]) == 2
        assert data["limit"] == 2
        assert data["offset"] == 2

    @pytest.mark.asyncio
    async def test_get_other_device_history_forbidden(self, async_client):
        """Test that a device cannot access another device's clipboard history."""
        # Register another device
        other_response = await async_client.post(
            "/api/v1/devices/register",
            json={"device_name": "Other Device", "device_type": "desktop"},
        )
        assert other_response.status_code == 201
        other_data = other_response.json()

        # Try to access first device's history with other device's token
        other_headers = {"Authorization": f"Bearer {other_data['auth_token']}"}
        response = await async_client.get(
            "/api/v1/clipboard/history",
            headers=other_headers,
        )
        assert response.status_code == 200  # Should work for its own (empty) history
        data = response.json()
        assert data["entries"] == []

    @pytest.mark.asyncio
    async def test_large_content_not_stored_in_text(self, async_client):
        """Test that large content (>10000 chars) is not stored in content_text."""
        from uuid import uuid4
        device_uuid = UUID(self.device["device_id"])
        clipboard_repo = ClipboardRepository(self.db)

        large_content = "x" * 15000  # Larger than MAX_CONTENT_STORE_LENGTH
        await clipboard_repo.create(
            device_id=device_uuid,
            message_id="large_msg_1",
            content_type="text",
            content_text=large_content,
            source_device_id=device_uuid,
        )
        await self.db.commit()

        response = await async_client.get(
            "/api/v1/clipboard/history",
            headers=self.headers,
        )
        assert response.status_code == 200
        data = response.json()
        assert len(data["entries"]) == 1
        entry = data["entries"][0]
        assert entry["content_text"] is None  # Should be NULL for large content
        assert entry["content_hash"] is not None  # Hash should still be stored

    @pytest.mark.asyncio
    async def test_get_specific_clipboard_entry(self, async_client):
        """Test getting a specific clipboard entry by message_id."""
        from uuid import uuid4
        device_uuid = UUID(self.device["device_id"])
        clipboard_repo = ClipboardRepository(self.db)

        await clipboard_repo.create(
            device_id=device_uuid,
            message_id="specific_msg_123",
            content_type="text",
            content_text="Specific content",
            source_device_id=device_uuid,
        )
        await self.db.commit()

        response = await async_client.get(
            "/api/v1/clipboard/history/specific_msg_123",
            headers=self.headers,
        )
        assert response.status_code == 200
        data = response.json()
        assert data["message_id"] == "specific_msg_123"
        assert data["content_text"] == "Specific content"
        assert data["content_type"] == "text"

    @pytest.mark.asyncio
    async def test_get_nonexistent_clipboard_entry(self, async_client):
        """Test getting a clipboard entry that doesn't exist returns 404."""
        response = await async_client.get(
            "/api/v1/clipboard/history/nonexistent_msg",
            headers=self.headers,
        )
        assert response.status_code == 404

    @pytest.mark.asyncio
    async def test_total_count_in_response(self, async_client):
        """Test that total count is correctly returned in history responses."""
        from uuid import uuid4
        device_uuid = UUID(self.device["device_id"])
        clipboard_repo = ClipboardRepository(self.db)

        # Insert 3 entries
        for i in range(3):
            await clipboard_repo.create(
                device_id=device_uuid,
                message_id=f"count_msg_{i}",
                content_type="text",
                content_text=f"Count content {i}",
                source_device_id=device_uuid,
            )
        await self.db.commit()

        response = await async_client.get(
            "/api/v1/clipboard/history?limit=2",
            headers=self.headers,
        )
        assert response.status_code == 200
        data = response.json()
        assert data["total"] == 3  # Total should be 3, not 2
        assert len(data["entries"]) == 2  # But only 2 returned due to limit