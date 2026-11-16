# Synk HTTP API

Base path: `/api/v1`. Interactive OpenAPI docs are served at `/docs` by FastAPI. Except for health and registration, routes require `Authorization: Bearer <device-token>`.

## Health

`GET /health` returns `{"status":"ok"}`.

## Devices

`POST /devices/register` (no authentication)

```json
{"device_name":"My Phone","device_type":"mobile"}
```

Device type is `mobile` or `desktop`. The response contains `device_id`, `device_name`, `device_type`, and `auth_token`. Save the token securely; it is only returned at registration.

`GET /devices/{device_id}` returns the authenticated device's public details. A device cannot read another device's record.

## Pairing

`POST /pairing/create` creates a six-digit code for the authenticated device. Response: `code`, `expires_at` (UTC ISO-8601), and `device_id`. The code expires after five minutes and can be used once.

`POST /pairing/confirm` accepts `{"code":"123456"}`. The authenticated device joins the code creator's pairing; the response includes `paired_device` and `this_device` summaries. Invalid/expired/self-pairing codes are rejected; reused or duplicate pairings return a conflict.

`GET /pairing/{device_id}` lists the authenticated device's paired devices. Only the caller's own device ID is authorized.

## Clipboard history

`GET /clipboard/history?limit=50&offset=0` returns entries received by the authenticated device. `limit` is 1–100 and `offset` is zero or greater.

`GET /clipboard/history/sent?limit=50&offset=0` returns entries sent by the authenticated device.

`GET /clipboard/history/{message_id}` returns a single history entry visible to the authenticated device or a 404 response.

## WebSocket

Connect to `/ws/{device_id}` and authenticate with a first message containing the token. The UUID in the path is a routing hint; identity is taken from the verified token. Message details are in [protocol.md](protocol.md).
