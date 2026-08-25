// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name, prefer_initializing_formals

/// Device service for Synk mobile.
///
/// Handles device registration, device info retrieval,
/// and secure storage of device credentials.

import 'package:synk_mobile/core/config/app_config.dart';
import 'package:synk_mobile/core/network/api_client.dart';
import 'package:synk_mobile/core/storage/secure_storage.dart';
import 'package:synk_mobile/models/device.dart';

/// Service for device-related operations.
class DeviceService {
  final ApiClient _apiClient;

  /// Creates a device service with the given API client.
  DeviceService({required ApiClient apiClient}) : _apiClient = apiClient;

  /// Registers a new device with the backend.
  ///
  /// [deviceName] - Human-readable name for the device.
  /// [deviceType] - Type of device (mobile/desktop).
  ///
  /// Returns the device registration response containing device_id,
  /// device_name, device_type, and auth_token.
  ///
  /// Throws [ApiException] on failure.
  Future<DeviceRegistrationResponse> registerDevice({
    required String deviceName,
    required DeviceType deviceType,
  }) async {
    final request = DeviceRegistrationRequest(
      deviceName: deviceName.trim(),
      deviceType: deviceType,
    );

    final response = await _apiClient.post<DeviceRegistrationResponse>(
      '/devices/register',
      body: request.toJson(),
      requiresAuth: false, // Registration doesn't require auth
      parser: (json) => DeviceRegistrationResponse.fromJson(json as Map<String, dynamic>),
    );

    // Store credentials securely after successful registration
    await _storeCredentials(response);

    // Set auth token on API client for future requests
    _apiClient.setAuthToken(response.authToken);

    return response;
  }

  /// Retrieves the current device information from the backend.
  ///
  /// Requires authentication token to be set on the API client.
  ///
  /// Returns the device information.
  ///
  /// Throws [ApiException] on failure (e.g., 401 if token invalid).
  Future<Device> getCurrentDevice() async {
    final deviceId = await getStoredDeviceId();
    if (deviceId == null) {
      throw const ApiException(
        statusCode: 401,
        message: 'No device registered. Please register first.',
      );
    }

    final response = await _apiClient.get<Device>(
      '/devices/$deviceId',
      requiresAuth: true,
      parser: (json) => Device.fromJson(json as Map<String, dynamic>),
    );

    return response;
  }

  /// Checks if a device is already registered locally.
  Future<bool> isRegistered() async {
    return await SecureStorage.containsKey(key: AppConfig.storageKeyDeviceId);
  }

  /// Gets the stored device ID.
  Future<String?> getStoredDeviceId() async {
    return await SecureStorage.read(key: AppConfig.storageKeyDeviceId);
  }

  /// Gets the stored auth token.
  Future<String?> getStoredAuthToken() async {
    return await SecureStorage.read(key: AppConfig.storageKeyAuthToken);
  }

  /// Gets the stored device name.
  Future<String?> getStoredDeviceName() async {
    return await SecureStorage.read(key: AppConfig.storageKeyDeviceName);
  }

  /// Loads stored credentials and configures the API client.
  ///
  /// Call this on app startup to restore authenticated state.
  Future<void> loadStoredCredentials() async {
    final deviceId = await getStoredDeviceId();
    final authToken = await getStoredAuthToken();

    if (deviceId != null && authToken != null) {
      _apiClient.setAuthToken(authToken);
    }
  }

  /// Stores device credentials securely.
  Future<void> _storeCredentials(DeviceRegistrationResponse response) async {
    await Future.wait([
      SecureStorage.write(
        key: AppConfig.storageKeyDeviceId,
        value: response.deviceId,
      ),
      SecureStorage.write(
        key: AppConfig.storageKeyAuthToken,
        value: response.authToken,
      ),
      SecureStorage.write(
        key: AppConfig.storageKeyDeviceName,
        value: response.deviceName,
      ),
    ]);
  }

  /// Clears all stored credentials and resets the API client.
  ///
  /// Use this for logout or device unregistration.
  Future<void> clearCredentials() async {
    await SecureStorage.deleteAll();
    _apiClient.clearAuthToken();
  }
}