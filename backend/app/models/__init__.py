"""Device models package for Synk backend."""

from app.models.device import Device, DeviceRegistrationRequest, DeviceResponse, DeviceType
from app.models.pairing import (
    PairingConfirmRequest,
    PairingConfirmResponse,
    PairingCreateRequest,
    PairingCreateResponse,
    PairedDeviceInfo,
    PairedDevicesResponse,
)

__all__ = [
    "Device",
    "DeviceRegistrationRequest",
    "DeviceResponse",
    "DeviceType",
    "PairingConfirmRequest",
    "PairingConfirmResponse",
    "PairingCreateRequest",
    "PairingCreateResponse",
    "PairedDeviceInfo",
    "PairedDevicesResponse",
]