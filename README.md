# Synk

Synk synchronizes text clipboard content between paired mobile and desktop devices through a FastAPI backend. The repository contains a Flutter mobile app, an Electron desktop app, and a PostgreSQL-backed service.

## Current status

- Device registration creates a UUID identity and an authentication token. Tokens are stored hashed by the backend and kept in platform secure storage by the clients.
- Pairing uses a short-lived, one-time six-digit code; established pairings are persisted in PostgreSQL.
- Authenticated WebSockets relay text clipboard changes to paired online devices, acknowledge delivery, and support clipboard history synchronization.
- The mobile and desktop apps include registration and clipboard sync flows. Mobile also supports creating and confirming pairing codes and viewing paired devices.
- Images and files, account-based authentication, and production deployment are not implemented.

## Repository layout

```text
backend/  FastAPI app, SQLAlchemy models, Alembic migrations, pytest suite
mobile/   Flutter client
desktop/  Electron + TypeScript client
docs/     API, architecture, and WebSocket protocol
```

## Run locally

Prerequisites: Python 3.11+, PostgreSQL 16+, Node.js/npm, and Flutter/Dart. The backend defaults to `postgresql+asyncpg://synk:synk@localhost:5432/synk`; override it with `DATABASE_URL` or create `backend/.env` from `.env.example`.

Start PostgreSQL from the repository root:

```powershell
docker compose up -d postgres
```

Set up and start the backend:

```powershell
cd backend
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
alembic upgrade head
uvicorn app.main:app --reload
```

The API docs are at `http://127.0.0.1:8000/docs`; health check is `http://127.0.0.1:8000/health`.

Run the desktop client in another terminal:

```powershell
cd desktop
npm ci
npm run dev
```

Run the mobile client with a backend URL reachable from the target device (Android emulator uses `10.0.2.2`):

```powershell
cd mobile
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

## Verification

```powershell
# Backend (from backend/)
python -m pytest tests -q

# Desktop (from desktop/)
npm test
npm run typecheck
npm run build

# Mobile (from mobile/)
dart run build_runner build
flutter analyze
flutter test
```

For backend tests, start the dedicated test database with `docker compose up -d postgres_test`; tests use port `5433` by default. See [backend/TESTING.md](backend/TESTING.md).

## Documentation

- [API reference](docs/api.md)
- [Architecture](docs/architecture.md)
- [WebSocket protocol](docs/protocol.md)
