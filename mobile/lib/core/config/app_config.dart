// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name

/// Application configuration for Synk mobile.
///
/// Centralizes all configuration values including API base URL,
/// timeouts, and other environment-specific settings.

class AppConfig {
  /// Base URL for the Synk backend API.
  ///
  /// For development, this can point to localhost or a dev server.
  /// For production, it should point to the production API endpoint.
  ///
  /// Examples:
  /// - Development (Android emulator): 'http://10.0.2.2:8000'
  /// - Development (iOS simulator): 'http://localhost:8000'
  /// - Development (physical device): 'http://`your-pc-ip`:8000'
  /// - Production: 'https://api.synk.example.com'
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );

  /// API version path prefix.
  static const String apiVersion = 'v1';

  /// Full API base URL with version.
  static String get fullApiBaseUrl => '$apiBaseUrl/api/$apiVersion';

  /// Default connection timeout in seconds.
  static const Duration connectionTimeout = Duration(seconds: 10);

  /// Default request timeout in seconds.
  static const Duration requestTimeout = Duration(seconds: 30);

  /// Default receive timeout in seconds.
  static const Duration receiveTimeout = Duration(seconds: 30);

  /// Storage keys for secure storage.
  static const String storageKeyDeviceId = 'device_id';
  static const String storageKeyAuthToken = 'auth_token';
  static const String storageKeyDeviceName = 'device_name';

  /// Whether to log network requests (for debugging).
  static const bool enableNetworkLogging = bool.fromEnvironment(
    'ENABLE_NETWORK_LOGGING',
    defaultValue: true,
  );
}