// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name

/// WebSocket client for Synk mobile.
///
/// Provides a robust WebSocket connection to the Synk backend with:
/// - Authentication handshake
/// - Automatic reconnection with exponential backoff
/// - Connection state management
/// - Message parsing and dispatch
/// - Graceful disposal

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as ws_status;

import 'package:synk_mobile/models/sync/sync_message.dart';

/// Connection state of the WebSocket client.
enum WebSocketConnectionState {
  disconnected,
  connecting,
  connected,
  reconnecting,
  error,
}

/// Configuration for WebSocket client behavior.
class WebSocketClientConfig {
  /// Initial reconnection delay in milliseconds.
  final int initialReconnectDelayMs;

  /// Maximum reconnection delay in milliseconds.
  final int maxReconnectDelayMs;

  /// Multiplier for exponential backoff.
  final double backoffMultiplier;

  /// Jitter factor (0.0 to 1.0) to prevent thundering herd.
  final double jitterFactor;

  /// Ping interval in milliseconds.
  final int pingIntervalMs;

  /// Connection timeout in milliseconds.
  final int connectionTimeoutMs;

  /// Maximum message size in bytes.
  final int maxMessageSizeBytes;

  const WebSocketClientConfig({
    this.initialReconnectDelayMs = 1000,
    this.maxReconnectDelayMs = 30000,
    this.backoffMultiplier = 2.0,
    this.jitterFactor = 0.3,
    this.pingIntervalMs = 30000,
    this.connectionTimeoutMs = 10000,
    this.maxMessageSizeBytes = 200000,
  });
}

/// Callback for connection state changes.
typedef ConnectionStateCallback = void Function(WebSocketConnectionState state);

/// Callback for received server messages.
typedef MessageCallback = void Function(ServerMessage message);

/// Callback for errors.
typedef ErrorCallback = void Function(Object error, StackTrace stackTrace);

/// WebSocket client for Synk backend.
///
/// Handles connection lifecycle, authentication, message parsing,
/// and automatic reconnection with exponential backoff.
class SynkWebSocketClient {
  final String _wsUrl;
  final String _deviceId;
  final WebSocketClientConfig _config;

  WebSocketChannel? _channel;
  StreamSubscription? _streamSubscription;
  Timer? _reconnectTimer;
  Timer? _pingTimer;
  Timer? _connectionTimeoutTimer;

  WebSocketConnectionState _state = WebSocketConnectionState.disconnected;
  int _reconnectAttempts = 0;
  bool _disposed = false;
  bool _authenticated = false;
  String? _lastError;

  final _stateController = StreamController<WebSocketConnectionState>.broadcast();
  final _messageController = StreamController<ServerMessage>.broadcast();
  final _errorController = StreamController<Object>.broadcast();

  /// Creates a new WebSocket client.
  ///
  /// [wsUrl] - WebSocket endpoint URL (e.g., ws://10.0.2.2:8000/api/v1/ws/{device_id})
  /// [deviceId] - Device ID for authentication
  /// [authToken] - Authentication token for handshake
  /// [config] - Optional configuration for reconnection and ping behavior
  SynkWebSocketClient({
    required this._wsUrl,
    required this._deviceId,
    required String authToken, // unused but kept for API compatibility
    WebSocketClientConfig? config,
  })  : _config = config ?? const WebSocketClientConfig();

  /// Current connection state.
  WebSocketConnectionState get state => _state;

  /// Stream of connection state changes.
  Stream<WebSocketConnectionState> get stateStream => _stateController.stream;

  /// Stream of received server messages.
  Stream<ServerMessage> get messageStream => _messageController.stream;

  /// Stream of errors.
  Stream<Object> get errorStream => _errorController.stream;

  /// Whether the client is currently connected and authenticated.
  bool get isConnected => _state == WebSocketConnectionState.connected && _authenticated;

  /// Last error message if any.
  String? get lastError => _lastError;

  /// Device ID for this connection.
  String get deviceId => _deviceId;

  /// Connects to the WebSocket server and performs authentication.
  Future<void> connect() async {
    if (_disposed) return;
    if (_state == WebSocketConnectionState.connecting ||
        _state == WebSocketConnectionState.connected) {
      return;
    }

    _setState(WebSocketConnectionState.connecting);
    _authenticated = false;

    try {
      final uri = Uri.parse(_wsUrl);
      _channel = WebSocketChannel.connect(uri);

      // Set up connection timeout
      _connectionTimeoutTimer = Timer(
        Duration(milliseconds: _config.connectionTimeoutMs),
        () {
          if (!_authenticated && _state == WebSocketConnectionState.connecting) {
            _handleConnectionError(
              Exception('Connection timeout during authentication'),
              StackTrace.current,
            );
          }
        },
      );

      // Listen for messages
      _streamSubscription = _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onClose,
        cancelOnError: false,
      );
    } catch (e, st) {
      _handleConnectionError(e, st);
    }
  }

  /// Disconnects gracefully.
  Future<void> disconnect() async {
    _cancelReconnect();
    _cancelPingTimer();
    _cancelConnectionTimeout();

    if (_channel != null) {
      await _channel!.sink.close(ws_status.normalClosure);
      _channel = null;
    }

    if (_streamSubscription != null) {
      await _streamSubscription!.cancel();
      _streamSubscription = null;
    }

    _authenticated = false;
    _setState(WebSocketConnectionState.disconnected);
  }

  /// Sends a client message to the server.
  ///
  /// Returns true if the message was sent successfully.
  Future<bool> send(ClientMessage message) async {
    if (!isConnected || _channel == null) {
      return false;
    }

    try {
      final innerJson = message.when(
        clipboardUpdate: (m) => m.toJson(),
        ping: (m) => m.toJson(),
        deliveryReceipt: (m) => m.toJson(),
        historySyncRequest: (m) => m.toJson(),
      );
      final json = jsonEncode(innerJson);
      if (json.length > _config.maxMessageSizeBytes) {
        debugPrint('WebSocket message too large: ${json.length} bytes');
        return false;
      }
      _channel!.sink.add(json);
      return true;
    } catch (e, st) {
      _handleError(e, st);
      return false;
    }
  }

  /// Sends a clipboard update message.
  Future<bool> sendClipboardUpdate({
    required String messageId,
    required String text,
    ContentType contentType = ContentType.text,
  }) async {
    final message = ClipboardUpdateMessage(
      type: SyncMessageType.clipboardUpdate,
      messageId: messageId,
      deviceId: _deviceId,
      timestamp: DateTime.now().toUtc().toIso8601String().replaceAll('+00:00', 'Z'),
      payload: ClipboardPayload(
        contentType: contentType,
        text: text,
      ),
    );
    return send(ClientMessage.clipboardUpdate(message));
  }

  /// Sends a delivery receipt for a received clipboard update.
  Future<bool> sendDeliveryReceipt({
    required String messageId,
    required String receivedMessageId,
  }) async {
    final message = DeliveryReceiptMessage(
      type: SyncMessageType.deliveryReceipt,
      messageId: messageId,
      deviceId: _deviceId,
      timestamp: DateTime.now().toUtc().toIso8601String().replaceAll('+00:00', 'Z'),
      payload: {
        'received_message_id': receivedMessageId,
      },
    );
    return send(ClientMessage.deliveryReceipt(message));
  }

  /// Sends a history sync request.
  Future<bool> sendHistorySyncRequest({
    required String messageId,
    int limit = 50,
  }) async {
    final message = HistorySyncRequestMessage(
      type: SyncMessageType.historySyncRequest,
      messageId: messageId,
      deviceId: _deviceId,
      timestamp: DateTime.now().toUtc().toIso8601String().replaceAll('+00:00', 'Z'),
      payload: {
        'limit': limit,
      },
    );
    return send(ClientMessage.historySyncRequest(message));
  }

  /// Sends a ping message.
  Future<bool> sendPing({String? messageId}) async {
    final message = PingMessage(
      type: SyncMessageType.ping,
      messageId: messageId ?? _generateMessageId(),
      deviceId: _deviceId,
      timestamp: DateTime.now().toUtc().toIso8601String().replaceAll('+00:00', 'Z'),
    );
    return send(ClientMessage.ping(message));
  }

  /// Disposes all resources.
  void dispose() {
    _disposed = true;
    disconnect();
    _stateController.close();
    _messageController.close();
    _errorController.close();
  }

  void _setState(WebSocketConnectionState newState) {
    if (_state != newState) {
      _state = newState;
      _stateController.add(newState);
    }
  }

  void _onMessage(dynamic data) {
    if (_disposed) return;

    if (data is! String) {
      debugPrint('Received non-string WebSocket message: ${data.runtimeType}');
      return;
    }

    if (data.length > _config.maxMessageSizeBytes) {
      debugPrint('Received message too large: ${data.length} bytes');
      return;
    }

    try {
      final json = jsonDecode(data) as Map<String, dynamic>;
      final serverMessage = ServerMessage.fromJson(json);

      // Handle authentication success
      if (serverMessage is ServerMessageAuthSuccess) {
        _authenticated = true;
        _cancelConnectionTimeout();
        _startPingTimer();
        _setState(WebSocketConnectionState.connected);
        _reconnectAttempts = 0;
        debugPrint('WebSocket authenticated successfully');
      }

      _messageController.add(serverMessage);
    } catch (e, st) {
      // Log but don't crash on malformed messages
      if (kDebugMode) {
        debugPrint('Failed to parse WebSocket message: $e');
        debugPrint('Raw message: $data');
      }
      _handleError(
        FormatException('Failed to parse WebSocket message: $e'),
        st,
      );
    }
  }

  void _onError(Object error) {
    if (_disposed) return;
    _handleError(error, StackTrace.current);
  }

  void _onClose() {
    if (_disposed) return;

    _cancelConnectionTimeout();
    _cancelPingTimer();
    _authenticated = false;

    if (_state != WebSocketConnectionState.disconnected) {
      _setState(WebSocketConnectionState.disconnected);
      _scheduleReconnect();
    }
  }

  void _handleConnectionError(Object error, StackTrace stackTrace) {
    if (_disposed) return;

    _lastError = error.toString();
    _cancelConnectionTimeout();
    _setState(WebSocketConnectionState.error);
    _errorController.add(error);

    if (_channel != null) {
      _channel!.sink.close(ws_status.abnormalClosure);
      _channel = null;
    }

    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
      _streamSubscription = null;
    }

    _scheduleReconnect();
  }

  void _handleError(Object error, StackTrace stackTrace) {
    if (_disposed) return;
    _lastError = error.toString();
    _errorController.add(error);
  }

  void _scheduleReconnect() {
    if (_disposed) return;
    if (_state == WebSocketConnectionState.reconnecting) return;

    _setState(WebSocketConnectionState.reconnecting);

    // Calculate delay with exponential backoff and jitter
    final baseDelay = min(
      _config.initialReconnectDelayMs * pow(_config.backoffMultiplier, _reconnectAttempts),
      _config.maxReconnectDelayMs,
    ).toInt();

    final jitter = (baseDelay * _config.jitterFactor * Random().nextDouble()).toInt();
    final delay = baseDelay + jitter;

    _reconnectAttempts++;
    debugPrint('Scheduling WebSocket reconnect in ${delay}ms (attempt $_reconnectAttempts)');

    _reconnectTimer = Timer(Duration(milliseconds: delay), () {
      if (!_disposed) {
        connect();
      }
    });
  }

  void _startPingTimer() {
    _cancelPingTimer();
    _pingTimer = Timer.periodic(
      Duration(milliseconds: _config.pingIntervalMs),
      (_) {
        if (isConnected) {
          sendPing();
        }
      },
    );
  }

  void _cancelPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = null;
  }

  void _cancelConnectionTimeout() {
    _connectionTimeoutTimer?.cancel();
    _connectionTimeoutTimer = null;
  }

  void _cancelReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  String _generateMessageId() {
    return DateTime.now().microsecondsSinceEpoch.toRadixString(36) +
        Random().nextInt(1000000).toRadixString(36);
  }
}