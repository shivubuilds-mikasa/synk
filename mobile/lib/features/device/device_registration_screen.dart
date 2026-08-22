// ignore_for_file: dangling_library_doc_comments

/// Device registration screen for Synk mobile client.
///
/// First launch screen where users enter their device name
/// and register the device with the backend.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synk_mobile/core/network/api_client.dart';
import 'package:synk_mobile/models/device.dart';
import 'package:synk_mobile/services/device_service.dart';
import 'device_info_screen.dart';

/// Screen for device registration.
class DeviceRegistrationScreen extends StatefulWidget {
  const DeviceRegistrationScreen({super.key});

  @override
  State<DeviceRegistrationScreen> createState() => _DeviceRegistrationScreenState();
}

class _DeviceRegistrationScreenState extends State<DeviceRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _registerDevice() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final deviceService = context.read<DeviceService>();
      final response = await deviceService.registerDevice(
        deviceName: _nameController.text.trim(),
        deviceType: DeviceType.mobile,
      );

      if (!mounted) return;

      // Convert registration response to Device for display
      final device = Device(
        deviceId: response.deviceId,
        deviceName: response.deviceName,
        deviceType: response.deviceType,
      );

      // Navigate to device info screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => DeviceInfoScreen(device: device),
        ),
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = _getUserFriendlyError(e);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'An unexpected error occurred. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getUserFriendlyError(ApiException e) {
    switch (e.statusCode) {
      case 400:
        return 'Invalid input. Please check your device name.';
      case 401:
        return 'Authentication failed. Please try again.';
      case 404:
        return 'Registration endpoint not found. Please check server configuration.';
      case 408:
        return 'Request timed out. Please check your connection and try again.';
      case 409:
        return 'A device with this name already exists.';
      case 422:
        return 'Invalid device name. Please use a valid name.';
      case 500:
        return 'Server error. Please try again later.';
      case 503:
        return 'Cannot connect to server. Please check if the backend is running.';
      default:
        return e.message.isNotEmpty
            ? e.message
            : 'Registration failed. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Device'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icon/Logo area
                Icon(
                  Icons.devices,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome to Synk',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter a name for this device to get started.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 32),

                // Device name input
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Device Name',
                    hintText: 'e.g., My Phone, Work iPhone',
                    prefixIcon: const Icon(Icons.devices),
                    border: const OutlineInputBorder(),
                    errorText: _errorMessage,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a device name';
                    }
                    if (value.trim().length > 100) {
                      return 'Device name must be 100 characters or less';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _registerDevice(),
                  enabled: !_isLoading,
                ),
                const SizedBox(height: 24),

                // Error message
                if (_errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (_errorMessage != null) const SizedBox(height: 16),

                // Register button
                FilledButton.icon(
                  onPressed: _isLoading ? null : _registerDevice,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check),
                  label: Text(_isLoading ? 'Registering...' : 'Register Device'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 16),

                // Info text
                Text(
                  'Your device will be registered with the Synk server.\n'
                  'An authentication token will be generated and stored securely.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}