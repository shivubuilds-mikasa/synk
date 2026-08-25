"""Clipboard history API models for Synk backend."""

from datetime import datetime
from typing import List, Optional
from uuid import UUID

from pydantic import BaseModel, Field


class ClipboardHistoryEntry(BaseModel):
    """A single clipboard history entry."""

    id: UUID = Field(..., description="Unique entry ID")
    message_id: str = Field(..., description="Message ID from sync protocol")
    content_type: str = Field(default="text", description="Type of content")
    content_text: Optional[str] = Field(None, description="Clipboard text (NULL for large entries)")
    content_hash: str = Field(..., description="SHA-256 hash of content")
    source_device_id: Optional[UUID] = Field(None, description="Device that sent the content")
    delivered_count: int = Field(default=0, description="Number of devices it was delivered to")
    created_at: datetime = Field(..., description="When this entry was created")


class ClipboardHistoryResponse(BaseModel):
    """Response for clipboard history endpoints."""

    entries: List[ClipboardHistoryEntry] = Field(default_factory=list, description="List of clipboard entries")
    limit: int = Field(..., description="Requested limit")
    offset: int = Field(..., description="Requested offset")
    total: int = Field(..., description="Total number of entries returned")