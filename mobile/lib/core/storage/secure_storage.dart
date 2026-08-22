// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name

/// Secure storage service for Synk mobile client.
///
/// Uses flutter_secure_storage which provides platform-specific
/// secure storage implementations:
/// - iOS: Keychain
/// - Android: EncryptedSharedPreferences (API 23+) / Keystore
/// - Windows: DPAPI
/// - macOS: Keychain
/// - Linux: libsecret
///
/// This ensures auth tokens and device credentials are never stored
/// in plain text.

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
    wOptions: WindowsOptions(
      // DPAPI encryption on Windows
    ),
    mOptions: MacOsOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
    lOptions: LinuxOptions(),
  );

  /// Write a value to secure storage.
  static Future<void> write({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  /// Read a value from secure storage.
  static Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  /// Delete a value from secure storage.
  static Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  /// Delete all values from secure storage.
  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Check if a key exists in secure storage.
  static Future<bool> containsKey({required String key}) async {
    return await _storage.containsKey(key: key);
  }

  /// Read all values from secure storage.
  static Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}