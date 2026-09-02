# Synk Architecture
fsfsv
## Overview

Synk is a cross-device ecosystem connecting a mobile device and laptop.

V1 focuses only on two-way text clipboard synchronization.

## Architecture

```text
📱 Flutter Mobile
       ↕
   WebSocket
       ↕
🐍 FastAPI Backend
       ↕
   WebSocket
       ↕
💻 Electron Desktop
