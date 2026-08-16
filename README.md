Update the root README.md for the Synk project.

First inspect the current repository and existing backend implementation so the README accurately reflects what is actually implemented.

Synk is a cross-device ecosystem connecting a mobile phone and laptop.

V1 goal:
Two-way text clipboard synchronization between a Flutter mobile application and an Electron desktop application through a FastAPI backend.

Current implementation status:
- FastAPI backend foundation
- GET /health endpoint
- WebSocket endpoint at /ws/{device_id}
- WebSocket ConnectionManager
- WebSocket message echo/testing
- WebSocket error handling
- Automated WebSocket tests
- Device registration
- Device identity using UUID4
- Device types: mobile and desktop
- In-memory DeviceRegistry
- Device lookup API
- Automated device registration tests
- 29 backend tests currently passing
- No database yet
- No authentication yet
- No pairing yet
- No clipboard synchronization yet
- Flutter application has not been implemented yet
- Electron application has not been implemented yet

The README should contain these sections:

1. Project title
2. Short project description
3. Why Synk exists
4. V1 goal
5. Current status
6. Architecture
7. Technology stack
8. Current repository structure
9. How Synk will eventually work
10. Currently implemented backend features
11. API endpoints currently implemented
12. WebSocket endpoint currently implemented
13. Local backend setup
14. Running the backend
15. Running tests
16. Example API requests/responses
17. Example WebSocket communication
18. Development roadmap
19. Project boundaries / what is NOT implemented yet
20. Development workflow
21. Contributing/development guidelines
22. License section, but do not invent a license if one has not been selected.

Use clear Markdown.

Include simple architecture diagrams using Markdown code blocks.

Clearly distinguish:
- Implemented
- In progress
- Planned

Do NOT claim that Flutter, Electron, pairing, authentication, database, or clipboard synchronization are already working.

Do NOT add unnecessary badges, fake statistics, fake deployment links, fake screenshots, or fake documentation links.

Do not modify application code.
Do not modify backend files.
Only update the root README.md.

After updating it:
1. Show the complete README.md.
2. Explain what information came from the existing codebase.
3. Tell me if any information was unavailable.
4. Do not commit anything.
