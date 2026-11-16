// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pairing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PairingCreateRequest _$PairingCreateRequestFromJson(
  Map<String, dynamic> json,
) => _PairingCreateRequest();

Map<String, dynamic> _$PairingCreateRequestToJson(
  _PairingCreateRequest instance,
) => <String, dynamic>{};

_PairingCreateResponse _$PairingCreateResponseFromJson(
  Map<String, dynamic> json,
) => _PairingCreateResponse(
  code: json['code'] as String,
  expiresAt: json['expires_at'] as String,
  deviceId: json['device_id'] as String,
);

Map<String, dynamic> _$PairingCreateResponseToJson(
  _PairingCreateResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'expires_at': instance.expiresAt,
  'device_id': instance.deviceId,
};

_PairingConfirmRequest _$PairingConfirmRequestFromJson(
  Map<String, dynamic> json,
) => _PairingConfirmRequest(code: json['code'] as String);

Map<String, dynamic> _$PairingConfirmRequestToJson(
  _PairingConfirmRequest instance,
) => <String, dynamic>{'code': instance.code};

_PairingConfirmResponse _$PairingConfirmResponseFromJson(
  Map<String, dynamic> json,
) => _PairingConfirmResponse(
  pairedDevice: PairedDeviceInfo.fromJson(
    json['paired_device'] as Map<String, dynamic>,
  ),
  thisDevice: PairedDeviceInfo.fromJson(
    json['this_device'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PairingConfirmResponseToJson(
  _PairingConfirmResponse instance,
) => <String, dynamic>{
  'paired_device': instance.pairedDevice,
  'this_device': instance.thisDevice,
};

_PairedDeviceInfo _$PairedDeviceInfoFromJson(Map<String, dynamic> json) =>
    _PairedDeviceInfo(
      deviceId: json['device_id'] as String,
      deviceName: json['device_name'] as String,
      deviceType: json['device_type'] as String,
    );

Map<String, dynamic> _$PairedDeviceInfoToJson(_PairedDeviceInfo instance) =>
    <String, dynamic>{
      'device_id': instance.deviceId,
      'device_name': instance.deviceName,
      'device_type': instance.deviceType,
    };

_PairedDevicesResponse _$PairedDevicesResponseFromJson(
  Map<String, dynamic> json,
) => _PairedDevicesResponse(
  deviceId: json['device_id'] as String,
  pairedDevices: (json['paired_devices'] as List<dynamic>)
      .map((e) => PairedDeviceInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PairedDevicesResponseToJson(
  _PairedDevicesResponse instance,
) => <String, dynamic>{
  'device_id': instance.deviceId,
  'paired_devices': instance.pairedDevices,
};

_PairingErrorResponse _$PairingErrorResponseFromJson(
  Map<String, dynamic> json,
) => _PairingErrorResponse(detail: json['detail'] as String);

Map<String, dynamic> _$PairingErrorResponseToJson(
  _PairingErrorResponse instance,
) => <String, dynamic>{'detail': instance.detail};
