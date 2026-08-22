"""Authentication service for Synk backend.

This service handles secure token generation, hashing, and verification.
"""

import hashlib
import hmac
import secrets
from datetime import datetime, timezone
from typing import Optional
from uuid import UUID

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.db.models.auth import AuthTokenModel
from app.db.models.device import DeviceModel


class AuthService:
    """Service for managing device authentication tokens.

    Security principles:
    - Never store raw tokens in the database
    - Use cryptographically secure random token generation
    - Use constant-time comparison for token verification
    - Hash tokens with SHA-256 before storage
    - Never log raw tokens
    """

    # Token format: "synk_" + 32 random bytes (hex) = 69 chars
    TOKEN_PREFIX = "synk_"
    TOKEN_BYTES = 32
    TOKEN_LENGTH = len(TOKEN_PREFIX) + (TOKEN_BYTES * 2)  # 5 + 64 = 69

    def __init__(self) -> None:
        """Initialize the authentication service."""
        pass

    def generate_token(self) -> str:
        """Generate a cryptographically secure random authentication token.

        Returns:
            A token string prefixed with 'synk_' followed by 64 hex characters.
        """
        random_bytes = secrets.token_bytes(self.TOKEN_BYTES)
        return self.TOKEN_PREFIX + random_bytes.hex()

    def hash_token(self, token: str) -> str:
        """Hash a token using SHA-256.

        Args:
            token: The raw authentication token.

        Returns:
            Hex-encoded SHA-256 hash of the token.
        """
        return hashlib.sha256(token.encode("utf-8")).hexdigest()

    def verify_token(self, token: str, token_hash: str) -> bool:
        """Verify a token against its hash using constant-time comparison.

        Args:
            token: The raw token to verify.
            token_hash: The stored hash to verify against.

        Returns:
            True if the token matches the hash, False otherwise.
        """
        computed_hash = self.hash_token(token)
        return hmac.compare_digest(computed_hash, token_hash)

    async def create_token(
        self,
        session: AsyncSession,
        device_id: UUID,
        expires_at: Optional[datetime] = None,
    ) -> tuple[str, AuthTokenModel]:
        """Create a new authentication token for a device.

        Args:
            session: Database session.
            device_id: UUID of the device to create token for.
            expires_at: Optional expiration timestamp. None means no expiration.

        Returns:
            Tuple of (raw_token, AuthTokenModel) where raw_token is only returned once.
        """
        # Generate secure token
        raw_token = self.generate_token()
        token_hash = self.hash_token(raw_token)

        # Create token model
        auth_token = AuthTokenModel(
            device_id=device_id,
            token_hash=token_hash,
            expires_at=expires_at,
        )

        session.add(auth_token)
        await session.flush()
        await session.refresh(auth_token)

        return raw_token, auth_token

    async def get_token_by_hash(self, session: AsyncSession, token_hash: str) -> Optional[AuthTokenModel]:
        """Find an auth token by its hash.

        Args:
            session: Database session.
            token_hash: The hash to look up.

        Returns:
            AuthTokenModel if found and active, None otherwise.
        """
        result = await session.execute(
            select(AuthTokenModel).where(
                AuthTokenModel.token_hash == token_hash,
            )
        )
        token = result.scalar_one_or_none()

        if token is None:
            return None

        # Check if token is still active
        if not token.is_active:
            return None

        return token

    async def verify_token_string(self, session: AsyncSession, token: str) -> Optional[AuthTokenModel]:
        """Verify a raw token string and return the associated token model if valid.

        Args:
            session: Database session.
            token: The raw token string to verify.

        Returns:
            AuthTokenModel if valid, None otherwise.
        """
        token_hash = self.hash_token(token)
        return await self.get_token_by_hash(session, token_hash)

    async def update_last_used(self, session: AsyncSession, token: AuthTokenModel) -> None:
        """Update the last_used_at timestamp for a token.

        Args:
            session: Database session.
            token: The token to update.
        """
        token.last_used_at = datetime.now(timezone.utc)
        await session.flush()

    async def revoke_token(self, session: AsyncSession, token: AuthTokenModel) -> None:
        """Revoke a token.

        Args:
            session: Database session.
            token: The token to revoke.
        """
        token.revoked_at = datetime.now(timezone.utc)
        await session.flush()

    async def revoke_all_for_device(self, session: AsyncSession, device_id: UUID) -> int:
        """Revoke all tokens for a device.

        Args:
            session: Database session.
            device_id: Device UUID.

        Returns:
            Number of tokens revoked.
        """
        result = await session.execute(
            select(AuthTokenModel).where(
                AuthTokenModel.device_id == device_id,
                AuthTokenModel.revoked_at.is_(None),
            )
        )
        tokens = list(result.scalars().all())

        for token in tokens:
            token.revoked_at = datetime.now(timezone.utc)

        await session.flush()
        return len(tokens)

    async def get_active_tokens_for_device(self, session: AsyncSession, device_id: UUID) -> list[AuthTokenModel]:
        """Get all active tokens for a device.

        Args:
            session: Database session.
            device_id: Device UUID.

        Returns:
            List of active AuthTokenModel instances.
        """
        result = await session.execute(
            select(AuthTokenModel).where(
                AuthTokenModel.device_id == device_id,
                AuthTokenModel.revoked_at.is_(None),
            )
        )
        tokens = list(result.scalars().all())
        # Filter out expired tokens
        return [t for t in tokens if t.is_active]


# Global auth service instance
auth_service = AuthService()