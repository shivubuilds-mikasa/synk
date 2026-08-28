# Testing Synk Backend
## Prerequisites

The tests require a PostgreSQL database. You have two options:

### Option 1: Docker (Recommended)

```bash
# From the project root
docker compose up -d

# This starts:
# - postgres (port 5432) - main database
# - postgres_test (port 5433) - test database
```

### Option 2: Local PostgreSQL Installation

1. Install PostgreSQL 16+
2. Create databases and user:

```sql
-- Connect as postgres superuser
CREATE USER synk WITH PASSWORD 'synk';
CREATE DATABASE synk OWNER synk;
CREATE DATABASE synk_test OWNER synk;
GRANT ALL PRIVILEGES ON DATABASE synk TO synk;
GRANT ALL PRIVILEGES ON DATABASE synk_test TO synk;
```

## Running Tests

### 1. Start PostgreSQL (if using Docker)

```bash
docker compose up -d
```

### 2. Run Database Migrations

```bash
cd backend
# For main database
alembic upgrade head

# For test database (if using separate test DB)
TEST_DATABASE_URL=postgresql+asyncpg://synk:synk@localhost:5433/synk_test alembic upgrade head
```

### 3. Run Tests

```bash
cd backend

# Run all tests
python -m pytest tests/ -v

# Run specific test file
python -m pytest tests/test_devices.py -v

# Run specific test class
python -m pytest tests/test_devices.py::TestDeviceRegistration -v

# Run specific test
python -m pytest tests/test_devices.py::TestDeviceRegistration::test_register_mobile_device -v

# Run with coverage
python -m pytest tests/ --cov=app --cov-report=term-missing
```

## Test Database Configuration

The test configuration in `tests/conftest.py` uses:
- **Test Database URL**: `postgresql+asyncpg://synk:synk@localhost:5433/synk_test`
- Override with `TEST_DATABASE_URL` environment variable if needed

The test fixtures automatically:
1. Create a test engine
2. Drop and recreate all tables before each test session
3. Use transaction rollback for test isolation (each test runs in its own transaction)
4. Override the `get_db` dependency to use the test session

## Test Structure

- `tests/conftest.py` - Pytest fixtures and configuration
- `tests/test_devices.py` - Device registration and retrieval tests (20 tests)
- `tests/test_pairing.py` - Device pairing tests (32 tests)
- `tests/test_websocket.py` - WebSocket tests (13 tests)

Total: 65 tests

## Troubleshooting

### Connection Refused
```
ConnectionRefusedError: [WinError 1225] The remote computer refused the network connection
```
- Make sure PostgreSQL is running on the correct port
- For Docker: `docker compose ps` should show containers as "healthy"
- Check firewall/antivirus isn't blocking localhost connections

### Migration Errors
```
alembic.util.exc.CommandError: Can't locate revision identified by '...'
```
- Make sure you're in the `backend` directory
- Run `alembic upgrade head` to apply all migrations

### Test Failures
- Tests use transaction rollback for isolation
- Each test gets a fresh database state
- In-memory pairing codes are cleared between tests via `clear_registries` fixture

## CI/CD

For CI environments, set the `TEST_DATABASE_URL` environment variable to point to your CI PostgreSQL instance:

```bash
export TEST_DATABASE_URL=postgresql+asyncpg://user:pass@host:port/dbname
python -m pytest tests/
```
