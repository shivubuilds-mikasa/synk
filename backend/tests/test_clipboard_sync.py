"""Additional tests for WebSocket clipboard sync features."""

import pytest
from httpx import AsyncClient
from uuid import UUID
from app.repositories.clipboard_repository import ClipboardRepository


class TestClipboardSyncOnConnect:
    """Tests for clipboard history sync when device connects."""

    @pytest.fixture(autouse=True)
    async def setup(self, async_client, registered_device, auth_headers, db_session):
        """Setup test device and database session."""
        self.device = registered_device
        self.headers = auth_headers
        self.db = db_session

    @pytest.mark.asyncio
    async def test_get_undelivered_entries(self, async_client):
        """Test getting undelivered entries from repository."""
        from uuid import uuid4
        device_uuid = UUID(self.device["device_id"])
        clipboard_repo = ClipboardRepository(self.db)

        # Create an entry with delivered_count = 0
        await clipboard_repo.create(
            device_id=device_uuid,
            message_id="undelivered_msg_1",
            content_type="text",
            content_text="Undelivered content",
            source_device_id=device_uuid,
        )
        await self.db.commit()

        # Verify it shows as undelivered
        undelivered = await clipboard_repo.get_undelivered_for_device(device_uuid)
        assert len(undelivered) == 1
        assert undelivered[0].message_id == "undelivered_msg_1"
        assert undelivered[0].delivered_count == 0

    @pytest.mark.asyncio
    async def test_increment_delivered_count(self, async_client):
        """Test incrementing delivered count."""
        from uuid import uuid4
        device_uuid = UUID(self.device["device_id"])
        clipboard_repo = ClipboardRepository(self.db)

        await clipboard_repo.create(
            device_id=device_uuid,
            message_id="deliver_msg_1",
            content_type="text",
            content_text="To be delivered",
            source_device_id=device_uuid,
        )
        await self.db.commit()

        # Initially delivered_count = 0
        entry = await clipboard_repo.get_by_message_id(device_uuid, "deliver_msg_1")
        assert entry.delivered_count == 0

        # Increment
        result = await clipboard_repo.increment_delivered_count(device_uuid, "deliver_msg_1")
        await self.db.commit()
        assert result is True

        # Verify incremented
        entry = await clipboard_repo.get_by_message_id(device_uuid, "deliver_msg_1")
        assert entry.delivered_count == 1

        # Not undelivered anymore
        undelivered = await clipboard_repo.get_undelivered_for_device(device_uuid)
        matching = [e for e in undelivered if e.message_id == "deliver_msg_1"]
        assert len(matching) == 0


class TestDeliveryReceipt:
    """Tests for delivery receipt handling."""

    @pytest.fixture(autouse=True)
    async def setup(self, async_client, registered_device, auth_headers, db_session):
        """Setup test device and database session."""
        self.device = registered_device
        self.headers = auth_headers
        self.db = db_session

    @pytest.mark.asyncio
    async def test_delivery_receipt_model_import(self):
        """Test that delivery receipt models can be imported."""
        from app.models.sync import DeliveryReceiptMessage, DeliveryReceiptMessageServer
        assert DeliveryReceiptMessage is not None
        assert DeliveryReceiptMessageServer is not None


class TestHistorySync:
    """Tests for history sync request/response."""

    @pytest.fixture(autouse=True)
    async def setup(self, async_client, registered_device, auth_headers, db_session):
        """Setup test device and database session."""
        self.device = registered_device
        self.headers = auth_headers
        self.db = db_session

    @pytest.mark.asyncio
    async def test_history_sync_models_import(self):
        """Test that history sync models can be imported."""
        from app.models.sync import HistorySyncRequestMessage, HistorySyncResponseMessage
        assert HistorySyncRequestMessage is not None
        assert HistorySyncResponseMessage is not None