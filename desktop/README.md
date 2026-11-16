# Synk Desktop

Electron client for device registration, pairing, and clipboard synchronization.

## Run from source

Start the backend, then run:

```powershell
npm ci
npm run dev
```

The renderer is compiled from `src/renderer/index.html` into `dist/renderer/index.html` as part of the build.

## Build a Windows installer

```powershell
npm ci
npm run package:win
```

The installer is written to `release/Synk-Setup-1.0.2.exe`. To produce an unpacked app folder instead, use `npm run package:dir`.

## Pair and test clipboard sync

Run Synk Desktop and the mobile APK while the backend is running. Create a pairing code in either app and enter it in the other app's **Paired Devices** screen. Copy text on either device; the other paired device should receive it while connected.

The packaged desktop app defaults to the hosted Synk test backend at `https://synk-api-vb4q.onrender.com`. Saved credentials are verified on startup and refreshed when they do not belong to the selected backend. For local development, set `SYNK_BACKEND_URL` before launching the app, for example `http://127.0.0.1:8000`.
