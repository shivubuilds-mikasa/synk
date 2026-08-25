"""Clipboard history repository for Synk backend.

Handles all database operations for clipboard history.
"""

import hashlib
from typing import Optional, List
from uuid import UUID

from sqlalchemy import select, func, delete
from sqlalchemy.ext.asyncio import AsyncSession

from app.db.models.clipboard import ClipboardHistoryModel


class ClipboardRepository:
    """Repository for clipboard history operations."""

    def __init__(self, session: AsyncSession) -> None:
        """Initialize the repository with a database session.

        Args:
            session: Async SQLAlchemy session.
        """
        self._session = session

    @staticmethod
    def _hash_content(text: str) -> str:
        """Generate SHA-256 hash of clipboard content for deduplication.

        Args:
            text: The clipboard text content.

        Returns:
            Hex-encoded SHA-256 hash.
        """
        return hashlib.sha256(text.encode("utf-8")).hexdigest()

    async def create(
        self,
        device_id: UUID,
        message_id: str,
        content_type: str,
        content_text: str,
        source_device_id: UUID | None = None,
    ) -> ClipboardHistoryModel:
        """Create a new clipboard history entry.

        Args:
            device_id: The device that received/sent the clipboard update.
            message_id: Unique message identifier.
            content_type: Type of content (e.g., "text").
            content_text: The actual clipboard text.
            source_device_id: Optional ID of the device that originated the content.

        Returns:
            The created ClipboardHistoryModel instance.
        """
        content_hash = self._hash_content(content_text)

        entry = ClipboardHistoryModel(
            device_id=device_id,
            message_id=message_id,
            content_type=content_type,
            content_hash=content_hash,
            content_text=content_text if len(content_text) <= 10000 else None,  # Store full text if small
            source_device_id=source_device_id,
        )

        self._session.add(entry)
        await self._session.flush()
        await self._session.refresh(entry)

        return entry

    async def get_by_message_id(
        self,
        device_id: UUID,
        message_id: str,
    ) -> Optional[ClipboardHistoryModel]:
        """Get a clipboard history entry by device and message ID.

        Args:
            device_id: Device identifier.
            message_id: Message identifier.

        Returns:
            ClipboardHistoryModel if found, None otherwise.
        """
        result = await self._session.execute(
            select(ClipboardHistoryModel).where(
                ClipboardHistoryModel.device_id == device_id,
                ClipboardHistoryModel.message_id == message_id,
            )
        )
        return result.scalar_one_or_none()

    async def exists_by_message_id(
        self,
        device_id: UUID,
        message_id: str,
    ) -> bool:
        """Check if a clipboard entry exists for the device and message ID.

        Used for deduplication.

        Args:
            device_id: Device identifier.
            message_id: Message identifier.

        Returns:
            True if entry exists, False otherwise.
        """
        result = await self._session.execute(
            select(func.count(ClipboardHistoryModel.id)).where(
                ClipboardHistoryModel.device_id == device_id,
                ClipboardHistoryModel.message_id == message_id,
            )
        )
        return result.scalar_one() > 0

    async def get_recent_by_device(
        self,
        device_id: UUID,
        limit: int = 50,
        offset: int = 0,
    ) -> List[ClipboardHistoryModel]:
        """Get recent clipboard history for a device.

        Args:
            device_id: Device identifier.
            limit: Maximum number of entries to return.
            offset: Number of entries to skip.

        Returns:
            List of ClipboardHistoryModel instances, most recent first.
        """
        result = await self._session.execute(
            select(ClipboardHistoryModel)
            .where(ClipboardHistoryModel.device_id == device_id)
            .order_by(ClipboardHistoryModel.created_at.desc())
            .limit(limit)
            .offset(offset)
        )
        return list(result.scalars().all())

    async def get_recent_by_source(
        self,
        source_device_id: UUID,
        limit: int = 50,
        offset: int = 0,
    ) -> List[ClipboardHistoryModel]:
        """Get recent clipboard entries sent by a source device.

        Args:
            source_device_id: Source device identifier.
            limit: Maximum number of entries to return.
            offset: Number of entries to skip.

        Returns:
            List of ClipboardHistoryModel instances, most recent first.
        """
        result = await self._session.execute(
            select(ClipboardHistoryModel)
            .where(ClipboardHistoryModel.source_device_id == source_device_id)
            .order_by(ClipboardHistoryModel.created_at.desc())
            .limit(limit)
            .offset(offset)
        )
        return list(result.scalars().all())

    async def increment_delivered_count(
        self,
        device_id: UUID,
        message_id: str,
    ) -> bool:
        """Increment the delivery count for a clipboard entry.

        Args:
            device_id: Device identifier.
            message_id: Message identifier.

        Returns:
            True if entry was found and updated, False otherwise.
        """
        result = await self._session.execute(
            select(ClipboardHistoryModel).where(
                ClipboardHistoryModel.device_id == device_id,
                ClipboardHistoryModel.message_id == message_id,
            )
        )
        entry = result.scalar_one_or_none()
        if entry:
            entry.delivered_count += 1
            await self._session.flush()
            return True
        return False

    async def get_undelivered_for_device(
        self,
        device_id: UUID,
    ) -> List[ClipboardHistoryModel]:
        """Get clipboard entries that haven't been delivered to paired devices.

        Used for syncing clipboard history when a device comes online.

        Args:
            device_id: Device identifier.

        Returns:
            List of undelivered ClipboardHistoryModel instances.
        """
        result = await self._session.execute(
            select(ClipboardHistoryModel).where(
                ClipboardHistoryModel.device_id == device_id,
                ClipboardHistoryModel.delivered_count == 0,
            ).order_by(ClipboardHistoryModel.created_at.asc())
        )
        return list(result.scalars().all())

    async def delete_old_entries(
        self,
        device_id: UUID,
        keep_count: int = 1000,
    ) -> int:
        """Delete old clipboard history entries beyond the keep count.

        Args:
            device_id: Device identifier.
            keep_count: Number of recent entries to keep.

        Returns:
            Number of entries deleted.
        """
        # Get IDs of entries to keep
        result = await self._session.execute(
            select(ClipboardHistoryModel.id)
            .where(ClipboardHistoryModel.device_id == device_id)
            .order_by(ClipboardHistoryModel.created_at.desc())
            .limit(keep_count)
        )
        keep_ids = list(result.scalars().all())

        if not keep_ids:
            return 0

        # Delete entries not in keep list
        delete_stmt = delete(ClipboardHistoryModel).where(
            ClipboardHistoryModel.device_id == device_id,
            ClipboardHistoryModel.id.not_in(keep_ids),
        )
        result = await self._session.execute(delete_stmt)
        return result.rowcount