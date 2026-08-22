"""FastAPI dependencies for Synk backend."""

from typing import Optional
from uuid import UUID

from fastapi import Depends, Header, HTTPException, status
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.db.database import get_db
from app.db.models.auth import AuthTokenModel
from app.db.models.device import DeviceModel
from app.services.auth_service import auth_service


async def get_current_device(
    db: AsyncSession = Depends(get_db),
    authorization: Optional[str] = Header(None),
) -> DeviceModel:
    """FastAPI dependency to get the currently authenticated device.

    Extracts and validates the Bearer token from the Authorization header,
    returns the associated DeviceModel if authentication succeeds.

    Args:
        db: Database session.
        authorization: Authorization header value.

    Returns:
        The authenticated DeviceModel.

    Raises:
        HTTPException: 401 if authentication fails.
    """
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Invalid or missing authentication token",
        headers={"WWW-Authenticate": "Bearer"},
    )

    if authorization is None:
        raise credentials_exception

    # Parse Bearer token
    parts = authorization.split()
    if len(parts) != 2 or parts[0].lower() != "bearer":
        raise credentials_exception

    token = parts[1]

    # Validate token format (basic check - must start with prefix)
    if not token.startswith(auth_service.TOKEN_PREFIX):
        raise credentials_exception

    # Verify token
    auth_token = await auth_service.verify_token_string(db, token)
    if auth_token is None:
        raise credentials_exception

    # Update last_used_at
    await auth_service.update_last_used(db, auth_token)
    await db.commit()

    # Get the associated device
    result = await db.execute(
        select(DeviceModel).where(DeviceModel.id == auth_token.device_id)
    )
    device = result.scalar_one_or_none()

    if device is None:
        # This shouldn't happen due to FK constraints, but handle gracefully
        raise credentials_exception

    return device


async def get_current_device_id(
    current_device: DeviceModel = Depends(get_current_device),
) -> UUID:
    """FastAPI dependency to get the currently authenticated device's ID.

    Args:
        current_device: The authenticated device from get_current_device.

    Returns:
        The device's UUID.
    """
    return current_device.id


def require_device_access(
    requested_device_id: UUID,
    current_device_id: UUID,
    allow_self_only: bool = True,
) -> None:
    """Check if the current device has permission to access the requested device's resources.

    Args:
        requested_device_id: The device ID being requested.
        current_device_id: The authenticated device's ID.
        allow_self_only: If True, only allow access to own resources. If False, allow all.

    Raises:
        HTTPException: 403 if access is denied.
    """
    if allow_self_only and requested_device_id != current_device_id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Access denied: cannot access another device's resources",
        )