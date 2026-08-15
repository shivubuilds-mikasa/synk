"""Device models for Synk backend."""

from enum import Enum
from typing import Annotated

from pydantic import BaseModel, Field, field_validator


class DeviceType(str, Enum):
    """Supported device types for V1."""

    MOBILE = "mobile"
    DESKTOP = "desktop"


class DeviceRegistrationRequest(BaseModel):
    """Request model for device registration."""

    device_name: Annotated[
        str,
        Field(
            min_length=1,
            max_length=100,
            description="Human-readable name for the device",
            examples=["Shivu's Phone", "Work Laptop", "Personal iPad"],
        ),
    ]
    device_type: Annotated[
        DeviceType,
        Field(description="Type of device being registered"),
    ]

    @field_validator("device_name")
    @classmethod
    def validate_device_name(cls, v: str) -> str:
        """Validate device name is not just whitespace."""
        if not v or not v.strip():
            raise ValueError("device_name cannot be empty or whitespace only")
        return v.strip()


class DeviceResponse(BaseModel):
    """Response model for device registration and retrieval."""

    device_id: Annotated[
        str,
        Field(
            min_length=1,
            description="Unique identifier for the device",
            examples=["550e8400-e29b-41d4-a716-446655440000"],
        ),
    ]
    device_name: Annotated[
        str,
        Field(
            min_length=1,
            max_length=100,
            description="Human-readable name for the device",
        ),
    ]
    device_type: Annotated[
        DeviceType,
        Field(description="Type of device"),
    ]


class Device(BaseModel):
    """Internal device model for registry storage."""

    device_id: str
    device_name: str
    device_type: DeviceType

    def to_response(self) -> DeviceResponse:
        """Convert to API response model."""
        return DeviceResponse(
            device_id=self.device_id,
            device_name=self.device_name,
            device_type=self.device_type,
        )