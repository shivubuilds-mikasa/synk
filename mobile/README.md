# Synk Mobile

Flutter client for device registration, pairing, and text clipboard sync.

## Run

Install Flutter dependencies and start the app with a backend URL reachable from the device:

```powershell
flutter pub get
dart run build_runner build
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

Use `http://localhost:8000` for an iOS simulator. For a physical device, use the development computer's LAN address. The default Android emulator URL is `10.0.2.2`.

Before analysis or tests, regenerate model code after editing Freezed models:

```powershell
dart run build_runner build
flutter analyze
flutter test
```

Device credentials are stored using `flutter_secure_storage`. Clipboard sync requires registration and at least one paired device; mobile clipboard monitoring is subject to platform lifecycle restrictions.
