"""Device registration API routes for Synk backend."""

from fastapi import APIRouter, Depends, HTTPException, status
from uuid import UUID

from app.api.deps import get_current_device_id, require_device_access
from app.models.device import DeviceRegistrationRequest, DeviceRegistrationResponse, DeviceResponse
from app.services.device_registry import device_registry

router = APIRouter(prefix="/api/v1/devices", tags=["devices"])


@router.post(
    "/register",
    response_model=DeviceRegistrationResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Register a new device",
    description="Register a new Synk device with a name and type. Returns the generated device ID and authentication token (only returned once).",
)
async def register_device(request: DeviceRegistrationRequest) -> DeviceRegistrationResponse:
    """Register a new device.

    Args:
        request: Device registration request containing device_name and device_type.

    Returns:
        DeviceRegistrationResponse with generated device_id, device_name, device_type, and auth_token.

    Raises:
        HTTPException: If validation fails (handled by FastAPI/Pydantic).
    """
    device, auth_token = await device_registry.register(request)
    return DeviceRegistrationResponse(
        device_id=device.device_id,
        device_name=device.device_name,
        device_type=device.device_type,
        auth_token=auth_token,
    )


@router.get(
    "/{device_id}",
    response_model=DeviceResponse,
    response_model_exclude_none=True,
    summary="Get device by ID",
    description="Retrieve a registered device by its unique identifier. Requires authentication. A device can only access its own information.",
)
async def get_device(
    device_id: str,
    current_device_id: UUID = Depends(get_current_device_id),
) -> DeviceResponse:
    """Retrieve a device by its ID.

    Args:
        device_id: The unique device identifier.
        current_device_id: The authenticated device's ID (from dependency).

    Returns:
        DeviceResponse with device details.

    Raises:
        HTTPException: 401 if not authenticated, 403 if accessing another device, 404 if not found.
    """
    # Validate UUID format
    import uuid
    try:
        requested_device_id = UUID(device_id)
    except ValueError:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Device with ID '{device_id}' not found",
        )

    # Check if device exists first
    device = await device_registry.get(device_id)
    if device is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Device with ID '{device_id}' not found",
        )

    # Check authorization - device can only access its own info
    require_device_access(requested_device_id, current_device_id, allow_self_only=True)

    # Return response without auth_token (exclude_none doesn't work because field has default=None)
    return DeviceResponse(
        device_id=device.device_id,
        device_name=device.device_name,
        device_type=device.device_type,
    )