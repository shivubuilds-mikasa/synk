# Synk WebSocket protocol

WebSocket endpoint: `/ws/{device_id}`. All messages are JSON. The server accepts a connection and expects authentication within 10 seconds. Identity comes from the token, not from the path parameter.

## Common fields

```json
{
  "type": "clipboard.update",
  "version": 1,
  "message_id": "unique-client-id",
  "device_id": "device-uuid",
  "timestamp": "2026-11-16T10:00:00Z",
  "payload": {}
}
```

## Authentication

The first client message is `{"type":"auth","token":"synk_…"}`. The server responds with `auth.success` and the authenticated device ID, or an `error` message and closes/rejects the connection.

## Clipboard update

Client sends `clipboard.update` with `payload: {"content_type":"text","text":"Copied text"}`. The backend stores history and relays `clipboard.update.relay` to paired devices currently online. The sender receives `clipboard.update.received`. Clipboard text must be non-empty; maximum message text is 100,000 characters.

## Other client messages

- `ping`: asks the server to respond with `pong`.
- `delivery.receipt`: reports a received message ID so the backend can update delivery metadata.
- `history.sync.request`: asks for recent history, optionally with a limit (1–100).

The server also sends `history.sync.response`, `device.online`, `device.offline`, `ack`, and `error` messages. Each message uses a `type`, protocol `version`, `message_id`, `device_id`, `timestamp`, and a type-specific `payload` where applicable. Consult `backend/app/models/sync.py` for the authoritative typed schemas.
