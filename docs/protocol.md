# Synk Communication Protocol

## Overview

Synk uses WebSockets for real-time communication between the mobile app, backend, and desktop app.

All WebSocket messages use JSON.

---

## Message Format

Every message should contain:
```json
{
  "type": "message_type",
  "data": {}
}
