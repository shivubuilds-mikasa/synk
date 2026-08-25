// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClipboardPayload _$ClipboardPayloadFromJson(Map<String, dynamic> json) =>
    _ClipboardPayload(
      contentType:
          $enumDecodeNullable(_$ContentTypeEnumMap, json['contentType']) ??
          ContentType.text,
      text: json['text'] as String,
    );

Map<String, dynamic> _$ClipboardPayloadToJson(_ClipboardPayload instance) =>
    <String, dynamic>{
      'contentType': _$ContentTypeEnumMap[instance.contentType]!,
      'text': instance.text,
    };

const _$ContentTypeEnumMap = {ContentType.text: 'text'};

_SyncMessageBase _$SyncMessageBaseFromJson(Map<String, dynamic> json) =>
    _SyncMessageBase(
      type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
      version: (json['version'] as num?)?.toInt() ?? 1,
      messageId: json['messageId'] as String,
      deviceId: json['deviceId'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$SyncMessageBaseToJson(_SyncMessageBase instance) =>
    <String, dynamic>{
      'type': _$SyncMessageTypeEnumMap[instance.type]!,
      'version': instance.version,
      'messageId': instance.messageId,
      'deviceId': instance.deviceId,
      'timestamp': instance.timestamp,
    };

const _$SyncMessageTypeEnumMap = {
  SyncMessageType.clipboardUpdate: 'clipboardUpdate',
  SyncMessageType.ping: 'ping',
  SyncMessageType.deliveryReceipt: 'deliveryReceipt',
  SyncMessageType.historySyncRequest: 'historySyncRequest',
  SyncMessageType.clipboardUpdateReceived: 'clipboardUpdateReceived',
  SyncMessageType.clipboardUpdateRelay: 'clipboardUpdateRelay',
  SyncMessageType.pong: 'pong',
  SyncMessageType.error: 'error',
  SyncMessageType.ack: 'ack',
  SyncMessageType.historySyncResponse: 'historySyncResponse',
  SyncMessageType.deviceOnline: 'deviceOnline',
  SyncMessageType.deviceOffline: 'deviceOffline',
  SyncMessageType.authSuccess: 'authSuccess',
};

_ClipboardUpdateMessage _$ClipboardUpdateMessageFromJson(
  Map<String, dynamic> json,
) => _ClipboardUpdateMessage(
  type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
  version: (json['version'] as num?)?.toInt() ?? 1,
  messageId: json['messageId'] as String,
  deviceId: json['deviceId'] as String,
  timestamp: json['timestamp'] as String,
  payload: ClipboardPayload.fromJson(json['payload'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ClipboardUpdateMessageToJson(
  _ClipboardUpdateMessage instance,
) => <String, dynamic>{
  'type': _$SyncMessageTypeEnumMap[instance.type]!,
  'version': instance.version,
  'messageId': instance.messageId,
  'deviceId': instance.deviceId,
  'timestamp': instance.timestamp,
  'payload': instance.payload,
};

_PingMessage _$PingMessageFromJson(Map<String, dynamic> json) => _PingMessage(
  type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
  version: (json['version'] as num?)?.toInt() ?? 1,
  messageId: json['messageId'] as String,
  deviceId: json['deviceId'] as String,
  timestamp: json['timestamp'] as String,
  payload: json['payload'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$PingMessageToJson(_PingMessage instance) =>
    <String, dynamic>{
      'type': _$SyncMessageTypeEnumMap[instance.type]!,
      'version': instance.version,
      'messageId': instance.messageId,
      'deviceId': instance.deviceId,
      'timestamp': instance.timestamp,
      'payload': instance.payload,
    };

_DeliveryReceiptMessage _$DeliveryReceiptMessageFromJson(
  Map<String, dynamic> json,
) => _DeliveryReceiptMessage(
  type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
  version: (json['version'] as num?)?.toInt() ?? 1,
  messageId: json['messageId'] as String,
  deviceId: json['deviceId'] as String,
  timestamp: json['timestamp'] as String,
  payload: json['payload'] as Map<String, dynamic>,
);

Map<String, dynamic> _$DeliveryReceiptMessageToJson(
  _DeliveryReceiptMessage instance,
) => <String, dynamic>{
  'type': _$SyncMessageTypeEnumMap[instance.type]!,
  'version': instance.version,
  'messageId': instance.messageId,
  'deviceId': instance.deviceId,
  'timestamp': instance.timestamp,
  'payload': instance.payload,
};

_HistorySyncRequestMessage _$HistorySyncRequestMessageFromJson(
  Map<String, dynamic> json,
) => _HistorySyncRequestMessage(
  type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
  version: (json['version'] as num?)?.toInt() ?? 1,
  messageId: json['messageId'] as String,
  deviceId: json['deviceId'] as String,
  timestamp: json['timestamp'] as String,
  payload: json['payload'] as Map<String, dynamic>,
);

Map<String, dynamic> _$HistorySyncRequestMessageToJson(
  _HistorySyncRequestMessage instance,
) => <String, dynamic>{
  'type': _$SyncMessageTypeEnumMap[instance.type]!,
  'version': instance.version,
  'messageId': instance.messageId,
  'deviceId': instance.deviceId,
  'timestamp': instance.timestamp,
  'payload': instance.payload,
};

_ClipboardUpdateReceivedMessage _$ClipboardUpdateReceivedMessageFromJson(
  Map<String, dynamic> json,
) => _ClipboardUpdateReceivedMessage(
  type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
  version: (json['version'] as num?)?.toInt() ?? 1,
  messageId: json['messageId'] as String,
  deviceId: json['deviceId'] as String,
  timestamp: json['timestamp'] as String,
  payload: json['payload'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$ClipboardUpdateReceivedMessageToJson(
  _ClipboardUpdateReceivedMessage instance,
) => <String, dynamic>{
  'type': _$SyncMessageTypeEnumMap[instance.type]!,
  'version': instance.version,
  'messageId': instance.messageId,
  'deviceId': instance.deviceId,
  'timestamp': instance.timestamp,
  'payload': instance.payload,
};

_ClipboardUpdateRelayMessage _$ClipboardUpdateRelayMessageFromJson(
  Map<String, dynamic> json,
) => _ClipboardUpdateRelayMessage(
  type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
  version: (json['version'] as num?)?.toInt() ?? 1,
  messageId: json['messageId'] as String,
  deviceId: json['deviceId'] as String,
  timestamp: json['timestamp'] as String,
  payload: ClipboardPayload.fromJson(json['payload'] as Map<String, dynamic>),
  sourceDeviceId: json['sourceDeviceId'] as String,
);

Map<String, dynamic> _$ClipboardUpdateRelayMessageToJson(
  _ClipboardUpdateRelayMessage instance,
) => <String, dynamic>{
  'type': _$SyncMessageTypeEnumMap[instance.type]!,
  'version': instance.version,
  'messageId': instance.messageId,
  'deviceId': instance.deviceId,
  'timestamp': instance.timestamp,
  'payload': instance.payload,
  'sourceDeviceId': instance.sourceDeviceId,
};

_PongMessage _$PongMessageFromJson(Map<String, dynamic> json) => _PongMessage(
  type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
  version: (json['version'] as num?)?.toInt() ?? 1,
  messageId: json['messageId'] as String,
  deviceId: json['deviceId'] as String,
  timestamp: json['timestamp'] as String,
  payload: json['payload'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$PongMessageToJson(_PongMessage instance) =>
    <String, dynamic>{
      'type': _$SyncMessageTypeEnumMap[instance.type]!,
      'version': instance.version,
      'messageId': instance.messageId,
      'deviceId': instance.deviceId,
      'timestamp': instance.timestamp,
      'payload': instance.payload,
    };

_ErrorMessage _$ErrorMessageFromJson(Map<String, dynamic> json) =>
    _ErrorMessage(
      type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
      version: (json['version'] as num?)?.toInt() ?? 1,
      messageId: json['messageId'] as String,
      deviceId: json['deviceId'] as String,
      timestamp: json['timestamp'] as String,
      payload: json['payload'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ErrorMessageToJson(_ErrorMessage instance) =>
    <String, dynamic>{
      'type': _$SyncMessageTypeEnumMap[instance.type]!,
      'version': instance.version,
      'messageId': instance.messageId,
      'deviceId': instance.deviceId,
      'timestamp': instance.timestamp,
      'payload': instance.payload,
    };

_AckMessage _$AckMessageFromJson(Map<String, dynamic> json) => _AckMessage(
  type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
  version: (json['version'] as num?)?.toInt() ?? 1,
  messageId: json['messageId'] as String,
  deviceId: json['deviceId'] as String,
  timestamp: json['timestamp'] as String,
  payload: json['payload'] as Map<String, dynamic>,
);

Map<String, dynamic> _$AckMessageToJson(_AckMessage instance) =>
    <String, dynamic>{
      'type': _$SyncMessageTypeEnumMap[instance.type]!,
      'version': instance.version,
      'messageId': instance.messageId,
      'deviceId': instance.deviceId,
      'timestamp': instance.timestamp,
      'payload': instance.payload,
    };

_HistorySyncResponseMessage _$HistorySyncResponseMessageFromJson(
  Map<String, dynamic> json,
) => _HistorySyncResponseMessage(
  type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
  version: (json['version'] as num?)?.toInt() ?? 1,
  messageId: json['messageId'] as String,
  deviceId: json['deviceId'] as String,
  timestamp: json['timestamp'] as String,
  payload: json['payload'] as Map<String, dynamic>,
);

Map<String, dynamic> _$HistorySyncResponseMessageToJson(
  _HistorySyncResponseMessage instance,
) => <String, dynamic>{
  'type': _$SyncMessageTypeEnumMap[instance.type]!,
  'version': instance.version,
  'messageId': instance.messageId,
  'deviceId': instance.deviceId,
  'timestamp': instance.timestamp,
  'payload': instance.payload,
};

_DeviceOnlineMessage _$DeviceOnlineMessageFromJson(Map<String, dynamic> json) =>
    _DeviceOnlineMessage(
      type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
      version: (json['version'] as num?)?.toInt() ?? 1,
      messageId: json['messageId'] as String,
      deviceId: json['deviceId'] as String,
      timestamp: json['timestamp'] as String,
      payload: json['payload'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$DeviceOnlineMessageToJson(
  _DeviceOnlineMessage instance,
) => <String, dynamic>{
  'type': _$SyncMessageTypeEnumMap[instance.type]!,
  'version': instance.version,
  'messageId': instance.messageId,
  'deviceId': instance.deviceId,
  'timestamp': instance.timestamp,
  'payload': instance.payload,
};

_DeviceOfflineMessage _$DeviceOfflineMessageFromJson(
  Map<String, dynamic> json,
) => _DeviceOfflineMessage(
  type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
  version: (json['version'] as num?)?.toInt() ?? 1,
  messageId: json['messageId'] as String,
  deviceId: json['deviceId'] as String,
  timestamp: json['timestamp'] as String,
  payload: json['payload'] as Map<String, dynamic>,
);

Map<String, dynamic> _$DeviceOfflineMessageToJson(
  _DeviceOfflineMessage instance,
) => <String, dynamic>{
  'type': _$SyncMessageTypeEnumMap[instance.type]!,
  'version': instance.version,
  'messageId': instance.messageId,
  'deviceId': instance.deviceId,
  'timestamp': instance.timestamp,
  'payload': instance.payload,
};

_AuthSuccessMessage _$AuthSuccessMessageFromJson(Map<String, dynamic> json) =>
    _AuthSuccessMessage(
      type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
      version: (json['version'] as num?)?.toInt() ?? 1,
      messageId: json['messageId'] as String,
      deviceId: json['deviceId'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$AuthSuccessMessageToJson(_AuthSuccessMessage instance) =>
    <String, dynamic>{
      'type': _$SyncMessageTypeEnumMap[instance.type]!,
      'version': instance.version,
      'messageId': instance.messageId,
      'deviceId': instance.deviceId,
      'timestamp': instance.timestamp,
    };

_AuthMessage _$AuthMessageFromJson(Map<String, dynamic> json) => _AuthMessage(
  type: $enumDecode(_$SyncMessageTypeEnumMap, json['type']),
  token: json['token'] as String,
);

Map<String, dynamic> _$AuthMessageToJson(_AuthMessage instance) =>
    <String, dynamic>{
      'type': _$SyncMessageTypeEnumMap[instance.type]!,
      'token': instance.token,
    };
