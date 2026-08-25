// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name

/// Synchronization protocol message models for Synk mobile.
///
/// These models mirror the backend WebSocket protocol for clipboard synchronization
/// between devices.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_message.freezed.dart';
part 'sync_message.g.dart';

/// Types of synchronization messages matching backend SyncMessageType enum.
enum SyncMessageType {
  // Client -> Server
  clipboardUpdate('clipboard.update'),
  ping('ping'),
  deliveryReceipt('delivery.receipt'),
  historySyncRequest('history.sync.request'),

  // Server -> Client
  clipboardUpdateReceived('clipboard.update.received'),
  clipboardUpdateRelay('clipboard.update.relay'),
  pong('pong'),
  error('error'),
  ack('ack'),
  historySyncResponse('history.sync.response'),
  deviceOnline('device.online'),
  deviceOffline('device.offline'),
  authSuccess('auth.success');

  const SyncMessageType(this.value);
  final String value;

  /// Parse string to SyncMessageType.
  static SyncMessageType fromString(String value) {
    return SyncMessageType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ArgumentError('Unknown message type: $value'),
    );
  }
}

/// Content types supported for synchronization.
enum ContentType {
  text('text');

  const ContentType(this.value);
  final String value;
}

/// Payload for clipboard synchronization messages.
@freezed
abstract class ClipboardPayload with _$ClipboardPayload {
  const factory ClipboardPayload({
    @Default(ContentType.text) ContentType contentType,
    required String text,
  }) = _ClipboardPayload;

  factory ClipboardPayload.fromJson(Map<String, dynamic> json) =>
      _$ClipboardPayloadFromJson(json);
}

/// Base synchronization message with common fields.
@freezed
abstract class SyncMessageBase with _$SyncMessageBase {
  const factory SyncMessageBase({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
  }) = _SyncMessageBase;

  factory SyncMessageBase.fromJson(Map<String, dynamic> json) =>
      _$SyncMessageBaseFromJson(json);
}

/// Client -> Server: Clipboard content update.
@freezed
abstract class ClipboardUpdateMessage with _$ClipboardUpdateMessage {
  const factory ClipboardUpdateMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    required ClipboardPayload payload,
  }) = _ClipboardUpdateMessage;

  factory ClipboardUpdateMessage.fromJson(Map<String, dynamic> json) =>
      _$ClipboardUpdateMessageFromJson(json);
}

/// Client -> Server: Ping for connection health.
@freezed
abstract class PingMessage with _$PingMessage {
  const factory PingMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    Map<String, dynamic>? payload,
  }) = _PingMessage;

  factory PingMessage.fromJson(Map<String, dynamic> json) =>
      _$PingMessageFromJson(json);
}

/// Client -> Server: Delivery receipt for clipboard update.
@freezed
abstract class DeliveryReceiptMessage with _$DeliveryReceiptMessage {
  const factory DeliveryReceiptMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    required Map<String, dynamic> payload,
  }) = _DeliveryReceiptMessage;

  factory DeliveryReceiptMessage.fromJson(Map<String, dynamic> json) =>
      _$DeliveryReceiptMessageFromJson(json);
}

/// Client -> Server: Request clipboard history sync.
@freezed
abstract class HistorySyncRequestMessage with _$HistorySyncRequestMessage {
  const factory HistorySyncRequestMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    required Map<String, dynamic> payload,
  }) = _HistorySyncRequestMessage;

  factory HistorySyncRequestMessage.fromJson(Map<String, dynamic> json) =>
      _$HistorySyncRequestMessageFromJson(json);
}

/// Server -> Client: Acknowledgment that clipboard update was received.
@freezed
abstract class ClipboardUpdateReceivedMessage with _$ClipboardUpdateReceivedMessage {
  const factory ClipboardUpdateReceivedMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    @Default({}) Map<String, dynamic> payload,
  }) = _ClipboardUpdateReceivedMessage;

  factory ClipboardUpdateReceivedMessage.fromJson(Map<String, dynamic> json) =>
      _$ClipboardUpdateReceivedMessageFromJson(json);
}

/// Server -> Client: Relayed clipboard update from paired device.
@freezed
abstract class ClipboardUpdateRelayMessage with _$ClipboardUpdateRelayMessage {
  const factory ClipboardUpdateRelayMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    required ClipboardPayload payload,
    required String sourceDeviceId,
  }) = _ClipboardUpdateRelayMessage;

  factory ClipboardUpdateRelayMessage.fromJson(Map<String, dynamic> json) =>
      _$ClipboardUpdateRelayMessageFromJson(json);
}

/// Server -> Client: Ping response.
@freezed
abstract class PongMessage with _$PongMessage {
  const factory PongMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    Map<String, dynamic>? payload,
  }) = _PongMessage;

  factory PongMessage.fromJson(Map<String, dynamic> json) =>
      _$PongMessageFromJson(json);
}

/// Server -> Client: Error response.
@freezed
abstract class ErrorMessage with _$ErrorMessage {
  const factory ErrorMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    required Map<String, dynamic> payload,
  }) = _ErrorMessage;

  factory ErrorMessage.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageFromJson(json);
}

/// Server -> Client: Generic acknowledgment.
@freezed
abstract class AckMessage with _$AckMessage {
  const factory AckMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    required Map<String, dynamic> payload,
  }) = _AckMessage;

  factory AckMessage.fromJson(Map<String, dynamic> json) =>
      _$AckMessageFromJson(json);
}

/// Server -> Client: Clipboard history sync response.
@freezed
abstract class HistorySyncResponseMessage with _$HistorySyncResponseMessage {
  const factory HistorySyncResponseMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    required Map<String, dynamic> payload,
  }) = _HistorySyncResponseMessage;

  factory HistorySyncResponseMessage.fromJson(Map<String, dynamic> json) =>
      _$HistorySyncResponseMessageFromJson(json);
}

/// Server -> Client: Notification that a paired device came online.
@freezed
abstract class DeviceOnlineMessage with _$DeviceOnlineMessage {
  const factory DeviceOnlineMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    required Map<String, dynamic> payload,
  }) = _DeviceOnlineMessage;

  factory DeviceOnlineMessage.fromJson(Map<String, dynamic> json) =>
      _$DeviceOnlineMessageFromJson(json);
}

/// Server -> Client: Notification that a paired device went offline.
@freezed
abstract class DeviceOfflineMessage with _$DeviceOfflineMessage {
  const factory DeviceOfflineMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
    required Map<String, dynamic> payload,
  }) = _DeviceOfflineMessage;

  factory DeviceOfflineMessage.fromJson(Map<String, dynamic> json) =>
      _$DeviceOfflineMessageFromJson(json);
}

/// Server -> Client: Authentication success response.
@freezed
abstract class AuthSuccessMessage with _$AuthSuccessMessage {
  const factory AuthSuccessMessage({
    required SyncMessageType type,
    @Default(1) int version,
    required String messageId,
    required String deviceId,
    required String timestamp,
  }) = _AuthSuccessMessage;

  factory AuthSuccessMessage.fromJson(Map<String, dynamic> json) =>
      _$AuthSuccessMessageFromJson(json);
}

/// Union of all client-to-server messages.
@freezed
sealed class ClientMessage with _$ClientMessage {
  const factory ClientMessage.clipboardUpdate(ClipboardUpdateMessage message) =
      ClientMessageClipboardUpdate;
  const factory ClientMessage.ping(PingMessage message) = ClientMessagePing;
  const factory ClientMessage.deliveryReceipt(DeliveryReceiptMessage message) =
      ClientMessageDeliveryReceipt;
  const factory ClientMessage.historySyncRequest(HistorySyncRequestMessage message) =
      ClientMessageHistorySyncRequest;

  factory ClientMessage.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String?;
    if (typeStr == null) {
      throw ArgumentError('Missing message type');
    }
    final type = SyncMessageType.fromString(typeStr);
    switch (type) {
      case SyncMessageType.clipboardUpdate:
        return ClientMessage.clipboardUpdate(
            ClipboardUpdateMessage.fromJson(json));
      case SyncMessageType.ping:
        return ClientMessage.ping(PingMessage.fromJson(json));
      case SyncMessageType.deliveryReceipt:
        return ClientMessage.deliveryReceipt(
            DeliveryReceiptMessage.fromJson(json));
      case SyncMessageType.historySyncRequest:
        return ClientMessage.historySyncRequest(
            HistorySyncRequestMessage.fromJson(json));
      default:
        throw ArgumentError('Unknown client message type: $typeStr');
    }
  }
}

/// Union of all server-to-client messages.
@freezed
sealed class ServerMessage with _$ServerMessage {
  const factory ServerMessage.clipboardUpdateReceived(
          ClipboardUpdateReceivedMessage message) =
      ServerMessageClipboardUpdateReceived;
  const factory ServerMessage.clipboardUpdateRelay(
          ClipboardUpdateRelayMessage message) =
      ServerMessageClipboardUpdateRelay;
  const factory ServerMessage.pong(PongMessage message) = ServerMessagePong;
  const factory ServerMessage.error(ErrorMessage message) = ServerMessageError;
  const factory ServerMessage.ack(AckMessage message) = ServerMessageAck;
  const factory ServerMessage.historySyncResponse(
          HistorySyncResponseMessage message) =
      ServerMessageHistorySyncResponse;
  const factory ServerMessage.deviceOnline(DeviceOnlineMessage message) =
      ServerMessageDeviceOnline;
  const factory ServerMessage.deviceOffline(DeviceOfflineMessage message) =
      ServerMessageDeviceOffline;
  const factory ServerMessage.authSuccess(AuthSuccessMessage message) =
      ServerMessageAuthSuccess;

  factory ServerMessage.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String?;
    if (typeStr == null) {
      throw ArgumentError('Missing message type');
    }
    final type = SyncMessageType.fromString(typeStr);
    switch (type) {
      case SyncMessageType.clipboardUpdateReceived:
        return ServerMessage.clipboardUpdateReceived(
            ClipboardUpdateReceivedMessage.fromJson(json));
      case SyncMessageType.clipboardUpdateRelay:
        return ServerMessage.clipboardUpdateRelay(
            ClipboardUpdateRelayMessage.fromJson(json));
      case SyncMessageType.pong:
        return ServerMessage.pong(PongMessage.fromJson(json));
      case SyncMessageType.error:
        return ServerMessage.error(ErrorMessage.fromJson(json));
      case SyncMessageType.ack:
        return ServerMessage.ack(AckMessage.fromJson(json));
      case SyncMessageType.historySyncResponse:
        return ServerMessage.historySyncResponse(
            HistorySyncResponseMessage.fromJson(json));
      case SyncMessageType.deviceOnline:
        return ServerMessage.deviceOnline(DeviceOnlineMessage.fromJson(json));
      case SyncMessageType.deviceOffline:
        return ServerMessage.deviceOffline(DeviceOfflineMessage.fromJson(json));
      case SyncMessageType.authSuccess:
        return ServerMessage.authSuccess(AuthSuccessMessage.fromJson(json));
      default:
        throw ArgumentError('Unknown server message type: $typeStr');
    }
  }
}

/// All possible messages.
@freezed
sealed class SyncMessage with _$SyncMessage {
  const factory SyncMessage.client(ClientMessage message) = SyncMessageClient;
  const factory SyncMessage.server(ServerMessage message) = SyncMessageServer;

  factory SyncMessage.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String?;
    if (typeStr == null) {
      throw ArgumentError('Missing message type');
    }
    final type = SyncMessageType.fromString(typeStr);
    if (_isClientMessageType(type)) {
      return SyncMessage.client(ClientMessage.fromJson(json));
    } else {
      return SyncMessage.server(ServerMessage.fromJson(json));
    }
  }

  static bool _isClientMessageType(SyncMessageType type) {
    return [
      SyncMessageType.clipboardUpdate,
      SyncMessageType.ping,
      SyncMessageType.deliveryReceipt,
      SyncMessageType.historySyncRequest,
    ].contains(type);
  }
}

/// Authentication message sent by client (first message).
@freezed
abstract class AuthMessage with _$AuthMessage {
  const factory AuthMessage({
    required SyncMessageType type,
    required String token,
  }) = _AuthMessage;

  factory AuthMessage.fromJson(Map<String, dynamic> json) =>
      _$AuthMessageFromJson(json);
}