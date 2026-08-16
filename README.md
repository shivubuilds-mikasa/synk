Rewrite the root README.md for the Synk project as a polished, public-facing open-source project README.
SYNK
==================================================
Synk is a cross-device ecosystem that connects a user's mobile phone and laptop so information can move seamlessly between their devices.

The first version focuses on two-way text clipboard synchronization.

Example:

Phone:
Copy → "Hello from my phone"

        ↓

       Synk

        ↓

Laptop:
Paste → "Hello from my phone"

And the reverse:

Laptop:
Copy → "Hello from my laptop"

        ↓

       Synk

        ↓

Phone:
Paste → "Hello from my laptop"

The architecture should be designed so that future versions can support:
- Images
- Videos
- Files
- Links
- Other shared content

Do NOT claim those future features are already implemented.

==================================================
CORE VISION
==================================================

Synk should feel like a personal ecosystem connecting a user's devices.

The long-term goal is:

Phone ↔ Synk ↔ Laptop

with fast, secure, seamless transfer of clipboard and other content.

The first milestone is reliable text clipboard synchronization.

==================================================
TECHNOLOGY
==================================================

Backend:
- Python
- FastAPI
- WebSockets
- Pydantic
- Pydantic Settings
- Uvicorn

Mobile:
- Flutter
- Dart

Desktop:
- Electron
- React
- JavaScript/TypeScript

The desktop application will be developed by a separate contributor.

Database:
- PostgreSQL is planned for persistent device/pairing data.
- Do not claim PostgreSQL is currently implemented.

Authentication:
- Planned.
- Do not claim it is currently implemented.

==================================================
ARCHITECTURE
==================================================

Create a clear architecture diagram.

The intended architecture is:

                 ┌──────────────────────┐
                 │      Synk Backend     │
                 │       FastAPI        │
                 │                      │
                 │ REST API + WebSocket │
                 └──────────┬───────────┘
                            │
                    WebSocket connection
                    ┌───────┴───────┐
                    │               │
             ┌──────▼──────┐ ┌─────▼───────┐
             │   Flutter   │ │   Electron  │
             │    Mobile   │ │   Desktop   │
             └─────────────┘ └─────────────┘

Explain the responsibility of each component.

Explain that the backend acts as the coordination layer rather than having the mobile and desktop applications communicate directly with each other.

==================================================
HOW SYNK WILL WORK
==================================================

Explain the intended lifecycle:

1. User installs Synk on phone.
2. User installs Synk on laptop.
3. Each application creates/registers a device identity.
4. Devices connect to the Synk backend.
5. User pairs trusted devices.
6. Devices maintain WebSocket connections.
7. Clipboard changes are detected locally.
8. Clipboard data is sent through the backend.
9. Backend routes the data to the paired device.
10. Receiving device updates its clipboard.
11. The process works in both directions.

Clearly label which parts are currently implemented and which are planned.

==================================================
CURRENT IMPLEMENTATION
==================================================

Accurately document what already exists:

Backend foundation:
- FastAPI application
- /health endpoint
- environment-based configuration
- modular API routing

WebSocket foundation:
- /ws/{device_id}
- ConnectionManager
- connection tracking
- personal messaging
- broadcasting
- disconnect handling
- JSON message handling
- invalid JSON handling

Device identity:
- device registration endpoint
- UUID4 device IDs
- mobile and desktop device types
- in-memory device registry
- device lookup endpoint
- input validation

Testing:
- automated backend tests
- WebSocket tests
- device registration tests
- current test suite passes

Clearly state that these are foundation components and the actual clipboard synchronization feature is not yet implemented.

==================================================
API
==================================================

Document the currently implemented endpoints.

Health:

GET /health

Example response:

{
  "status": "ok"
}

Device registration:

POST /api/v1/devices/register

Request:

{
  "device_name": "My Phone",
  "device_type": "mobile"
}

Response:

{
  "device_id": "UUID",
  "device_name": "My Phone",
  "device_type": "mobile"
}

Device lookup:

GET /api/v1/devices/{device_id}

Document the expected success and not-found behavior.

WebSocket:

/ws/{device_id}

Explain that the current WebSocket implementation is a communication foundation and is not yet the final clipboard protocol.

Do not invent undocumented endpoints.

==================================================
REPOSITORY STRUCTURE
==================================================

Document the current and intended repository structure.

Example:

synk/
├── backend/
│   ├── app/
│   │   ├── api/
│   │   │   └── routes/
│   │   ├── core/
│   │   ├── models/
│   │   ├── services/
│   │   └── main.py
│   ├── tests/
│   ├── requirements.txt
│   └── .env.example
│
├── mobile/
│   └── Flutter application
│
├── desktop/
│   └── Electron desktop application
│
├── docs/
│
└── README.md

Clearly distinguish existing directories/files from planned application areas.

==================================================
LOCAL DEVELOPMENT
==================================================

Provide accurate instructions for running the backend locally on Windows.

Include:

cd backend

python -m venv .venv

.venv\Scripts\activate

pip install -r requirements.txt

uvicorn app.main:app --reload

Explain that the server runs locally and show how to test:

GET http://127.0.0.1:8000/health

Testing:

pytest

Do not invent commands that do not work with the current repository.

==================================================
ROADMAP
==================================================

Create a clear roadmap.

Phase 1 — Foundation
- FastAPI backend
- WebSocket communication
- Device identity
- Device registration
- Testing

Phase 2 — Device Pairing
- Pairing flow
- Trusted device relationships
- Pairing codes
- Pairing state

Phase 3 — Authentication & Security
- Authentication
- Authorization
- Secure device communication
- Secret management
- Input validation
- Rate limiting where appropriate

Phase 4 — Persistent Storage
- PostgreSQL
- Device persistence
- Pairing persistence
- Required indexes
- Database migrations

Phase 5 — Mobile Application
- Flutter application
- Device registration
- Pairing UI
- WebSocket connection
- Clipboard monitoring
- Clipboard receiving

Phase 6 — Desktop Application
- Electron application
- Device registration
- Pairing UI
- WebSocket connection
- Clipboard monitoring
- Clipboard receiving

Phase 7 — Text Clipboard Sync
- Phone → Laptop
- Laptop → Phone
- Loop prevention
- Duplicate prevention
- Reconnection handling
- Offline/reconnection behavior

Phase 8 — Rich Content
- Images
- Files
- Videos
- Links
- Content metadata

Phase 9 — Production
- Deployment
- Monitoring
- Logging
- Security hardening
- Performance optimization

==================================================
SECURITY
==================================================

Explain the security goals without pretending they are already implemented.

Mention that future versions should include:
- authenticated devices
- secure pairing
- authorization
- encrypted communication
- secure secret management
- validation
- rate limiting
- protection against unauthorized device registration

Clearly mark these as planned if they are not implemented.

==================================================
DESIGN PRINCIPLES
==================================================

Document the project's engineering principles:

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

==================================================
DEVELOPMENT WORKFLOW
==================================================

Explain the Git workflow:

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

Mention that feature branches should be used instead of directly developing on main.

==================================================
PROJECT STATUS
==================================================

Add a concise status section.

Use:

Implemented:
- Backend foundation
- WebSocket foundation
- Device registration
- Device identity
- Automated tests

In Progress:
- Architecture expansion toward device pairing

Planned:
- Pairing
- Authentication
- Database
- Flutter client
- Electron client
- Clipboard synchronization
- Rich content synchronization
- Production deployment

Do not make the README sound unfinished or like a temporary development diary. Present the current implementation as the foundation of the larger Synk product.

==================================================
CONTRIBUTING
==================================================

Add simple contribution guidelines:

1. Fork/clone the repository.
2. Create a feature branch.
3. Make focused changes.
4. Add/update tests.
5. Run the test suite.
6. Commit with a meaningful message.
7. Open a pull request.

Do not invent a code of conduct or contribution policy that doesn't exist.

==================================================
LICENSE
==================================================

If the repository does not currently contain a LICENSE file, say:

"License: Not yet selected."

Do not invent a license.

==================================================
STYLE
==================================================

Make the README visually strong and professional.

Use:
- clear headings
- concise explanations
- Markdown code blocks
- architecture diagrams
- tables where useful
- checkboxes for roadmap/status
- appropriate emojis, but don't overuse them

The README should feel like a serious open-source developer project, not a school assignment.

Do NOT:
- add fake badges
- add fake deployment links
- add fake screenshots
- claim unfinished features are working
- invent API endpoints
- invent database schemas
- invent authentication mechanisms
- invent contributors
- invent metrics
- add unnecessary marketing language

Only update README.md.

After writing it:
1. Show me the complete final README.
2. Verify all current implementation claims against the code.
3. Do not modify application code.
4. Do not commit anything.
