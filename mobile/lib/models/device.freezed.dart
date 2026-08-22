// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Device {

 String get deviceId; String get deviceName; DeviceType get deviceType;// Auth token is optional - only present during registration
 String? get authToken;
/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceCopyWith<Device> get copyWith => _$DeviceCopyWithImpl<Device>(this as Device, _$identity);

  /// Serializes this Device to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Device&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.authToken, authToken) || other.authToken == authToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,deviceName,deviceType,authToken);

@override
String toString() {
  return 'Device(deviceId: $deviceId, deviceName: $deviceName, deviceType: $deviceType, authToken: $authToken)';
}


}

/// @nodoc
abstract mixin class $DeviceCopyWith<$Res>  {
  factory $DeviceCopyWith(Device value, $Res Function(Device) _then) = _$DeviceCopyWithImpl;
@useResult
$Res call({
 String deviceId, String deviceName, DeviceType deviceType, String? authToken
});




}
/// @nodoc
class _$DeviceCopyWithImpl<$Res>
    implements $DeviceCopyWith<$Res> {
  _$DeviceCopyWithImpl(this._self, this._then);

  final Device _self;
  final $Res Function(Device) _then;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? deviceName = null,Object? deviceType = null,Object? authToken = freezed,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as DeviceType,authToken: freezed == authToken ? _self.authToken : authToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Device].
extension DevicePatterns on Device {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Device value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Device() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Device value)  $default,){
final _that = this;
switch (_that) {
case _Device():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Device value)?  $default,){
final _that = this;
switch (_that) {
case _Device() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  String deviceName,  DeviceType deviceType,  String? authToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Device() when $default != null:
return $default(_that.deviceId,_that.deviceName,_that.deviceType,_that.authToken);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  String deviceName,  DeviceType deviceType,  String? authToken)  $default,) {final _that = this;
switch (_that) {
case _Device():
return $default(_that.deviceId,_that.deviceName,_that.deviceType,_that.authToken);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  String deviceName,  DeviceType deviceType,  String? authToken)?  $default,) {final _that = this;
switch (_that) {
case _Device() when $default != null:
return $default(_that.deviceId,_that.deviceName,_that.deviceType,_that.authToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Device implements Device {
  const _Device({required this.deviceId, required this.deviceName, required this.deviceType, this.authToken = null});
  factory _Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

@override final  String deviceId;
@override final  String deviceName;
@override final  DeviceType deviceType;
// Auth token is optional - only present during registration
@override@JsonKey() final  String? authToken;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceCopyWith<_Device> get copyWith => __$DeviceCopyWithImpl<_Device>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Device&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.authToken, authToken) || other.authToken == authToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,deviceName,deviceType,authToken);

@override
String toString() {
  return 'Device(deviceId: $deviceId, deviceName: $deviceName, deviceType: $deviceType, authToken: $authToken)';
}


}

/// @nodoc
abstract mixin class _$DeviceCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$DeviceCopyWith(_Device value, $Res Function(_Device) _then) = __$DeviceCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, String deviceName, DeviceType deviceType, String? authToken
});




}
/// @nodoc
class __$DeviceCopyWithImpl<$Res>
    implements _$DeviceCopyWith<$Res> {
  __$DeviceCopyWithImpl(this._self, this._then);

  final _Device _self;
  final $Res Function(_Device) _then;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? deviceName = null,Object? deviceType = null,Object? authToken = freezed,}) {
  return _then(_Device(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as DeviceType,authToken: freezed == authToken ? _self.authToken : authToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DeviceRegistrationRequest {

 String get deviceName; DeviceType get deviceType;
/// Create a copy of DeviceRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceRegistrationRequestCopyWith<DeviceRegistrationRequest> get copyWith => _$DeviceRegistrationRequestCopyWithImpl<DeviceRegistrationRequest>(this as DeviceRegistrationRequest, _$identity);

  /// Serializes this DeviceRegistrationRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceRegistrationRequest&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceName,deviceType);

@override
String toString() {
  return 'DeviceRegistrationRequest(deviceName: $deviceName, deviceType: $deviceType)';
}


}

/// @nodoc
abstract mixin class $DeviceRegistrationRequestCopyWith<$Res>  {
  factory $DeviceRegistrationRequestCopyWith(DeviceRegistrationRequest value, $Res Function(DeviceRegistrationRequest) _then) = _$DeviceRegistrationRequestCopyWithImpl;
@useResult
$Res call({
 String deviceName, DeviceType deviceType
});




}
/// @nodoc
class _$DeviceRegistrationRequestCopyWithImpl<$Res>
    implements $DeviceRegistrationRequestCopyWith<$Res> {
  _$DeviceRegistrationRequestCopyWithImpl(this._self, this._then);

  final DeviceRegistrationRequest _self;
  final $Res Function(DeviceRegistrationRequest) _then;

/// Create a copy of DeviceRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceName = null,Object? deviceType = null,}) {
  return _then(_self.copyWith(
deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as DeviceType,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceRegistrationRequest].
extension DeviceRegistrationRequestPatterns on DeviceRegistrationRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceRegistrationRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceRegistrationRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceRegistrationRequest value)  $default,){
final _that = this;
switch (_that) {
case _DeviceRegistrationRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceRegistrationRequest value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceRegistrationRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceName,  DeviceType deviceType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceRegistrationRequest() when $default != null:
return $default(_that.deviceName,_that.deviceType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceName,  DeviceType deviceType)  $default,) {final _that = this;
switch (_that) {
case _DeviceRegistrationRequest():
return $default(_that.deviceName,_that.deviceType);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceName,  DeviceType deviceType)?  $default,) {final _that = this;
switch (_that) {
case _DeviceRegistrationRequest() when $default != null:
return $default(_that.deviceName,_that.deviceType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceRegistrationRequest implements DeviceRegistrationRequest {
  const _DeviceRegistrationRequest({required this.deviceName, required this.deviceType});
  factory _DeviceRegistrationRequest.fromJson(Map<String, dynamic> json) => _$DeviceRegistrationRequestFromJson(json);

@override final  String deviceName;
@override final  DeviceType deviceType;

/// Create a copy of DeviceRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceRegistrationRequestCopyWith<_DeviceRegistrationRequest> get copyWith => __$DeviceRegistrationRequestCopyWithImpl<_DeviceRegistrationRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceRegistrationRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceRegistrationRequest&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceName,deviceType);

@override
String toString() {
  return 'DeviceRegistrationRequest(deviceName: $deviceName, deviceType: $deviceType)';
}


}

/// @nodoc
abstract mixin class _$DeviceRegistrationRequestCopyWith<$Res> implements $DeviceRegistrationRequestCopyWith<$Res> {
  factory _$DeviceRegistrationRequestCopyWith(_DeviceRegistrationRequest value, $Res Function(_DeviceRegistrationRequest) _then) = __$DeviceRegistrationRequestCopyWithImpl;
@override @useResult
$Res call({
 String deviceName, DeviceType deviceType
});




}
/// @nodoc
class __$DeviceRegistrationRequestCopyWithImpl<$Res>
    implements _$DeviceRegistrationRequestCopyWith<$Res> {
  __$DeviceRegistrationRequestCopyWithImpl(this._self, this._then);

  final _DeviceRegistrationRequest _self;
  final $Res Function(_DeviceRegistrationRequest) _then;

/// Create a copy of DeviceRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceName = null,Object? deviceType = null,}) {
  return _then(_DeviceRegistrationRequest(
deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as DeviceType,
  ));
}


}


/// @nodoc
mixin _$DeviceRegistrationResponse {

 String get deviceId; String get deviceName; DeviceType get deviceType; String get authToken;
/// Create a copy of DeviceRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceRegistrationResponseCopyWith<DeviceRegistrationResponse> get copyWith => _$DeviceRegistrationResponseCopyWithImpl<DeviceRegistrationResponse>(this as DeviceRegistrationResponse, _$identity);

  /// Serializes this DeviceRegistrationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceRegistrationResponse&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.authToken, authToken) || other.authToken == authToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,deviceName,deviceType,authToken);

@override
String toString() {
  return 'DeviceRegistrationResponse(deviceId: $deviceId, deviceName: $deviceName, deviceType: $deviceType, authToken: $authToken)';
}


}

/// @nodoc
abstract mixin class $DeviceRegistrationResponseCopyWith<$Res>  {
  factory $DeviceRegistrationResponseCopyWith(DeviceRegistrationResponse value, $Res Function(DeviceRegistrationResponse) _then) = _$DeviceRegistrationResponseCopyWithImpl;
@useResult
$Res call({
 String deviceId, String deviceName, DeviceType deviceType, String authToken
});




}
/// @nodoc
class _$DeviceRegistrationResponseCopyWithImpl<$Res>
    implements $DeviceRegistrationResponseCopyWith<$Res> {
  _$DeviceRegistrationResponseCopyWithImpl(this._self, this._then);

  final DeviceRegistrationResponse _self;
  final $Res Function(DeviceRegistrationResponse) _then;

/// Create a copy of DeviceRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? deviceName = null,Object? deviceType = null,Object? authToken = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as DeviceType,authToken: null == authToken ? _self.authToken : authToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceRegistrationResponse].
extension DeviceRegistrationResponsePatterns on DeviceRegistrationResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceRegistrationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceRegistrationResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceRegistrationResponse value)  $default,){
final _that = this;
switch (_that) {
case _DeviceRegistrationResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceRegistrationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceRegistrationResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  String deviceName,  DeviceType deviceType,  String authToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceRegistrationResponse() when $default != null:
return $default(_that.deviceId,_that.deviceName,_that.deviceType,_that.authToken);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  String deviceName,  DeviceType deviceType,  String authToken)  $default,) {final _that = this;
switch (_that) {
case _DeviceRegistrationResponse():
return $default(_that.deviceId,_that.deviceName,_that.deviceType,_that.authToken);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  String deviceName,  DeviceType deviceType,  String authToken)?  $default,) {final _that = this;
switch (_that) {
case _DeviceRegistrationResponse() when $default != null:
return $default(_that.deviceId,_that.deviceName,_that.deviceType,_that.authToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceRegistrationResponse implements DeviceRegistrationResponse {
  const _DeviceRegistrationResponse({required this.deviceId, required this.deviceName, required this.deviceType, required this.authToken});
  factory _DeviceRegistrationResponse.fromJson(Map<String, dynamic> json) => _$DeviceRegistrationResponseFromJson(json);

@override final  String deviceId;
@override final  String deviceName;
@override final  DeviceType deviceType;
@override final  String authToken;

/// Create a copy of DeviceRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceRegistrationResponseCopyWith<_DeviceRegistrationResponse> get copyWith => __$DeviceRegistrationResponseCopyWithImpl<_DeviceRegistrationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceRegistrationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceRegistrationResponse&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.authToken, authToken) || other.authToken == authToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,deviceName,deviceType,authToken);

@override
String toString() {
  return 'DeviceRegistrationResponse(deviceId: $deviceId, deviceName: $deviceName, deviceType: $deviceType, authToken: $authToken)';
}


}

/// @nodoc
abstract mixin class _$DeviceRegistrationResponseCopyWith<$Res> implements $DeviceRegistrationResponseCopyWith<$Res> {
  factory _$DeviceRegistrationResponseCopyWith(_DeviceRegistrationResponse value, $Res Function(_DeviceRegistrationResponse) _then) = __$DeviceRegistrationResponseCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, String deviceName, DeviceType deviceType, String authToken
});




}
/// @nodoc
class __$DeviceRegistrationResponseCopyWithImpl<$Res>
    implements _$DeviceRegistrationResponseCopyWith<$Res> {
  __$DeviceRegistrationResponseCopyWithImpl(this._self, this._then);

  final _DeviceRegistrationResponse _self;
  final $Res Function(_DeviceRegistrationResponse) _then;

/// Create a copy of DeviceRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? deviceName = null,Object? deviceType = null,Object? authToken = null,}) {
  return _then(_DeviceRegistrationResponse(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as DeviceType,authToken: null == authToken ? _self.authToken : authToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
