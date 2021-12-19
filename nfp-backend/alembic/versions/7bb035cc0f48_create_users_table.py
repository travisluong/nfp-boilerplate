"""create users table

Revision ID: 7bb035cc0f48
Revises: df0d975d6fc2
Create Date: 2021-12-19 00:05:48.045380

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '7bb035cc0f48'
down_revision = 'df0d975d6fc2'
branch_labels = None
depends_on = None


def upgrade():
    op.create_table(
        "users",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("username", sa.String, unique=True),
        sa.Column("hashed_password", sa.String)
    )


def downgrade():
    op.drop_table("users")
