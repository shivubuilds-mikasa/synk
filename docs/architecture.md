# Synk architecture

Synk V1 moves text clipboard updates between a user's paired devices. Mobile and desktop clients connect to the backend; they do not connect directly to one another.

```text
Flutter mobile ── REST + authenticated WebSocket ── FastAPI ── PostgreSQL
Electron desktop ─ REST + authenticated WebSocket ──┘
```

## Components

- **FastAPI backend:** registration, bearer-token authentication, pairing, clipboard history, WebSocket sessions, validation, routing, and delivery receipts.
- **PostgreSQL:** devices, hashed auth tokens, pairings, and clipboard history. Schema changes are managed with Alembic.
- **Flutter mobile:** registers a device, stores credentials in secure storage, offers pairing flows, monitors clipboard changes while the app is active, and syncs over WebSocket.
- **Electron desktop:** registers a device, uses OS secure storage for credentials, polls clipboard changes, and syncs over WebSocket.

Pairing codes are transient in-memory requests with a five-minute expiry and one-time use. Confirmed device relationships are persistent database records. WebSocket connections are transient and maintained by the backend connection manager.

## Data flow

1. A client registers over REST and receives a device UUID and one-time raw token.
2. The backend stores only a hash of the token; the client stores the raw token securely.
3. The user pairs devices by creating a six-digit code on one device and confirming it on another.
4. Each client authenticates its WebSocket with the token in the first message.
5. Clipboard updates are validated, recorded in history, and relayed to the sender's paired devices that are online.
6. Receivers update their local clipboard and send delivery receipts. History sync can replay recent stored text.

## Current boundaries

V1 supports text only. Pairing codes are in memory, so a server restart invalidates outstanding codes; confirmed pairings and history remain in PostgreSQL. Mobile clipboard monitoring depends on the operating system and app lifecycle and is not a background service on every platform. Production hardening and deployment configuration remain future work.
