// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name

/// API client for Synk mobile.
///
/// Handles HTTP requests to the Synk backend with automatic
/// Bearer token injection, error handling, timeouts, and logging.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:synk_mobile/core/config/app_config.dart';

/// Custom exception for API errors with user-friendly messaging support.
class ApiException implements Exception {
  final int statusCode;
  final String message;
  final Map<String, dynamic>? responseBody;

  const ApiException({
    required this.statusCode,
    required this.message,
    this.responseBody,
  });

  /// Whether this error is caused by network/backend unavailability.
  bool get isNetworkError => statusCode == 503 || statusCode == 408;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// HTTP client wrapper for the Synk backend API.
///
/// Automatically attaches `Authorization: Bearer <token>` to authenticated
/// requests when a token has been set via [setAuthToken].
class ApiClient {
  final http.Client _httpClient;
  String? _authToken;

  /// Creates an API client.
  ///
  /// [httpClient] can be injected for testing (e.g., MockClient).
  ApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// Sets the authentication token used for authenticated requests.
  void setAuthToken(String? token) {
    _authToken = token;
  }

  /// The current authentication token (if any).
  String? get authToken => _authToken;

  /// Clears the authentication token.
  void clearAuthToken() {
    _authToken = null;
  }

  Map<String, String> _buildHeaders({required bool requiresAuth}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (requiresAuth && _authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  void _logRequest(String method, Uri url, Map<String, String> headers,
      {Object? body}) {
    if (!AppConfig.enableNetworkLogging || !kDebugMode) return;
    debugPrint('[$method] $url');
    if (headers.containsKey('Authorization')) {
      debugPrint('  Authorization: Bearer ***');
    }
    if (body != null) {
      debugPrint('  Body: $body');
    }
  }

  void _logResponse(http.Response response) {
    if (!AppConfig.enableNetworkLogging || !kDebugMode) return;
    debugPrint('[${response.statusCode}] ${response.request?.url}');
    if (response.body.isNotEmpty) {
      debugPrint('  Body: ${response.body}');
    }
  }

  /// Decodes a successful response body, throwing [ApiException] on error.
  dynamic _handleResponse(http.Response response) {
    _logResponse(response);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    }

    String message = 'Request failed with status ${response.statusCode}';
    Map<String, dynamic>? responseBody;

    try {
      final decoded = json.decode(response.body);
      if (decoded is Map<String, dynamic>) {
        responseBody = decoded;
        final detail = decoded['detail'];
        if (detail != null) {
          message = detail.toString();
        }
      }
    } catch (_) {
      // Non-JSON error body; keep default message.
    }

    throw ApiException(
      statusCode: response.statusCode,
      message: message,
      responseBody: responseBody,
    );
  }

  /// Wraps transport-level failures into [ApiException].
  Future<T> _send<T>(Future<http.Response> Function() request,
      T Function(Object?)? parser) async {
    try {
      final response = await request().timeout(AppConfig.requestTimeout);
      final data = _handleResponse(response);
      return parser != null ? parser(data) : data as T;
    } on TimeoutException {
      throw const ApiException(
        statusCode: 408,
        message: 'Request timed out. Please check your connection.',
      );
    } on http.ClientException catch (e) {
      throw ApiException(
        statusCode: 503,
        message: 'Cannot connect to server: ${e.message}',
      );
    }
  }

  /// Performs a GET request against the backend.
  Future<T> get<T>(
    String path, {
    Map<String, String>? queryParams,
    bool requiresAuth = true,
    T Function(dynamic)? parser,
  }) {
    final uri = Uri.parse('${AppConfig.fullApiBaseUrl}$path')
        .replace(queryParameters: queryParams);
    final headers = _buildHeaders(requiresAuth: requiresAuth);
    _logRequest('GET', uri, headers);

    return _send(() => _httpClient.get(uri, headers: headers), parser);
  }

  /// Performs a POST request against the backend.
  Future<T> post<T>(
    String path, {
    Object? body,
    bool requiresAuth = true,
    T Function(dynamic)? parser,
  }) {
    final uri = Uri.parse('${AppConfig.fullApiBaseUrl}$path');
    final headers = _buildHeaders(requiresAuth: requiresAuth);
    final bodyJson = body != null ? json.encode(body) : null;
    _logRequest('POST', uri, headers, body: body);

    return _send(
        () => _httpClient.post(uri, headers: headers, body: bodyJson), parser);
  }

  /// Performs a PUT request against the backend.
  Future<T> put<T>(
    String path, {
    Object? body,
    bool requiresAuth = true,
    T Function(dynamic)? parser,
  }) {
    final uri = Uri.parse('${AppConfig.fullApiBaseUrl}$path');
    final headers = _buildHeaders(requiresAuth: requiresAuth);
    final bodyJson = body != null ? json.encode(body) : null;
    _logRequest('PUT', uri, headers, body: body);

    return _send(
        () => _httpClient.put(uri, headers: headers, body: bodyJson), parser);
  }

  /// Performs a DELETE request against the backend.
  Future<void> delete(String path, {bool requiresAuth = true}) async {
    final uri = Uri.parse('${AppConfig.fullApiBaseUrl}$path');
    final headers = _buildHeaders(requiresAuth: requiresAuth);
    _logRequest('DELETE', uri, headers);

    await _send(() => _httpClient.delete(uri, headers: headers), null);
  }

  /// Closes the underlying HTTP client.
  void close() {
    _httpClient.close();
  }
}
