// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name

/// Pairing models for Synk mobile.
///
/// These models mirror the backend API contracts for device pairing.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pairing.freezed.dart';
part 'pairing.g.dart';

/// Request model for creating a pairing code.
///
/// The device_id is obtained from the authenticated device's token,
/// not from the request body.
@freezed
abstract class PairingCreateRequest with _$PairingCreateRequest {
  const factory PairingCreateRequest() = _PairingCreateRequest;

  factory PairingCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$PairingCreateRequestFromJson(json);
}

/// Response model for pairing code creation.
@freezed
abstract class PairingCreateResponse with _$PairingCreateResponse {
  const factory PairingCreateResponse({
    @JsonKey(name: 'code') required String code,

    @JsonKey(name: 'expires_at') required String expiresAt,

    @JsonKey(name: 'device_id') required String deviceId,
  }) = _PairingCreateResponse;

  factory PairingCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$PairingCreateResponseFromJson(json);
}

/// Request model for confirming a pairing code.
///
/// The device_id is obtained from the authenticated device's token,
/// not from the request body.
@freezed
abstract class PairingConfirmRequest with _$PairingConfirmRequest {
  const factory PairingConfirmRequest({
    @JsonKey(name: 'code') required String code,
  }) = _PairingConfirmRequest;

  factory PairingConfirmRequest.fromJson(Map<String, dynamic> json) =>
      _$PairingConfirmRequestFromJson(json);
}

/// Response model for successful pairing confirmation.
@freezed
abstract class PairingConfirmResponse with _$PairingConfirmResponse {
  const factory PairingConfirmResponse({
    @JsonKey(name: 'paired_device') required PairedDeviceInfo pairedDevice,

    @JsonKey(name: 'this_device') required PairedDeviceInfo thisDevice,
  }) = _PairingConfirmResponse;

  factory PairingConfirmResponse.fromJson(Map<String, dynamic> json) =>
      _$PairingConfirmResponseFromJson(json);
}

/// Information about a paired device.
@freezed
abstract class PairedDeviceInfo with _$PairedDeviceInfo {
  const factory PairedDeviceInfo({
    @JsonKey(name: 'device_id') required String deviceId,

    @JsonKey(name: 'device_name') required String deviceName,

    @JsonKey(name: 'device_type') required String deviceType,
  }) = _PairedDeviceInfo;

  factory PairedDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$PairedDeviceInfoFromJson(json);
}

/// Response model for retrieving paired devices.
@freezed
abstract class PairedDevicesResponse with _$PairedDevicesResponse {
  const factory PairedDevicesResponse({
    @JsonKey(name: 'device_id') required String deviceId,

    @JsonKey(name: 'paired_devices')
    required List<PairedDeviceInfo> pairedDevices,
  }) = _PairedDevicesResponse;

  factory PairedDevicesResponse.fromJson(Map<String, dynamic> json) =>
      _$PairedDevicesResponseFromJson(json);
}

/// Error response model for pairing operations.
@freezed
abstract class PairingErrorResponse with _$PairingErrorResponse {
  const factory PairingErrorResponse({required String detail}) =
      _PairingErrorResponse;

  factory PairingErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$PairingErrorResponseFromJson(json);
}
