// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Device _$DeviceFromJson(Map<String, dynamic> json) => _Device(
  deviceId: json['device_id'] as String,
  deviceName: json['device_name'] as String,
  deviceType: $enumDecode(_$DeviceTypeEnumMap, json['device_type']),
  authToken: json['auth_token'] as String? ?? null,
);

Map<String, dynamic> _$DeviceToJson(_Device instance) => <String, dynamic>{
  'device_id': instance.deviceId,
  'device_name': instance.deviceName,
  'device_type': _$DeviceTypeEnumMap[instance.deviceType]!,
  'auth_token': instance.authToken,
};

const _$DeviceTypeEnumMap = {
  DeviceType.mobile: 'mobile',
  DeviceType.desktop: 'desktop',
};

_DeviceRegistrationRequest _$DeviceRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => _DeviceRegistrationRequest(
  deviceName: json['device_name'] as String,
  deviceType: $enumDecode(_$DeviceTypeEnumMap, json['device_type']),
);

Map<String, dynamic> _$DeviceRegistrationRequestToJson(
  _DeviceRegistrationRequest instance,
) => <String, dynamic>{
  'device_name': instance.deviceName,
  'device_type': _$DeviceTypeEnumMap[instance.deviceType]!,
};

_DeviceRegistrationResponse _$DeviceRegistrationResponseFromJson(
  Map<String, dynamic> json,
) => _DeviceRegistrationResponse(
  deviceId: json['device_id'] as String,
  deviceName: json['device_name'] as String,
  deviceType: $enumDecode(_$DeviceTypeEnumMap, json['device_type']),
  authToken: json['auth_token'] as String,
);

Map<String, dynamic> _$DeviceRegistrationResponseToJson(
  _DeviceRegistrationResponse instance,
) => <String, dynamic>{
  'device_id': instance.deviceId,
  'device_name': instance.deviceName,
  'device_type': _$DeviceTypeEnumMap[instance.deviceType]!,
  'auth_token': instance.authToken,
};
