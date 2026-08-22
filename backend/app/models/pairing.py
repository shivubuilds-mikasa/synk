"""Pairing models for Synk backend.

This module defines request/response models for device pairing functionality.
"""

from typing import Annotated, Optional

from pydantic import BaseModel, Field, field_validator


class PairingCreateRequest(BaseModel):
    """Request model for creating a pairing code.

    The device_id is now obtained from the authenticated device's token,
    not from the request body.
    """
    pass


class PairingCreateResponse(BaseModel):
    """Response model for pairing code creation."""

    code: Annotated[
        str,
        Field(
            min_length=6,
            max_length=6,
            description="6-digit pairing code",
            examples=["123456"],
        ),
    ]
    expires_at: Annotated[
        str,
        Field(
            description="ISO 8601 timestamp when the code expires",
            examples=["2024-01-15T10:35:00Z"],
        ),
    ]
    device_id: Annotated[
        str,
        Field(
            description="ID of the device that created the pairing request",
        ),
    ]


class PairingConfirmRequest(BaseModel):
    """Request model for confirming a pairing code.

    The device_id is obtained from the authenticated device's token,
    not from the request body.
    """

    code: Annotated[
        str,
        Field(
            min_length=6,
            max_length=6,
            pattern=r"^\d{6}$",
            description="6-digit pairing code from the pairing device",
            examples=["123456"],
        ),
    ]

    @field_validator("code")
    @classmethod
    def validate_code_format(cls, v: str) -> str:
        """Validate code is exactly 6 digits."""
        if not v.isdigit() or len(v) != 6:
            raise ValueError("code must be exactly 6 numeric digits")
        return v


class PairingConfirmResponse(BaseModel):
    """Response model for successful pairing confirmation."""

    paired_device: Annotated[
        "PairedDeviceInfo",
        Field(description="Information about the newly paired device"),
    ]
    this_device: Annotated[
        "PairedDeviceInfo",
        Field(description="Information about the confirming device"),
    ]


class PairedDeviceInfo(BaseModel):
    """Information about a paired device."""

    device_id: Annotated[
        str,
        Field(description="Unique identifier of the paired device"),
    ]
    device_name: Annotated[
        str,
        Field(description="Human-readable name of the paired device"),
    ]
    device_type: Annotated[
        str,
        Field(description="Type of the paired device (mobile/desktop)"),
    ]


class PairedDevicesResponse(BaseModel):
    """Response model for retrieving paired devices."""

    device_id: Annotated[
        str,
        Field(description="ID of the device whose pairings are being retrieved"),
    ]
    paired_devices: Annotated[
        list[PairedDeviceInfo],
        Field(description="List of paired devices"),
    ]


# Resolve forward reference
PairingConfirmResponse.model_rebuild()


class PairingErrorResponse(BaseModel):
    """Error response model for pairing operations."""

    detail: Annotated[
        str,
        Field(description="Error description"),
    ]