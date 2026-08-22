"""Device pairing API routes for Synk backend."""

from fastapi import APIRouter, HTTPException, status

from app.models.pairing import (
    PairingCreateRequest,
    PairingCreateResponse,
    PairingConfirmRequest,
    PairingConfirmResponse,
    PairedDevicesResponse,
)
from app.services.pairing_registry import pairing_registry

router = APIRouter(prefix="/api/v1/pairing", tags=["pairing"])


@router.post(
    "/create",
    response_model=PairingCreateResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create a pairing code",
    description="Generate a 6-digit pairing code for the given device. The code expires in 5 minutes and can only be used once.",
)
async def create_pairing_code(request: PairingCreateRequest) -> PairingCreateResponse:
    """Create a new pairing request.

    Args:
        request: PairingCreateRequest containing device_id.

    Returns:
        PairingCreateResponse with the 6-digit code and expiration timestamp.

    Raises:
        HTTPException: 404 if device not found, 422 for invalid request data.
    """
    try:
        pending = await pairing_registry.create_pairing_request(request.device_id)

        # Format expiration as ISO 8601 UTC
        from datetime import datetime, timezone
        expires_at = datetime.fromtimestamp(pending.expires_at, tz=timezone.utc).isoformat().replace("+00:00", "Z")

        return PairingCreateResponse(
            code=pending.code,
            expires_at=expires_at,
            device_id=request.device_id,
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
    description="Confirm a pairing using a 6-digit code. Creates a trusted pairing relationship between two devices.",
)
async def confirm_pairing(request: PairingConfirmRequest) -> PairingConfirmResponse:
    """Confirm a pairing with a code.

    Args:
        request: PairingConfirmRequest containing device_id and code.

    Returns:
        PairingConfirmResponse with paired device information.

    Raises:
        HTTPException:
            404 if device not found
            400/409 for invalid/expired/used code
            422 for invalid request data
    """
    try:
        initiator_device, confirming_device = await pairing_registry.confirm_pairing(
            request.device_id, request.code
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
    description="Retrieve all devices currently paired with the specified device.",
)
async def get_paired_devices(device_id: str) -> PairedDevicesResponse:
    """Get all paired devices for a given device.

    Args:
        device_id: The unique device identifier.

    Returns:
        PairedDevicesResponse with list of paired devices.

    Raises:
        HTTPException: 404 if device not found.
    """
    try:
        paired_devices = await pairing_registry.get_paired_devices(device_id)

        return PairedDevicesResponse(
            device_id=device_id,
            paired_devices=paired_devices,
        )
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=str(e),
        )