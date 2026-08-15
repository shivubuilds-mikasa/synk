"""Device registration API routes for Synk backend."""

from fastapi import APIRouter, HTTPException, status

from app.models.device import DeviceRegistrationRequest, DeviceResponse
from app.services.device_registry import device_registry

router = APIRouter(prefix="/api/v1/devices", tags=["devices"])


@router.post(
    "/register",
    response_model=DeviceResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Register a new device",
    description="Register a new Synk device with a name and type. Returns the generated device ID.",
)
async def register_device(request: DeviceRegistrationRequest) -> DeviceResponse:
    """Register a new device.

    Args:
        request: Device registration request containing device_name and device_type.

    Returns:
        DeviceResponse with generated device_id, device_name, and device_type.

    Raises:
        HTTPException: If validation fails (handled by FastAPI/Pydantic).
    """
    device = await device_registry.register(request)
    return device.to_response()


@router.get(
    "/{device_id}",
    response_model=DeviceResponse,
    summary="Get device by ID",
    description="Retrieve a registered device by its unique identifier.",
)
async def get_device(device_id: str) -> DeviceResponse:
    """Retrieve a device by its ID.

    Args:
        device_id: The unique device identifier.

    Returns:
        DeviceResponse with device details.

    Raises:
        HTTPException: 404 if device not found.
    """
    device = await device_registry.get(device_id)
    if device is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Device with ID '{device_id}' not found",
        )
    return device.to_response()