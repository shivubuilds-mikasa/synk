// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name, unnecessary_underscores

/// Synk Mobile - Cross-device clipboard synchronization client.
///
/// Main entry point for the Flutter application.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synk_mobile/core/network/api_client.dart';
import 'package:synk_mobile/features/device/device_info_screen.dart';
import 'package:synk_mobile/features/device/device_registration_screen.dart';
import 'package:synk_mobile/services/device_service.dart';

void main() {
  runApp(const SynkMobileApp());
}

/// Root application widget with dependency injection.
class SynkMobileApp extends StatelessWidget {
  const SynkMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // API Client - single instance for the app lifecycle
        Provider<ApiClient>(
          create: (_) => ApiClient(),
          dispose: (_, client) => client.close(),
        ),
        // Device Service - depends on ApiClient
        ProxyProvider<ApiClient, DeviceService>(
          update: (_, apiClient, __) => DeviceService(apiClient: apiClient),
        ),
      ],
      child: MaterialApp(
        title: 'Synk',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.teal,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.teal,
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        home: const _AuthGate(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

/// Authentication gate that determines which screen to show.
///
/// Checks if device is already registered and routes to appropriate screen.
class _AuthGate extends StatefulWidget {
  const _AuthGate();

  @override
  State<_AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<_AuthGate> {
  bool _isLoading = true;
  Widget? _child;

  @override
  void initState() {
    super.initState();
    _checkRegistrationStatus();
  }

  Future<void> _checkRegistrationStatus() async {
    final deviceService = context.read<DeviceService>();

    // Load stored credentials and configure API client
    await deviceService.loadStoredCredentials();

    final isRegistered = await deviceService.isRegistered();

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      if (isRegistered) {
        _child = const _LoadingDeviceInfo();
      } else {
        _child = const DeviceRegistrationScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _child ?? const DeviceRegistrationScreen();
  }
}

/// Widget that loads and displays device info after registration.
class _LoadingDeviceInfo extends StatefulWidget {
  const _LoadingDeviceInfo();

  @override
  State<_LoadingDeviceInfo> createState() => _LoadingDeviceInfoState();
}

class _LoadingDeviceInfoState extends State<_LoadingDeviceInfo> {
  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    final deviceService = context.read<DeviceService>();

    try {
      final device = await deviceService.getCurrentDevice();
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => DeviceInfoScreen(device: device),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      // If loading fails (e.g., token expired), show registration screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const DeviceRegistrationScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}