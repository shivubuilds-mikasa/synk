"""Device pairing API routes for Synk backend."""

from fastapi import APIRouter, Depends, HTTPException, status
from uuid import UUID

from app.api.deps import get_current_device_id, require_device_access
from app.models.pairing import (
    PairingCreateRequest,
    PairingCreateResponse,
    PairingConfirmRequest,
    PairingConfirmResponse,
    PairedDevicesResponse,
)
from app.services.device_registry import device_registry
from app.services.pairing_registry import pairing_registry

router = APIRouter(prefix="/api/v1/pairing", tags=["pairing"])


@router.post(
    "/create",
    response_model=PairingCreateResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create a pairing code",
    description="Generate a 6-digit pairing code for the authenticated device. The code expires in 5 minutes and can only be used once. Requires authentication.",
)
async def create_pairing_code(
    current_device_id: UUID = Depends(get_current_device_id),
) -> PairingCreateResponse:
    """Create a new pairing request for the authenticated device.

    Args:
        current_device_id: The authenticated device's ID (from dependency).

    Returns:
        PairingCreateResponse with the 6-digit code and expiration timestamp.

    Raises:
        HTTPException: 401 if not authenticated, 404 if device not found.
    """
    try:
        # Use the authenticated device's ID instead of request parameter
        pending = await pairing_registry.create_pairing_request(str(current_device_id))

        # Format expiration as ISO 8601 UTC
        from datetime import datetime, timezone
        expires_at = datetime.fromtimestamp(pending.expires_at, tz=timezone.utc).isoformat().replace("+00:00", "Z")

        return PairingCreateResponse(
            code=pending.code,
            expires_at=expires_at,
            device_id=str(current_device_id),
        )
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=str(e),
        )


@router.post(
    "/confirm",
    response_model=PairingConfirmResponse,
    status_code=status.HTTP_200_OK,
    summary="Confirm a pairing code",
    description="Confirm a pairing using a 6-digit code. Creates a trusted pairing relationship between two devices. Requires authentication for the confirming device.",
)
async def confirm_pairing(
    request: PairingConfirmRequest,
    current_device_id: UUID = Depends(get_current_device_id),
) -> PairingConfirmResponse:
    """Confirm a pairing with a code.

    Args:
        request: PairingConfirmRequest containing code (device_id is taken from authenticated device).
        current_device_id: The authenticated device's ID (from dependency).

    Returns:
        PairingConfirmResponse with paired device information.

    Raises:
        HTTPException:
            401 if not authenticated
            404 if device not found
            400/409 for invalid/expired/used code
            422 for invalid request data
    """
    # Use authenticated device's ID as the confirming device
    confirming_device_id = str(current_device_id)

    try:
        initiator_device, confirming_device = await pairing_registry.confirm_pairing(
            confirming_device_id, request.code
        )

        # Build response with both device perspectives
        return PairingConfirmResponse(
            paired_device={
                "device_id": initiator_device.device_id,
                "device_name": initiator_device.device_name,
                "device_type": initiator_device.device_type.value,
            },
            this_device={
                "device_id": confirming_device.device_id,
                "device_name": confirming_device.device_name,
                "device_type": confirming_device.device_type.value,
            },
        )
    except ValueError as e:
        error_msg = str(e)
        # Determine appropriate status code based on error type
        if "not found" in error_msg.lower():
            status_code = status.HTTP_404_NOT_FOUND
        elif "already been used" in error_msg.lower() or "already paired" in error_msg.lower():
            status_code = status.HTTP_409_CONFLICT
        elif "expired" in error_msg.lower():
            status_code = status.HTTP_400_BAD_REQUEST
        elif "cannot pair with itself" in error_msg.lower():
            status_code = status.HTTP_400_BAD_REQUEST
        else:
            status_code = status.HTTP_400_BAD_REQUEST

        raise HTTPException(
            status_code=status_code,
            detail=error_msg,
        )


@router.get(
    "/{device_id}",
    response_model=PairedDevicesResponse,
    status_code=status.HTTP_200_OK,
    summary="Get paired devices",
    description="Retrieve all devices currently paired with the specified device. Requires authentication. A device can only access its own pairings.",
)
async def get_paired_devices(
    device_id: str,
    current_device_id: UUID = Depends(get_current_device_id),
) -> PairedDevicesResponse:
    """Get all paired devices for a given device.

    Args:
        device_id: The unique device identifier.
        current_device_id: The authenticated device's ID (from dependency).

    Returns:
        PairedDevicesResponse with list of paired devices.

    Raises:
        HTTPException: 401 if not authenticated, 403 if accessing another device, 404 if device not found.
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

    # Check authorization - device can only access its own pairings
    require_device_access(requested_device_id, current_device_id, allow_self_only=True)

    paired_devices = await pairing_registry.get_paired_devices(device_id)

    return PairedDevicesResponse(
        device_id=device_id,
        paired_devices=paired_devices,
    )