// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name

/// Device models for Synk mobile.
///
/// These models mirror the backend API contracts for device registration
/// and device information retrieval.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device.freezed.dart';
part 'device.g.dart';

/// Device type enum matching backend DeviceType.
@JsonEnum(valueField: 'value')
enum DeviceType {
  mobile('mobile'),
  desktop('desktop');

  const DeviceType(this.value);

  /// API string value.
  final String value;

  /// Create DeviceType from string value.
  static DeviceType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'mobile':
        return DeviceType.mobile;
      case 'desktop':
        return DeviceType.desktop;
      default:
        throw ArgumentError('Unknown device type: $value');
    }
  }
}

/// Device model representing a registered Synk device.
@freezed
abstract class Device with _$Device {
  const factory Device({
    @JsonKey(name: 'device_id')
    required String deviceId,

    @JsonKey(name: 'device_name')
    required String deviceName,

    @JsonKey(name: 'device_type')
    required DeviceType deviceType,

    // Auth token is optional - only present during registration.
    @JsonKey(name: 'auth_token')
    @Default(null)
    String? authToken,
  }) = _Device;

  factory Device.fromJson(Map<String, dynamic> json) =>
      _$DeviceFromJson(json);
}

/// Request model for device registration.
@freezed
abstract class DeviceRegistrationRequest with _$DeviceRegistrationRequest {
  const factory DeviceRegistrationRequest({
    @JsonKey(name: 'device_name')
    required String deviceName,

    @JsonKey(name: 'device_type')
    required DeviceType deviceType,
  }) = _DeviceRegistrationRequest;

  factory DeviceRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceRegistrationRequestFromJson(json);
}

/// Response model for device registration.
///
/// Contains the device information AND the authentication token
/// which is only returned once during registration.
@freezed
abstract class DeviceRegistrationResponse
    with _$DeviceRegistrationResponse {
  const factory DeviceRegistrationResponse({
    @JsonKey(name: 'device_id')
    required String deviceId,

    @JsonKey(name: 'device_name')
    required String deviceName,

    @JsonKey(name: 'device_type')
    required DeviceType deviceType,

    @JsonKey(name: 'auth_token')
    required String authToken,
  }) = _DeviceRegistrationResponse;

  factory DeviceRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceRegistrationResponseFromJson(json);
}