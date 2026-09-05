# 🔗 Synk
**Synk** is a cross-device ecosystem that connects
your phone and laptop, letting information move 

seamlessly between them.

The first milestone: **reliable two-way text clipboard synchronization.**

```
Phone                          Laptop
 Copy → "Hello from my phone"
              ↓
            Synk
              ↓
                              Paste → "Hello from my phone"
```

```
Laptop                         Phone
 Copy → "Hello from my laptop"
              ↓
            Synk
              ↓
                              Paste → "Hello from my laptop"
```

Synk's architecture is designed from day one to extend beyond text — to images, videos, files, and links — but this first version focuses on getting clipboard sync right.

---

## 🎯 Vision

Synk aims to feel like a personal ecosystem that connects your devices:

```
Phone  ↔  Synk  ↔  Laptop
```

Fast, secure, seamless transfer of clipboard content — and eventually, much more — between the devices you use every day.

The long-term roadmap includes device pairing, authentication, persistent storage, and rich content types. The current focus is the foundation: a backend coordination layer, device identity, and real-time communication.

---

## 🧱 Technology

| Layer      | Stack |
|------------|-------|
| Backend    | Python, FastAPI, WebSockets, Pydantic, Pydantic Settings, Uvicorn |
| Mobile     | Flutter, Dart |
| Desktop    | Electron, React, JavaScript/TypeScript *(developed by a separate contributor)* |
| Database   | PostgreSQL — **planned**, not yet implemented |
| Auth       | **Planned**, not yet implemented |

---

## 🏗️ Architecture

```
                 ┌───────────────────────┐
                 │      Synk Backend     │
                 │        FastAPI        │
                 │                       │
                 │  REST API + WebSocket │
                 └───────────┬───────────┘
                             │
                     WebSocket connection
                     ┌───────┴───────┐
                     │               │
              ┌──────▼──────┐ ┌──────▼──────┐
              │   Flutter   │ │   Electron  │
              │    Mobile   │ │   Desktop   │
              └─────────────┘ └─────────────┘
```

**Backend (FastAPI)** — the coordination layer. It owns device identity, manages WebSocket connections, and will own pairing, auth, and message routing. Mobile and desktop clients never talk to each other directly; everything is routed through the backend. Centralizing this logic keeps the clients thin and keeps the protocol easy to extend to new content types later.

**Mobile (Flutter)** — registers a device identity, connects to the backend, monitors the system clipboard, and will send/receive clipboard events once sync is implemented.

**Desktop (Electron)** — same responsibilities as the mobile client, for laptop/desktop environments. Developed by a separate contributor.

---

## 🔄 How Synk Will Work

| Step | Description | Status |
|------|-------------|--------|
| 1 | User installs Synk on phone | 🔜 Planned |
| 2 | User installs Synk on laptop | 🔜 Planned |
| 3 | Each app creates/registers a device identity | ✅ Implemented (backend endpoint) |
| 4 | Devices connect to the Synk backend | ✅ Implemented (WebSocket foundation) |
| 5 | User pairs trusted devices | 🔜 Planned |
| 6 | Devices maintain WebSocket connections | ✅ Implemented (foundation) |
| 7 | Clipboard changes are detected locally | 🔜 Planned |
| 8 | Clipboard data is sent through the backend | 🔜 Planned |
| 9 | Backend routes data to the paired device | 🔜 Planned |
| 10 | Receiving device updates its clipboard | 🔜 Planned |
| 11 | The process works in both directions | 🔜 Planned |

---

## ✅ Current Implementation

Synk's backend currently provides the **foundation** the rest of the system will be built on. Clipboard synchronization itself is **not yet implemented** — what exists today is device identity, real-time connectivity, and the scaffolding to route messages between devices.

**Backend foundation**
- FastAPI application
- `/health` endpoint
- Environment-based configuration
- Modular API routing

**WebSocket foundation**
- `/ws/{device_id}` endpoint
- `ConnectionManager` for tracking active connections
- Personal (targeted) messaging
- Broadcasting
- Disconnect handling
- JSON message handling, including invalid JSON handling

**Device identity**
- Device registration endpoint
- UUID4-based device IDs
- Support for `mobile` and `desktop` device types
- In-memory device registry
- Device lookup endpoint
- Input validation

**Testing**
- Automated backend test suite
- WebSocket connection tests
- Device registration tests
- Current test suite passes

---

## 📡 API

### Health

```
GET /health
```

**Response**
```json
{
  "status": "ok"
}
```

### Register a device

```
POST /api/v1/devices/register
```

**Request**
```json
{
  "device_name": "My Phone",
  "device_type": "mobile"
}
```

**Response**
```json
{
  "device_id": "UUID",
  "device_name": "My Phone",
  "device_type": "mobile"
}
```

### Look up a device

```
GET /api/v1/devices/{device_id}
```

Returns the device's details on success, or a not-found response if no device matches the given ID.

### WebSocket

```
/ws/{device_id}
```

This is the current real-time communication foundation for Synk — connection tracking, message passing, and disconnect handling. It is **not yet the final clipboard sync protocol**; that protocol will be layered on top as clipboard sync is implemented.

> These are the only endpoints currently implemented. No other routes exist yet.

---

## 📁 Repository Structure

```
synk/
├── backend/                  # ✅ Implemented
│   ├── app/
│   │   ├── api/
│   │   │   └── routes/       # Health, device, WebSocket routes
│   │   ├── core/             # Configuration
│   │   ├── models/           # Data models
│   │   ├── services/         # Business logic
│   │   └── main.py
│   ├── tests/
│   ├── requirements.txt
│   └── .env.example
│
├── mobile/                   # 🔜 Planned — Flutter application
│
├── desktop/                  # 🔜 Planned — Electron desktop application
│
├── docs/
│
└── README.md
```

---

## 💻 Local Development

Currently, only the backend is runnable. Instructions below are for Windows.

```powershell
cd backend

python -m venv .venv

.venv\Scripts\activate

pip install -r requirements.txt

uvicorn app.main:app --reload
```

The server will start locally. Verify it's running:

```
GET http://127.0.0.1:8000/health
```

**Run the test suite**

```powershell
pytest
```

---

---

## 🔒 Security

Security is a core design goal for Synk, not an afterthought. The following are **planned**, not yet implemented:

- Authenticated devices
- Secure pairing between trusted devices
- Authorization checks on all sensitive operations
- Encrypted communication between clients and backend
- Secure secret management
- Comprehensive input validation
- Rate limiting on sensitive endpoints
- Protection against unauthorized device registration

---

## 🧭 Design Principles

- Keep mobile and desktop clients thin.
- Keep synchronization logic centralized where appropriate.
- Separate API routes from business logic.
- Keep services modular.
- Prefer explicit data models.
- Avoid unnecessary dependencies.
- Write tests for important behavior.
- Build incrementally.
- Do not over-engineer early versions.
- Keep the protocol extensible for future content types.

---

## 🌱 Development Workflow

```
main
  ↓
feature branch
  ↓
implementation
  ↓
tests
  ↓
commit
  ↓
pull request
  ↓
review
  ↓
merge
```

All changes are made on feature branches — direct development on `main` is avoided.

---

## 📊 Project Status

**Implemented**
- Backend foundation
- WebSocket foundation
- Device registration
- Device identity
- Automated tests

**In Progress**
- Architecture expansion toward device pairing

**Planned**
- Pairing
- Authentication
- Database (PostgreSQL)
- Flutter mobile client
- Electron desktop client
- Clipboard synchronization
- Rich content synchronization (images, files, videos, links)
- Production deployment

Synk today is the foundation layer of a larger product — device identity and real-time communication are working and tested, and the rest of the system is being built on top of them.

---

## 🤝 Contributing

1. Fork/clone the repository.
2. Create a feature branch.
3. Make focused changes.
4. Add/update tests.
5. Run the test suite.
6. Commit with a meaningful message.
7. Open a pull request.

---

## 📄 License

License: Not yet selected.
