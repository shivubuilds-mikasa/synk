"""Clipboard history API routes for Synk backend."""

from fastapi import APIRouter, Depends, HTTPException, Query, status
from uuid import UUID

from app.api.deps import get_current_device_id, require_device_access
from app.models.clipboard import (
    ClipboardHistoryEntry,
    ClipboardHistoryResponse,
)
from app.repositories.clipboard_repository import ClipboardRepository
from app.db.database import get_db
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func

router = APIRouter(prefix="/api/v1/clipboard", tags=["clipboard"])


async def _get_total_count(db: AsyncSession, device_id: UUID, source_only: bool = False) -> int:
    """Get total count of clipboard entries for a device."""
    from app.db.models.clipboard import ClipboardHistoryModel
    if source_only:
        result = await db.execute(
            select(func.count(ClipboardHistoryModel.id)).where(
                ClipboardHistoryModel.source_device_id == device_id
            )
        )
    else:
        result = await db.execute(
            select(func.count(ClipboardHistoryModel.id)).where(
                ClipboardHistoryModel.device_id == device_id
            )
        )
    return result.scalar_one()


@router.get(
    "/history",
    response_model=ClipboardHistoryResponse,
    summary="Get clipboard history for current device",
    description="Retrieve clipboard history entries for the authenticated device. Supports pagination.",
)
async def get_clipboard_history(
    limit: int = Query(50, ge=1, le=100, description="Maximum number of entries to return"),
    offset: int = Query(0, ge=0, description="Number of entries to skip"),
    current_device_id: UUID = Depends(get_current_device_id),
    db: AsyncSession = Depends(get_db),
) -> ClipboardHistoryResponse:
    """Get clipboard history for the authenticated device.

    Args:
        limit: Maximum number of entries to return (1-100).
        offset: Number of entries to skip for pagination.
        current_device_id: The authenticated device's ID.
        db: Database session.

    Returns:
        ClipboardHistoryResponse with list of entries and pagination info.
    """
    clipboard_repo = ClipboardRepository(db)
    entries = await clipboard_repo.get_recent_by_device(
        device_id=current_device_id,
        limit=limit,
        offset=offset,
    )
    total = await _get_total_count(db, current_device_id, source_only=False)

    # Convert to response models
    history_entries = [
        ClipboardHistoryEntry(
            id=entry.id,
            message_id=entry.message_id,
            content_type=entry.content_type,
            content_text=entry.content_text,
            content_hash=entry.content_hash,
            source_device_id=entry.source_device_id,
            delivered_count=entry.delivered_count,
            created_at=entry.created_at,
        )
        for entry in entries
    ]

    return ClipboardHistoryResponse(
        entries=history_entries,
        limit=limit,
        offset=offset,
        total=total,
    )


@router.get(
    "/history/sent",
    response_model=ClipboardHistoryResponse,
    summary="Get clipboard history sent by current device",
    description="Retrieve clipboard history entries that were originated/sent by the authenticated device. Supports pagination.",
)
async def get_sent_clipboard_history(
    limit: int = Query(50, ge=1, le=100, description="Maximum number of entries to return"),
    offset: int = Query(0, ge=0, description="Number of entries to skip"),
    current_device_id: UUID = Depends(get_current_device_id),
    db: AsyncSession = Depends(get_db),
) -> ClipboardHistoryResponse:
    """Get clipboard history originated by the authenticated device.

    Args:
        limit: Maximum number of entries to return (1-100).
        offset: Number of entries to skip for pagination.
        current_device_id: The authenticated device's ID.
        db: Database session.

    Returns:
        ClipboardHistoryResponse with list of entries and pagination info.
    """
    clipboard_repo = ClipboardRepository(db)
    entries = await clipboard_repo.get_recent_by_source(
        source_device_id=current_device_id,
        limit=limit,
        offset=offset,
    )
    total = await _get_total_count(db, current_device_id, source_only=True)

    history_entries = [
        ClipboardHistoryEntry(
            id=entry.id,
            message_id=entry.message_id,
            content_type=entry.content_type,
            content_text=entry.content_text,
            content_hash=entry.content_hash,
            source_device_id=entry.source_device_id,
            delivered_count=entry.delivered_count,
            created_at=entry.created_at,
        )
        for entry in entries
    ]

    return ClipboardHistoryResponse(
        entries=history_entries,
        limit=limit,
        offset=offset,
        total=total,
    )


@router.get(
    "/history/{message_id}",
    response_model=ClipboardHistoryEntry,
    summary="Get a specific clipboard entry by message ID",
    description="Retrieve a single clipboard history entry by its message ID.",
)
async def get_clipboard_entry(
    message_id: str,
    current_device_id: UUID = Depends(get_current_device_id),
    db: AsyncSession = Depends(get_db),
) -> ClipboardHistoryEntry:
    """Get a specific clipboard entry by message ID.

    Args:
        message_id: The message ID of the clipboard entry.
        current_device_id: The authenticated device's ID.
        db: Database session.

    Returns:
        ClipboardHistoryEntry with the entry details.

    Raises:
        HTTPException: 404 if entry not found.
    """
    clipboard_repo = ClipboardRepository(db)
    entry = await clipboard_repo.get_by_message_id(current_device_id, message_id)

    if entry is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Clipboard entry with message_id '{message_id}' not found",
        )

    return ClipboardHistoryEntry(
        id=entry.id,
        message_id=entry.message_id,
        content_type=entry.content_type,
        content_text=entry.content_text,
        content_hash=entry.content_hash,
        source_device_id=entry.source_device_id,
        delivered_count=entry.delivered_count,
        created_at=entry.created_at,
    )