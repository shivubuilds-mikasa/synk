"""Initial migration: devices and pairings tables

Revision ID: 001
Revises:
Create Date: 2024-01-15 10:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = "001"
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # Create devices table
    op.create_table(
        "devices",
        sa.Column("id", postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column("device_name", sa.String(100), nullable=False),
        sa.Column(
            "device_type",
            sa.Enum("mobile", "desktop", name="device_type_enum"),
            nullable=False,
        ),
        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            server_default=sa.text("now()"),
            nullable=False,
        ),
        sa.Column(
            "updated_at",
            sa.DateTime(timezone=True),
            server_default=sa.text("now()"),
            nullable=False,
        ),
        sa.PrimaryKeyConstraint("id", name="pk_devices"),
    )

    # Create pairings table
    op.create_table(
        "pairings",
        sa.Column("id", postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column("device_a_id", postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column("device_b_id", postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            server_default=sa.text("now()"),
            nullable=False,
        ),
        sa.Column(
            "updated_at",
            sa.DateTime(timezone=True),
            server_default=sa.text("now()"),
            nullable=False,
        ),
        sa.ForeignKeyConstraint(
            ["device_a_id"],
            ["devices.id"],
            name="fk_pairings_device_a_id_devices",
            ondelete="CASCADE",
        ),
        sa.ForeignKeyConstraint(
            ["device_b_id"],
            ["devices.id"],
            name="fk_pairings_device_b_id_devices",
            ondelete="CASCADE",
        ),
        sa.PrimaryKeyConstraint("id", name="pk_pairings"),
        sa.UniqueConstraint(
            "device_a_id", "device_b_id", name="uq_pairing_devices"
        ),
    )

    # Create indexes
    op.create_index(
        "ix_pairings_device_a_id", "pairings", ["device_a_id"], unique=False
    )
    op.create_index(
        "ix_pairings_device_b_id", "pairings", ["device_b_id"], unique=False
    )


def downgrade() -> None:
    # Drop indexes
    op.drop_index("ix_pairings_device_a_id", table_name="pairings")
    op.drop_index("ix_pairings_device_b_id", table_name="pairings")

    # Drop tables
    op.drop_table("pairings")
    op.drop_table("devices")

    # Drop enum type
    op.execute("DROP TYPE IF EXISTS device_type_enum")