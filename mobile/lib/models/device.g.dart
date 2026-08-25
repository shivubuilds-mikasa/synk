// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Device _$DeviceFromJson(Map<String, dynamic> json) => _Device(
  deviceId: json['deviceId'] as String,
  deviceName: json['deviceName'] as String,
  deviceType: $enumDecode(_$DeviceTypeEnumMap, json['deviceType']),
  authToken: json['authToken'] as String? ?? null,
);

Map<String, dynamic> _$DeviceToJson(_Device instance) => <String, dynamic>{
  'deviceId': instance.deviceId,
  'deviceName': instance.deviceName,
  'deviceType': _$DeviceTypeEnumMap[instance.deviceType]!,
  'authToken': instance.authToken,
};

const _$DeviceTypeEnumMap = {
  DeviceType.mobile: 'mobile',
  DeviceType.desktop: 'desktop',
};

_DeviceRegistrationRequest _$DeviceRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => _DeviceRegistrationRequest(
  deviceName: json['deviceName'] as String,
  deviceType: $enumDecode(_$DeviceTypeEnumMap, json['deviceType']),
);

Map<String, dynamic> _$DeviceRegistrationRequestToJson(
  _DeviceRegistrationRequest instance,
) => <String, dynamic>{
  'deviceName': instance.deviceName,
  'deviceType': _$DeviceTypeEnumMap[instance.deviceType]!,
};

_DeviceRegistrationResponse _$DeviceRegistrationResponseFromJson(
  Map<String, dynamic> json,
) => _DeviceRegistrationResponse(
  deviceId: json['deviceId'] as String,
  deviceName: json['deviceName'] as String,
  deviceType: $enumDecode(_$DeviceTypeEnumMap, json['deviceType']),
  authToken: json['authToken'] as String,
);

Map<String, dynamic> _$DeviceRegistrationResponseToJson(
  _DeviceRegistrationResponse instance,
) => <String, dynamic>{
  'deviceId': instance.deviceId,
  'deviceName': instance.deviceName,
  'deviceType': _$DeviceTypeEnumMap[instance.deviceType]!,
  'authToken': instance.authToken,
};
