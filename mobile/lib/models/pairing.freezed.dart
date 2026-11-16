// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pairing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PairingCreateRequest {



  /// Serializes this PairingCreateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PairingCreateRequest);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PairingCreateRequest()';
}


}

/// @nodoc
class $PairingCreateRequestCopyWith<$Res>  {
$PairingCreateRequestCopyWith(PairingCreateRequest _, $Res Function(PairingCreateRequest) __);
}


/// Adds pattern-matching-related methods to [PairingCreateRequest].
extension PairingCreateRequestPatterns on PairingCreateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PairingCreateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PairingCreateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PairingCreateRequest value)  $default,){
final _that = this;
switch (_that) {
case _PairingCreateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PairingCreateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PairingCreateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function()?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PairingCreateRequest() when $default != null:
return $default();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function()  $default,) {final _that = this;
switch (_that) {
case _PairingCreateRequest():
return $default();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function()?  $default,) {final _that = this;
switch (_that) {
case _PairingCreateRequest() when $default != null:
return $default();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PairingCreateRequest implements PairingCreateRequest {
  const _PairingCreateRequest();
  factory _PairingCreateRequest.fromJson(Map<String, dynamic> json) => _$PairingCreateRequestFromJson(json);




@override
Map<String, dynamic> toJson() {
  return _$PairingCreateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PairingCreateRequest);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PairingCreateRequest()';
}


}





/// @nodoc
mixin _$PairingCreateResponse {

@JsonKey(name: 'code') String get code;@JsonKey(name: 'expires_at') String get expiresAt;@JsonKey(name: 'device_id') String get deviceId;
/// Create a copy of PairingCreateResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PairingCreateResponseCopyWith<PairingCreateResponse> get copyWith => _$PairingCreateResponseCopyWithImpl<PairingCreateResponse>(this as PairingCreateResponse, _$identity);

  /// Serializes this PairingCreateResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PairingCreateResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,expiresAt,deviceId);

@override
String toString() {
  return 'PairingCreateResponse(code: $code, expiresAt: $expiresAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $PairingCreateResponseCopyWith<$Res>  {
  factory $PairingCreateResponseCopyWith(PairingCreateResponse value, $Res Function(PairingCreateResponse) _then) = _$PairingCreateResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'code') String code,@JsonKey(name: 'expires_at') String expiresAt,@JsonKey(name: 'device_id') String deviceId
});




}
/// @nodoc
class _$PairingCreateResponseCopyWithImpl<$Res>
    implements $PairingCreateResponseCopyWith<$Res> {
  _$PairingCreateResponseCopyWithImpl(this._self, this._then);

  final PairingCreateResponse _self;
  final $Res Function(PairingCreateResponse) _then;

/// Create a copy of PairingCreateResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? expiresAt = null,Object? deviceId = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PairingCreateResponse].
extension PairingCreateResponsePatterns on PairingCreateResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PairingCreateResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PairingCreateResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PairingCreateResponse value)  $default,){
final _that = this;
switch (_that) {
case _PairingCreateResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PairingCreateResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PairingCreateResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'code')  String code, @JsonKey(name: 'expires_at')  String expiresAt, @JsonKey(name: 'device_id')  String deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PairingCreateResponse() when $default != null:
return $default(_that.code,_that.expiresAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'code')  String code, @JsonKey(name: 'expires_at')  String expiresAt, @JsonKey(name: 'device_id')  String deviceId)  $default,) {final _that = this;
switch (_that) {
case _PairingCreateResponse():
return $default(_that.code,_that.expiresAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'code')  String code, @JsonKey(name: 'expires_at')  String expiresAt, @JsonKey(name: 'device_id')  String deviceId)?  $default,) {final _that = this;
switch (_that) {
case _PairingCreateResponse() when $default != null:
return $default(_that.code,_that.expiresAt,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PairingCreateResponse implements PairingCreateResponse {
  const _PairingCreateResponse({@JsonKey(name: 'code') required this.code, @JsonKey(name: 'expires_at') required this.expiresAt, @JsonKey(name: 'device_id') required this.deviceId});
  factory _PairingCreateResponse.fromJson(Map<String, dynamic> json) => _$PairingCreateResponseFromJson(json);

@override@JsonKey(name: 'code') final  String code;
@override@JsonKey(name: 'expires_at') final  String expiresAt;
@override@JsonKey(name: 'device_id') final  String deviceId;

/// Create a copy of PairingCreateResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PairingCreateResponseCopyWith<_PairingCreateResponse> get copyWith => __$PairingCreateResponseCopyWithImpl<_PairingCreateResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PairingCreateResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PairingCreateResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,expiresAt,deviceId);

@override
String toString() {
  return 'PairingCreateResponse(code: $code, expiresAt: $expiresAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$PairingCreateResponseCopyWith<$Res> implements $PairingCreateResponseCopyWith<$Res> {
  factory _$PairingCreateResponseCopyWith(_PairingCreateResponse value, $Res Function(_PairingCreateResponse) _then) = __$PairingCreateResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'code') String code,@JsonKey(name: 'expires_at') String expiresAt,@JsonKey(name: 'device_id') String deviceId
});




}
/// @nodoc
class __$PairingCreateResponseCopyWithImpl<$Res>
    implements _$PairingCreateResponseCopyWith<$Res> {
  __$PairingCreateResponseCopyWithImpl(this._self, this._then);

  final _PairingCreateResponse _self;
  final $Res Function(_PairingCreateResponse) _then;

/// Create a copy of PairingCreateResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? expiresAt = null,Object? deviceId = null,}) {
  return _then(_PairingCreateResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PairingConfirmRequest {

@JsonKey(name: 'code') String get code;
/// Create a copy of PairingConfirmRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PairingConfirmRequestCopyWith<PairingConfirmRequest> get copyWith => _$PairingConfirmRequestCopyWithImpl<PairingConfirmRequest>(this as PairingConfirmRequest, _$identity);

  /// Serializes this PairingConfirmRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PairingConfirmRequest&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'PairingConfirmRequest(code: $code)';
}


}

/// @nodoc
abstract mixin class $PairingConfirmRequestCopyWith<$Res>  {
  factory $PairingConfirmRequestCopyWith(PairingConfirmRequest value, $Res Function(PairingConfirmRequest) _then) = _$PairingConfirmRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'code') String code
});




}
/// @nodoc
class _$PairingConfirmRequestCopyWithImpl<$Res>
    implements $PairingConfirmRequestCopyWith<$Res> {
  _$PairingConfirmRequestCopyWithImpl(this._self, this._then);

  final PairingConfirmRequest _self;
  final $Res Function(PairingConfirmRequest) _then;

/// Create a copy of PairingConfirmRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PairingConfirmRequest].
extension PairingConfirmRequestPatterns on PairingConfirmRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PairingConfirmRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PairingConfirmRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PairingConfirmRequest value)  $default,){
final _that = this;
switch (_that) {
case _PairingConfirmRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PairingConfirmRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PairingConfirmRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'code')  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PairingConfirmRequest() when $default != null:
return $default(_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'code')  String code)  $default,) {final _that = this;
switch (_that) {
case _PairingConfirmRequest():
return $default(_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'code')  String code)?  $default,) {final _that = this;
switch (_that) {
case _PairingConfirmRequest() when $default != null:
return $default(_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PairingConfirmRequest implements PairingConfirmRequest {
  const _PairingConfirmRequest({@JsonKey(name: 'code') required this.code});
  factory _PairingConfirmRequest.fromJson(Map<String, dynamic> json) => _$PairingConfirmRequestFromJson(json);

@override@JsonKey(name: 'code') final  String code;

/// Create a copy of PairingConfirmRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PairingConfirmRequestCopyWith<_PairingConfirmRequest> get copyWith => __$PairingConfirmRequestCopyWithImpl<_PairingConfirmRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PairingConfirmRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PairingConfirmRequest&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'PairingConfirmRequest(code: $code)';
}


}

/// @nodoc
abstract mixin class _$PairingConfirmRequestCopyWith<$Res> implements $PairingConfirmRequestCopyWith<$Res> {
  factory _$PairingConfirmRequestCopyWith(_PairingConfirmRequest value, $Res Function(_PairingConfirmRequest) _then) = __$PairingConfirmRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'code') String code
});




}
/// @nodoc
class __$PairingConfirmRequestCopyWithImpl<$Res>
    implements _$PairingConfirmRequestCopyWith<$Res> {
  __$PairingConfirmRequestCopyWithImpl(this._self, this._then);

  final _PairingConfirmRequest _self;
  final $Res Function(_PairingConfirmRequest) _then;

/// Create a copy of PairingConfirmRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_PairingConfirmRequest(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PairingConfirmResponse {

@JsonKey(name: 'paired_device') PairedDeviceInfo get pairedDevice;@JsonKey(name: 'this_device') PairedDeviceInfo get thisDevice;
/// Create a copy of PairingConfirmResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PairingConfirmResponseCopyWith<PairingConfirmResponse> get copyWith => _$PairingConfirmResponseCopyWithImpl<PairingConfirmResponse>(this as PairingConfirmResponse, _$identity);

  /// Serializes this PairingConfirmResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PairingConfirmResponse&&(identical(other.pairedDevice, pairedDevice) || other.pairedDevice == pairedDevice)&&(identical(other.thisDevice, thisDevice) || other.thisDevice == thisDevice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pairedDevice,thisDevice);

@override
String toString() {
  return 'PairingConfirmResponse(pairedDevice: $pairedDevice, thisDevice: $thisDevice)';
}


}

/// @nodoc
abstract mixin class $PairingConfirmResponseCopyWith<$Res>  {
  factory $PairingConfirmResponseCopyWith(PairingConfirmResponse value, $Res Function(PairingConfirmResponse) _then) = _$PairingConfirmResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'paired_device') PairedDeviceInfo pairedDevice,@JsonKey(name: 'this_device') PairedDeviceInfo thisDevice
});


$PairedDeviceInfoCopyWith<$Res> get pairedDevice;$PairedDeviceInfoCopyWith<$Res> get thisDevice;

}
/// @nodoc
class _$PairingConfirmResponseCopyWithImpl<$Res>
    implements $PairingConfirmResponseCopyWith<$Res> {
  _$PairingConfirmResponseCopyWithImpl(this._self, this._then);

  final PairingConfirmResponse _self;
  final $Res Function(PairingConfirmResponse) _then;

/// Create a copy of PairingConfirmResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pairedDevice = null,Object? thisDevice = null,}) {
  return _then(_self.copyWith(
pairedDevice: null == pairedDevice ? _self.pairedDevice : pairedDevice // ignore: cast_nullable_to_non_nullable
as PairedDeviceInfo,thisDevice: null == thisDevice ? _self.thisDevice : thisDevice // ignore: cast_nullable_to_non_nullable
as PairedDeviceInfo,
  ));
}
/// Create a copy of PairingConfirmResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PairedDeviceInfoCopyWith<$Res> get pairedDevice {

  return $PairedDeviceInfoCopyWith<$Res>(_self.pairedDevice, (value) {
    return _then(_self.copyWith(pairedDevice: value));
  });
}/// Create a copy of PairingConfirmResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PairedDeviceInfoCopyWith<$Res> get thisDevice {

  return $PairedDeviceInfoCopyWith<$Res>(_self.thisDevice, (value) {
    return _then(_self.copyWith(thisDevice: value));
  });
}
}


/// Adds pattern-matching-related methods to [PairingConfirmResponse].
extension PairingConfirmResponsePatterns on PairingConfirmResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PairingConfirmResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PairingConfirmResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PairingConfirmResponse value)  $default,){
final _that = this;
switch (_that) {
case _PairingConfirmResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PairingConfirmResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PairingConfirmResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'paired_device')  PairedDeviceInfo pairedDevice, @JsonKey(name: 'this_device')  PairedDeviceInfo thisDevice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PairingConfirmResponse() when $default != null:
return $default(_that.pairedDevice,_that.thisDevice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'paired_device')  PairedDeviceInfo pairedDevice, @JsonKey(name: 'this_device')  PairedDeviceInfo thisDevice)  $default,) {final _that = this;
switch (_that) {
case _PairingConfirmResponse():
return $default(_that.pairedDevice,_that.thisDevice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'paired_device')  PairedDeviceInfo pairedDevice, @JsonKey(name: 'this_device')  PairedDeviceInfo thisDevice)?  $default,) {final _that = this;
switch (_that) {
case _PairingConfirmResponse() when $default != null:
return $default(_that.pairedDevice,_that.thisDevice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PairingConfirmResponse implements PairingConfirmResponse {
  const _PairingConfirmResponse({@JsonKey(name: 'paired_device') required this.pairedDevice, @JsonKey(name: 'this_device') required this.thisDevice});
  factory _PairingConfirmResponse.fromJson(Map<String, dynamic> json) => _$PairingConfirmResponseFromJson(json);

@override@JsonKey(name: 'paired_device') final  PairedDeviceInfo pairedDevice;
@override@JsonKey(name: 'this_device') final  PairedDeviceInfo thisDevice;

/// Create a copy of PairingConfirmResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PairingConfirmResponseCopyWith<_PairingConfirmResponse> get copyWith => __$PairingConfirmResponseCopyWithImpl<_PairingConfirmResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PairingConfirmResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PairingConfirmResponse&&(identical(other.pairedDevice, pairedDevice) || other.pairedDevice == pairedDevice)&&(identical(other.thisDevice, thisDevice) || other.thisDevice == thisDevice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pairedDevice,thisDevice);

@override
String toString() {
  return 'PairingConfirmResponse(pairedDevice: $pairedDevice, thisDevice: $thisDevice)';
}


}

/// @nodoc
abstract mixin class _$PairingConfirmResponseCopyWith<$Res> implements $PairingConfirmResponseCopyWith<$Res> {
  factory _$PairingConfirmResponseCopyWith(_PairingConfirmResponse value, $Res Function(_PairingConfirmResponse) _then) = __$PairingConfirmResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'paired_device') PairedDeviceInfo pairedDevice,@JsonKey(name: 'this_device') PairedDeviceInfo thisDevice
});


@override $PairedDeviceInfoCopyWith<$Res> get pairedDevice;@override $PairedDeviceInfoCopyWith<$Res> get thisDevice;

}
/// @nodoc
class __$PairingConfirmResponseCopyWithImpl<$Res>
    implements _$PairingConfirmResponseCopyWith<$Res> {
  __$PairingConfirmResponseCopyWithImpl(this._self, this._then);

  final _PairingConfirmResponse _self;
  final $Res Function(_PairingConfirmResponse) _then;

/// Create a copy of PairingConfirmResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pairedDevice = null,Object? thisDevice = null,}) {
  return _then(_PairingConfirmResponse(
pairedDevice: null == pairedDevice ? _self.pairedDevice : pairedDevice // ignore: cast_nullable_to_non_nullable
as PairedDeviceInfo,thisDevice: null == thisDevice ? _self.thisDevice : thisDevice // ignore: cast_nullable_to_non_nullable
as PairedDeviceInfo,
  ));
}

/// Create a copy of PairingConfirmResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PairedDeviceInfoCopyWith<$Res> get pairedDevice {

  return $PairedDeviceInfoCopyWith<$Res>(_self.pairedDevice, (value) {
    return _then(_self.copyWith(pairedDevice: value));
  });
}/// Create a copy of PairingConfirmResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PairedDeviceInfoCopyWith<$Res> get thisDevice {

  return $PairedDeviceInfoCopyWith<$Res>(_self.thisDevice, (value) {
    return _then(_self.copyWith(thisDevice: value));
  });
}
}


/// @nodoc
mixin _$PairedDeviceInfo {

@JsonKey(name: 'device_id') String get deviceId;@JsonKey(name: 'device_name') String get deviceName;@JsonKey(name: 'device_type') String get deviceType;
/// Create a copy of PairedDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PairedDeviceInfoCopyWith<PairedDeviceInfo> get copyWith => _$PairedDeviceInfoCopyWithImpl<PairedDeviceInfo>(this as PairedDeviceInfo, _$identity);

  /// Serializes this PairedDeviceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PairedDeviceInfo&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,deviceName,deviceType);

@override
String toString() {
  return 'PairedDeviceInfo(deviceId: $deviceId, deviceName: $deviceName, deviceType: $deviceType)';
}


}

/// @nodoc
abstract mixin class $PairedDeviceInfoCopyWith<$Res>  {
  factory $PairedDeviceInfoCopyWith(PairedDeviceInfo value, $Res Function(PairedDeviceInfo) _then) = _$PairedDeviceInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'device_name') String deviceName,@JsonKey(name: 'device_type') String deviceType
});




}
/// @nodoc
class _$PairedDeviceInfoCopyWithImpl<$Res>
    implements $PairedDeviceInfoCopyWith<$Res> {
  _$PairedDeviceInfoCopyWithImpl(this._self, this._then);

  final PairedDeviceInfo _self;
  final $Res Function(PairedDeviceInfo) _then;

/// Create a copy of PairedDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? deviceName = null,Object? deviceType = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PairedDeviceInfo].
extension PairedDeviceInfoPatterns on PairedDeviceInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PairedDeviceInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PairedDeviceInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PairedDeviceInfo value)  $default,){
final _that = this;
switch (_that) {
case _PairedDeviceInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PairedDeviceInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PairedDeviceInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'device_name')  String deviceName, @JsonKey(name: 'device_type')  String deviceType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PairedDeviceInfo() when $default != null:
return $default(_that.deviceId,_that.deviceName,_that.deviceType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'device_name')  String deviceName, @JsonKey(name: 'device_type')  String deviceType)  $default,) {final _that = this;
switch (_that) {
case _PairedDeviceInfo():
return $default(_that.deviceId,_that.deviceName,_that.deviceType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'device_name')  String deviceName, @JsonKey(name: 'device_type')  String deviceType)?  $default,) {final _that = this;
switch (_that) {
case _PairedDeviceInfo() when $default != null:
return $default(_that.deviceId,_that.deviceName,_that.deviceType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PairedDeviceInfo implements PairedDeviceInfo {
  const _PairedDeviceInfo({@JsonKey(name: 'device_id') required this.deviceId, @JsonKey(name: 'device_name') required this.deviceName, @JsonKey(name: 'device_type') required this.deviceType});
  factory _PairedDeviceInfo.fromJson(Map<String, dynamic> json) => _$PairedDeviceInfoFromJson(json);

@override@JsonKey(name: 'device_id') final  String deviceId;
@override@JsonKey(name: 'device_name') final  String deviceName;
@override@JsonKey(name: 'device_type') final  String deviceType;

/// Create a copy of PairedDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PairedDeviceInfoCopyWith<_PairedDeviceInfo> get copyWith => __$PairedDeviceInfoCopyWithImpl<_PairedDeviceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PairedDeviceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PairedDeviceInfo&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,deviceName,deviceType);

@override
String toString() {
  return 'PairedDeviceInfo(deviceId: $deviceId, deviceName: $deviceName, deviceType: $deviceType)';
}


}

/// @nodoc
abstract mixin class _$PairedDeviceInfoCopyWith<$Res> implements $PairedDeviceInfoCopyWith<$Res> {
  factory _$PairedDeviceInfoCopyWith(_PairedDeviceInfo value, $Res Function(_PairedDeviceInfo) _then) = __$PairedDeviceInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'device_name') String deviceName,@JsonKey(name: 'device_type') String deviceType
});




}
/// @nodoc
class __$PairedDeviceInfoCopyWithImpl<$Res>
    implements _$PairedDeviceInfoCopyWith<$Res> {
  __$PairedDeviceInfoCopyWithImpl(this._self, this._then);

  final _PairedDeviceInfo _self;
  final $Res Function(_PairedDeviceInfo) _then;

/// Create a copy of PairedDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? deviceName = null,Object? deviceType = null,}) {
  return _then(_PairedDeviceInfo(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PairedDevicesResponse {

@JsonKey(name: 'device_id') String get deviceId;@JsonKey(name: 'paired_devices') List<PairedDeviceInfo> get pairedDevices;
/// Create a copy of PairedDevicesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PairedDevicesResponseCopyWith<PairedDevicesResponse> get copyWith => _$PairedDevicesResponseCopyWithImpl<PairedDevicesResponse>(this as PairedDevicesResponse, _$identity);

  /// Serializes this PairedDevicesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PairedDevicesResponse&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&const DeepCollectionEquality().equals(other.pairedDevices, pairedDevices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,const DeepCollectionEquality().hash(pairedDevices));

@override
String toString() {
  return 'PairedDevicesResponse(deviceId: $deviceId, pairedDevices: $pairedDevices)';
}


}

/// @nodoc
abstract mixin class $PairedDevicesResponseCopyWith<$Res>  {
  factory $PairedDevicesResponseCopyWith(PairedDevicesResponse value, $Res Function(PairedDevicesResponse) _then) = _$PairedDevicesResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'paired_devices') List<PairedDeviceInfo> pairedDevices
});




}
/// @nodoc
class _$PairedDevicesResponseCopyWithImpl<$Res>
    implements $PairedDevicesResponseCopyWith<$Res> {
  _$PairedDevicesResponseCopyWithImpl(this._self, this._then);

  final PairedDevicesResponse _self;
  final $Res Function(PairedDevicesResponse) _then;

/// Create a copy of PairedDevicesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? pairedDevices = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,pairedDevices: null == pairedDevices ? _self.pairedDevices : pairedDevices // ignore: cast_nullable_to_non_nullable
as List<PairedDeviceInfo>,
  ));
}

}


/// Adds pattern-matching-related methods to [PairedDevicesResponse].
extension PairedDevicesResponsePatterns on PairedDevicesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PairedDevicesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PairedDevicesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PairedDevicesResponse value)  $default,){
final _that = this;
switch (_that) {
case _PairedDevicesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PairedDevicesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PairedDevicesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'paired_devices')  List<PairedDeviceInfo> pairedDevices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PairedDevicesResponse() when $default != null:
return $default(_that.deviceId,_that.pairedDevices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'paired_devices')  List<PairedDeviceInfo> pairedDevices)  $default,) {final _that = this;
switch (_that) {
case _PairedDevicesResponse():
return $default(_that.deviceId,_that.pairedDevices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'paired_devices')  List<PairedDeviceInfo> pairedDevices)?  $default,) {final _that = this;
switch (_that) {
case _PairedDevicesResponse() when $default != null:
return $default(_that.deviceId,_that.pairedDevices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PairedDevicesResponse implements PairedDevicesResponse {
  const _PairedDevicesResponse({@JsonKey(name: 'device_id') required this.deviceId, @JsonKey(name: 'paired_devices') required final  List<PairedDeviceInfo> pairedDevices}): _pairedDevices = pairedDevices;
  factory _PairedDevicesResponse.fromJson(Map<String, dynamic> json) => _$PairedDevicesResponseFromJson(json);

@override@JsonKey(name: 'device_id') final  String deviceId;
 final  List<PairedDeviceInfo> _pairedDevices;
@override@JsonKey(name: 'paired_devices') List<PairedDeviceInfo> get pairedDevices {
  if (_pairedDevices is EqualUnmodifiableListView) return _pairedDevices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pairedDevices);
}


/// Create a copy of PairedDevicesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PairedDevicesResponseCopyWith<_PairedDevicesResponse> get copyWith => __$PairedDevicesResponseCopyWithImpl<_PairedDevicesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PairedDevicesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PairedDevicesResponse&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&const DeepCollectionEquality().equals(other._pairedDevices, _pairedDevices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,const DeepCollectionEquality().hash(_pairedDevices));

@override
String toString() {
  return 'PairedDevicesResponse(deviceId: $deviceId, pairedDevices: $pairedDevices)';
}


}

/// @nodoc
abstract mixin class _$PairedDevicesResponseCopyWith<$Res> implements $PairedDevicesResponseCopyWith<$Res> {
  factory _$PairedDevicesResponseCopyWith(_PairedDevicesResponse value, $Res Function(_PairedDevicesResponse) _then) = __$PairedDevicesResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'paired_devices') List<PairedDeviceInfo> pairedDevices
});




}
/// @nodoc
class __$PairedDevicesResponseCopyWithImpl<$Res>
    implements _$PairedDevicesResponseCopyWith<$Res> {
  __$PairedDevicesResponseCopyWithImpl(this._self, this._then);

  final _PairedDevicesResponse _self;
  final $Res Function(_PairedDevicesResponse) _then;

/// Create a copy of PairedDevicesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? pairedDevices = null,}) {
  return _then(_PairedDevicesResponse(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,pairedDevices: null == pairedDevices ? _self._pairedDevices : pairedDevices // ignore: cast_nullable_to_non_nullable
as List<PairedDeviceInfo>,
  ));
}


}


/// @nodoc
mixin _$PairingErrorResponse {

 String get detail;
/// Create a copy of PairingErrorResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PairingErrorResponseCopyWith<PairingErrorResponse> get copyWith => _$PairingErrorResponseCopyWithImpl<PairingErrorResponse>(this as PairingErrorResponse, _$identity);

  /// Serializes this PairingErrorResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PairingErrorResponse&&(identical(other.detail, detail) || other.detail == detail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detail);

@override
String toString() {
  return 'PairingErrorResponse(detail: $detail)';
}


}

/// @nodoc
abstract mixin class $PairingErrorResponseCopyWith<$Res>  {
  factory $PairingErrorResponseCopyWith(PairingErrorResponse value, $Res Function(PairingErrorResponse) _then) = _$PairingErrorResponseCopyWithImpl;
@useResult
$Res call({
 String detail
});




}
/// @nodoc
class _$PairingErrorResponseCopyWithImpl<$Res>
    implements $PairingErrorResponseCopyWith<$Res> {
  _$PairingErrorResponseCopyWithImpl(this._self, this._then);

  final PairingErrorResponse _self;
  final $Res Function(PairingErrorResponse) _then;

/// Create a copy of PairingErrorResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? detail = null,}) {
  return _then(_self.copyWith(
detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PairingErrorResponse].
extension PairingErrorResponsePatterns on PairingErrorResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PairingErrorResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PairingErrorResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PairingErrorResponse value)  $default,){
final _that = this;
switch (_that) {
case _PairingErrorResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PairingErrorResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PairingErrorResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String detail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PairingErrorResponse() when $default != null:
return $default(_that.detail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String detail)  $default,) {final _that = this;
switch (_that) {
case _PairingErrorResponse():
return $default(_that.detail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String detail)?  $default,) {final _that = this;
switch (_that) {
case _PairingErrorResponse() when $default != null:
return $default(_that.detail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PairingErrorResponse implements PairingErrorResponse {
  const _PairingErrorResponse({required this.detail});
  factory _PairingErrorResponse.fromJson(Map<String, dynamic> json) => _$PairingErrorResponseFromJson(json);

@override final  String detail;

/// Create a copy of PairingErrorResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PairingErrorResponseCopyWith<_PairingErrorResponse> get copyWith => __$PairingErrorResponseCopyWithImpl<_PairingErrorResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PairingErrorResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PairingErrorResponse&&(identical(other.detail, detail) || other.detail == detail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detail);

@override
String toString() {
  return 'PairingErrorResponse(detail: $detail)';
}


}

/// @nodoc
abstract mixin class _$PairingErrorResponseCopyWith<$Res> implements $PairingErrorResponseCopyWith<$Res> {
  factory _$PairingErrorResponseCopyWith(_PairingErrorResponse value, $Res Function(_PairingErrorResponse) _then) = __$PairingErrorResponseCopyWithImpl;
@override @useResult
$Res call({
 String detail
});




}
/// @nodoc
class __$PairingErrorResponseCopyWithImpl<$Res>
    implements _$PairingErrorResponseCopyWith<$Res> {
  __$PairingErrorResponseCopyWithImpl(this._self, this._then);

  final _PairingErrorResponse _self;
  final $Res Function(_PairingErrorResponse) _then;

/// Create a copy of PairingErrorResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detail = null,}) {
  return _then(_PairingErrorResponse(
detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
