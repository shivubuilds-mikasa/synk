// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name

/// Clipboard synchronization service for Synk mobile.
///
/// Orchestrates the clipboard synchronization flow:
/// - Monitors local clipboard changes
/// - Sends updates via WebSocket
/// - Receives updates from paired devices
/// - Applies updates to local clipboard
/// - Handles delivery receipts and deduplication

import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:synk_mobile/core/config/app_config.dart';
import 'package:synk_mobile/core/websocket/websocket_client.dart';
import 'package:synk_mobile/models/sync/sync_message.dart';
import 'package:synk_mobile/services/clipboard/clipboard_service.dart';
import 'package:synk_mobile/services/device_service.dart';

/// Synchronization state for UI display.
enum ClipboardSyncState {
  disconnected,
  connecting,
  connected,
  reconnecting,
  error,
}

/// Callback for sync state changes.
typedef SyncStateCallback = void Function(ClipboardSyncState state);

/// Callback for new clipboard content received from paired devices.
typedef ClipboardReceivedCallback = void Function(String text, String sourceDeviceId);

/// Clipboard synchronization service.
///
/// Coordinates between the WebSocket client and system clipboard
/// to achieve cross-device clipboard synchronization.
class ClipboardSyncService {
  final DeviceService _deviceService;
  final ClipboardService _clipboardService;

  SynkWebSocketClient? _webSocketClientInstance;
  ClipboardSyncState _syncState = ClipboardSyncState.disconnected;
  String? _lastSentContent;
  String? _lastReceivedMessageId;
  Timer? _historySyncTimer;

  final _stateController = StreamController<ClipboardSyncState>.broadcast();
  final _receivedController = StreamController<String>.broadcast();
  final _errorController = StreamController<Object>.broadcast();

  /// Current synchronization state.
  ClipboardSyncState get syncState => _syncState;

  /// Stream of synchronization state changes.
  Stream<ClipboardSyncState> get stateStream => _stateController.stream;

  /// Stream of clipboard content received from paired devices.
  Stream<String> get receivedStream => _receivedController.stream;

  /// Stream of errors.
  Stream<Object> get errorStream => _errorController.stream;

  /// Whether currently connected and syncing.
  bool get isSyncing => _syncState == ClipboardSyncState.connected;

  /// Creates a clipboard sync service.
  ///
  /// [deviceService] - Device service for authentication credentials
  /// [clipboardService] - Clipboard service for local clipboard access
  ClipboardSyncService({
    required this._deviceService,
    required this._clipboardService,
  });

  /// Builds WebSocket URL from app config.
  static String _buildWsUrl() {
    // Convert HTTP URL to WebSocket URL
    // Note: backend WebSocket endpoint is at /ws/ (not /api/v1/ws/)
    final httpUrl = AppConfig.apiBaseUrl;
    final wsUrl = httpUrl.replaceFirst('http://', 'ws://').replaceFirst('https://', 'wss://');
    return '$wsUrl/ws/';
  }

  /// Initializes and starts the synchronization service.
  ///
  /// Loads credentials, connects to WebSocket, and starts clipboard monitoring.
  Future<void> initialize() async {
    // Load stored credentials
    await _deviceService.loadStoredCredentials();
    final deviceId = await _deviceService.getStoredDeviceId();
    final authToken = await _deviceService.getStoredAuthToken();

    if (deviceId == null || authToken == null) {
      throw StateError('Device not registered. Please register first.');
    }

    // Recreate WebSocket client with actual credentials
    _webSocketClientInstance = SynkWebSocketClient(
      wsUrl: '${_buildWsUrl()}$deviceId',
      deviceId: deviceId,
      authToken: authToken,
    );

    // Set up WebSocket listeners
    _webSocketClientInstance!.stateStream.listen(_onWebSocketStateChange);
    _webSocketClientInstance!.messageStream.listen(_onWebSocketMessage);
    _webSocketClientInstance!.errorStream.listen(_onWebSocketError);

    // Start clipboard monitoring
    _clipboardService.clipboardChangeStream.listen(_onLocalClipboardChange);

    // Read initial clipboard value
    await _clipboardService.read();

    // Connect to WebSocket
    await _webSocketClientInstance!.connect();
  }

  /// Requests a history sync from the server.
  Future<void> requestHistorySync({int limit = 50}) async {
    if (!isSyncing) return;

    final messageId = _generateMessageId();
    await _webSocketClientInstance?.sendHistorySyncRequest(
      messageId: messageId,
      limit: limit,
    );
  }

  /// Disposes all resources.
  void dispose() {
    _webSocketClientInstance?.dispose();
    _clipboardService.dispose();
    _historySyncTimer?.cancel();
    _stateController.close();
    _receivedController.close();
    _errorController.close();
  }

  void _onWebSocketStateChange(WebSocketConnectionState state) {
    ClipboardSyncState newSyncState;
    switch (state) {
      case WebSocketConnectionState.disconnected:
        newSyncState = ClipboardSyncState.disconnected;
        break;
      case WebSocketConnectionState.connecting:
        newSyncState = ClipboardSyncState.connecting;
        break;
      case WebSocketConnectionState.connected:
        newSyncState = ClipboardSyncState.connected;
        // Request history sync on first connect
        _requestInitialHistorySync();
        break;
      case WebSocketConnectionState.reconnecting:
        newSyncState = ClipboardSyncState.reconnecting;
        break;
      case WebSocketConnectionState.error:
        newSyncState = ClipboardSyncState.error;
        break;
    }

    if (_syncState != newSyncState) {
      _syncState = newSyncState;
      _stateController.add(newSyncState);
    }
  }

  void _requestInitialHistorySync() {
    // Request history sync after a brief delay to ensure connection is stable
    Future.delayed(const Duration(milliseconds: 500), () {
      if (isSyncing) {
        requestHistorySync(limit: 20);
      }
    });
  }

  void _onWebSocketMessage(ServerMessage message) {
    message.when(
      clipboardUpdateReceived: (msg) {
        // Acknowledgment of our sent clipboard update
        debugPrint('Clipboard update acknowledged: ${msg.messageId}');
      },
      clipboardUpdateRelay: (msg) {
        // Clipboard update from another paired device
        _handleIncomingClipboardUpdate(msg);
      },
      pong: (msg) {
        // Ping response - connection is healthy
      },
      error: (msg) {
        final errorCode = msg.payload['error_code'] as String?;
        final errorMessage = msg.payload['error_message'] as String?;
        debugPrint('WebSocket error: $errorCode - $errorMessage');
        _errorController.add(Exception('$errorCode: $errorMessage'));
      },
      ack: (msg) {
        // Generic acknowledgment
        final status = msg.payload['status'] as String?;
        final ackMessageId = msg.payload['acknowledged_message_id'] as String?;
        debugPrint('Acknowledgment: $ackMessageId - $status');
      },
      historySyncResponse: (msg) {
        _handleHistorySyncResponse(msg);
      },
      deviceOnline: (msg) {
        final deviceId = msg.payload['device_id'] as String?;
        debugPrint('Paired device online: $deviceId');
      },
      deviceOffline: (msg) {
        final deviceId = msg.payload['device_id'] as String?;
        debugPrint('Paired device offline: $deviceId');
      },
      authSuccess: (msg) {
        debugPrint('WebSocket authenticated successfully');
      },
    );
  }

  void _handleIncomingClipboardUpdate(ClipboardUpdateRelayMessage msg) {
    // Ignore messages originating from this device (loop prevention)
    final deviceId = _webSocketClientInstance?.deviceId ?? '';
    if (msg.sourceDeviceId == deviceId) {
      debugPrint('Ignoring clipboard update from self');
      return;
    }

    // Check for duplicate
    if (msg.messageId == _lastReceivedMessageId) {
      debugPrint('Ignoring duplicate clipboard update: ${msg.messageId}');
      return;
    }

    // Apply to local clipboard
    final text = msg.payload.text;
    if (text.isNotEmpty) {
      _lastReceivedMessageId = msg.messageId;
      _clipboardService.write(text, markAsLast: false);
      _receivedController.add(text);

      // Send delivery receipt
      _sendDeliveryReceipt(msg.messageId);
    }
  }

  Future<void> _sendDeliveryReceipt(String receivedMessageId) async {
    final messageId = _generateMessageId();
    await _webSocketClientInstance?.sendDeliveryReceipt(
      messageId: messageId,
      receivedMessageId: receivedMessageId,
    );
  }

  void _handleHistorySyncResponse(HistorySyncResponseMessage msg) {
    final entries = msg.payload['entries'] as List<dynamic>?;
    if (entries != null) {
      debugPrint('Received history sync with ${entries.length} entries');
      // Apply entries in reverse order (oldest first)
      for (var i = entries.length - 1; i >= 0; i--) {
        final entry = entries[i] as Map<String, dynamic>;
        final text = entry['content_text'] as String?;
        final messageId = entry['message_id'] as String?;

        if (text != null && text.isNotEmpty && messageId != null) {
          // Only apply if newer than what we have
          if (messageId != _lastReceivedMessageId) {
            _clipboardService.write(text, markAsLast: false);
            _receivedController.add(text);
            _lastReceivedMessageId = messageId;
            // Send delivery receipt for synced entries
            _sendDeliveryReceipt(messageId);
          }
        }
      }
    }
  }

  void _onWebSocketError(Object error) {
    debugPrint('WebSocket error: $error');
    _errorController.add(error);
  }

  Future<void> _onLocalClipboardChange(String text) async {
    // Skip empty content
    if (text.trim().isEmpty) return;

    // Skip if same as last sent (deduplication)
    if (text == _lastSentContent) {
      debugPrint('Skipping duplicate clipboard content');
      return;
    }

    // Skip if this was recently received from another device (loop prevention)
    // This is a simple heuristic - in practice, the backend also prevents loops
    if (text == _clipboardService.lastReadValue && _lastReceivedMessageId != null) {
      // Might be a loop, but let backend handle deduplication
    }

    _lastSentContent = text;

    // Send clipboard update
    final messageId = _generateMessageId();
    final sent = await _webSocketClientInstance?.sendClipboardUpdate(
      messageId: messageId,
      text: text,
    );

    if (sent == true) {
      debugPrint('Clipboard update sent: $messageId');
    } else {
      debugPrint('Failed to send clipboard update');
      // Could implement retry queue here
    }
  }

  String _generateMessageId() {
    return DateTime.now().microsecondsSinceEpoch.toRadixString(36) +
        Random().nextInt(1000000).toRadixString(36);
  }
}