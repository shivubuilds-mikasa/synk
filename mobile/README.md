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

## Build an Android APK for a physical phone

Install the Android SDK and Java 17 or newer. Start the backend so phones on the same trusted Wi-Fi network can reach it:

```powershell
cd backend
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

Then, from `mobile/`, replace the example address with the development computer's LAN IPv4 address and build/install:

```powershell
flutter build apk --release --dart-define=API_BASE_URL=http://192.168.1.111:8000
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

The APK uses the debug signing key for local testing and is not ready for Play Store release. The phone and computer must share a network, and the computer firewall must allow inbound TCP port 8000.

Before analysis or tests, regenerate model code after editing Freezed models:

```powershell
dart run build_runner build
flutter analyze
flutter test
```

Device credentials are stored using `flutter_secure_storage`. Clipboard sync requires registration and at least one paired device; mobile clipboard monitoring is subject to platform lifecycle restrictions.
