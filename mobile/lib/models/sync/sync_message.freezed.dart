// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClipboardPayload {

 ContentType get contentType; String get text;
/// Create a copy of ClipboardPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClipboardPayloadCopyWith<ClipboardPayload> get copyWith => _$ClipboardPayloadCopyWithImpl<ClipboardPayload>(this as ClipboardPayload, _$identity);

  /// Serializes this ClipboardPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClipboardPayload&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentType,text);

@override
String toString() {
  return 'ClipboardPayload(contentType: $contentType, text: $text)';
}


}

/// @nodoc
abstract mixin class $ClipboardPayloadCopyWith<$Res>  {
  factory $ClipboardPayloadCopyWith(ClipboardPayload value, $Res Function(ClipboardPayload) _then) = _$ClipboardPayloadCopyWithImpl;
@useResult
$Res call({
 ContentType contentType, String text
});




}
/// @nodoc
class _$ClipboardPayloadCopyWithImpl<$Res>
    implements $ClipboardPayloadCopyWith<$Res> {
  _$ClipboardPayloadCopyWithImpl(this._self, this._then);

  final ClipboardPayload _self;
  final $Res Function(ClipboardPayload) _then;

/// Create a copy of ClipboardPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentType = null,Object? text = null,}) {
  return _then(_self.copyWith(
contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as ContentType,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClipboardPayload].
extension ClipboardPayloadPatterns on ClipboardPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClipboardPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClipboardPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClipboardPayload value)  $default,){
final _that = this;
switch (_that) {
case _ClipboardPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClipboardPayload value)?  $default,){
final _that = this;
switch (_that) {
case _ClipboardPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ContentType contentType,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClipboardPayload() when $default != null:
return $default(_that.contentType,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ContentType contentType,  String text)  $default,) {final _that = this;
switch (_that) {
case _ClipboardPayload():
return $default(_that.contentType,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ContentType contentType,  String text)?  $default,) {final _that = this;
switch (_that) {
case _ClipboardPayload() when $default != null:
return $default(_that.contentType,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClipboardPayload implements ClipboardPayload {
  const _ClipboardPayload({this.contentType = ContentType.text, required this.text});
  factory _ClipboardPayload.fromJson(Map<String, dynamic> json) => _$ClipboardPayloadFromJson(json);

@override@JsonKey() final  ContentType contentType;
@override final  String text;

/// Create a copy of ClipboardPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClipboardPayloadCopyWith<_ClipboardPayload> get copyWith => __$ClipboardPayloadCopyWithImpl<_ClipboardPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClipboardPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClipboardPayload&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentType,text);

@override
String toString() {
  return 'ClipboardPayload(contentType: $contentType, text: $text)';
}


}

/// @nodoc
abstract mixin class _$ClipboardPayloadCopyWith<$Res> implements $ClipboardPayloadCopyWith<$Res> {
  factory _$ClipboardPayloadCopyWith(_ClipboardPayload value, $Res Function(_ClipboardPayload) _then) = __$ClipboardPayloadCopyWithImpl;
@override @useResult
$Res call({
 ContentType contentType, String text
});




}
/// @nodoc
class __$ClipboardPayloadCopyWithImpl<$Res>
    implements _$ClipboardPayloadCopyWith<$Res> {
  __$ClipboardPayloadCopyWithImpl(this._self, this._then);

  final _ClipboardPayload _self;
  final $Res Function(_ClipboardPayload) _then;

/// Create a copy of ClipboardPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentType = null,Object? text = null,}) {
  return _then(_ClipboardPayload(
contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as ContentType,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SyncMessageBase {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp;
/// Create a copy of SyncMessageBase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncMessageBaseCopyWith<SyncMessageBase> get copyWith => _$SyncMessageBaseCopyWithImpl<SyncMessageBase>(this as SyncMessageBase, _$identity);

  /// Serializes this SyncMessageBase to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncMessageBase&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp);

@override
String toString() {
  return 'SyncMessageBase(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $SyncMessageBaseCopyWith<$Res>  {
  factory $SyncMessageBaseCopyWith(SyncMessageBase value, $Res Function(SyncMessageBase) _then) = _$SyncMessageBaseCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp
});




}
/// @nodoc
class _$SyncMessageBaseCopyWithImpl<$Res>
    implements $SyncMessageBaseCopyWith<$Res> {
  _$SyncMessageBaseCopyWithImpl(this._self, this._then);

  final SyncMessageBase _self;
  final $Res Function(SyncMessageBase) _then;

/// Create a copy of SyncMessageBase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncMessageBase].
extension SyncMessageBasePatterns on SyncMessageBase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncMessageBase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncMessageBase() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncMessageBase value)  $default,){
final _that = this;
switch (_that) {
case _SyncMessageBase():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncMessageBase value)?  $default,){
final _that = this;
switch (_that) {
case _SyncMessageBase() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncMessageBase() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp)  $default,) {final _that = this;
switch (_that) {
case _SyncMessageBase():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp)?  $default,) {final _that = this;
switch (_that) {
case _SyncMessageBase() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncMessageBase implements SyncMessageBase {
  const _SyncMessageBase({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp});
  factory _SyncMessageBase.fromJson(Map<String, dynamic> json) => _$SyncMessageBaseFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;

/// Create a copy of SyncMessageBase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncMessageBaseCopyWith<_SyncMessageBase> get copyWith => __$SyncMessageBaseCopyWithImpl<_SyncMessageBase>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncMessageBaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncMessageBase&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp);

@override
String toString() {
  return 'SyncMessageBase(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$SyncMessageBaseCopyWith<$Res> implements $SyncMessageBaseCopyWith<$Res> {
  factory _$SyncMessageBaseCopyWith(_SyncMessageBase value, $Res Function(_SyncMessageBase) _then) = __$SyncMessageBaseCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp
});




}
/// @nodoc
class __$SyncMessageBaseCopyWithImpl<$Res>
    implements _$SyncMessageBaseCopyWith<$Res> {
  __$SyncMessageBaseCopyWithImpl(this._self, this._then);

  final _SyncMessageBase _self;
  final $Res Function(_SyncMessageBase) _then;

/// Create a copy of SyncMessageBase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,}) {
  return _then(_SyncMessageBase(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ClipboardUpdateMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; ClipboardPayload get payload;
/// Create a copy of ClipboardUpdateMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClipboardUpdateMessageCopyWith<ClipboardUpdateMessage> get copyWith => _$ClipboardUpdateMessageCopyWithImpl<ClipboardUpdateMessage>(this as ClipboardUpdateMessage, _$identity);

  /// Serializes this ClipboardUpdateMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClipboardUpdateMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.payload, payload) || other.payload == payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,payload);

@override
String toString() {
  return 'ClipboardUpdateMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $ClipboardUpdateMessageCopyWith<$Res>  {
  factory $ClipboardUpdateMessageCopyWith(ClipboardUpdateMessage value, $Res Function(ClipboardUpdateMessage) _then) = _$ClipboardUpdateMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, ClipboardPayload payload
});


$ClipboardPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class _$ClipboardUpdateMessageCopyWithImpl<$Res>
    implements $ClipboardUpdateMessageCopyWith<$Res> {
  _$ClipboardUpdateMessageCopyWithImpl(this._self, this._then);

  final ClipboardUpdateMessage _self;
  final $Res Function(ClipboardUpdateMessage) _then;

/// Create a copy of ClipboardUpdateMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as ClipboardPayload,
  ));
}
/// Create a copy of ClipboardUpdateMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClipboardPayloadCopyWith<$Res> get payload {
  
  return $ClipboardPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClipboardUpdateMessage].
extension ClipboardUpdateMessagePatterns on ClipboardUpdateMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClipboardUpdateMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClipboardUpdateMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClipboardUpdateMessage value)  $default,){
final _that = this;
switch (_that) {
case _ClipboardUpdateMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClipboardUpdateMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ClipboardUpdateMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  ClipboardPayload payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClipboardUpdateMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  ClipboardPayload payload)  $default,) {final _that = this;
switch (_that) {
case _ClipboardUpdateMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  ClipboardPayload payload)?  $default,) {final _that = this;
switch (_that) {
case _ClipboardUpdateMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClipboardUpdateMessage implements ClipboardUpdateMessage {
  const _ClipboardUpdateMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, required this.payload});
  factory _ClipboardUpdateMessage.fromJson(Map<String, dynamic> json) => _$ClipboardUpdateMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
@override final  ClipboardPayload payload;

/// Create a copy of ClipboardUpdateMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClipboardUpdateMessageCopyWith<_ClipboardUpdateMessage> get copyWith => __$ClipboardUpdateMessageCopyWithImpl<_ClipboardUpdateMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClipboardUpdateMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClipboardUpdateMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.payload, payload) || other.payload == payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,payload);

@override
String toString() {
  return 'ClipboardUpdateMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$ClipboardUpdateMessageCopyWith<$Res> implements $ClipboardUpdateMessageCopyWith<$Res> {
  factory _$ClipboardUpdateMessageCopyWith(_ClipboardUpdateMessage value, $Res Function(_ClipboardUpdateMessage) _then) = __$ClipboardUpdateMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, ClipboardPayload payload
});


@override $ClipboardPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class __$ClipboardUpdateMessageCopyWithImpl<$Res>
    implements _$ClipboardUpdateMessageCopyWith<$Res> {
  __$ClipboardUpdateMessageCopyWithImpl(this._self, this._then);

  final _ClipboardUpdateMessage _self;
  final $Res Function(_ClipboardUpdateMessage) _then;

/// Create a copy of ClipboardUpdateMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_ClipboardUpdateMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as ClipboardPayload,
  ));
}

/// Create a copy of ClipboardUpdateMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClipboardPayloadCopyWith<$Res> get payload {
  
  return $ClipboardPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}


/// @nodoc
mixin _$PingMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; Map<String, dynamic>? get payload;
/// Create a copy of PingMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PingMessageCopyWith<PingMessage> get copyWith => _$PingMessageCopyWithImpl<PingMessage>(this as PingMessage, _$identity);

  /// Serializes this PingMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PingMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'PingMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $PingMessageCopyWith<$Res>  {
  factory $PingMessageCopyWith(PingMessage value, $Res Function(PingMessage) _then) = _$PingMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic>? payload
});




}
/// @nodoc
class _$PingMessageCopyWithImpl<$Res>
    implements $PingMessageCopyWith<$Res> {
  _$PingMessageCopyWithImpl(this._self, this._then);

  final PingMessage _self;
  final $Res Function(PingMessage) _then;

/// Create a copy of PingMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PingMessage].
extension PingMessagePatterns on PingMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PingMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PingMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PingMessage value)  $default,){
final _that = this;
switch (_that) {
case _PingMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PingMessage value)?  $default,){
final _that = this;
switch (_that) {
case _PingMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic>? payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PingMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic>? payload)  $default,) {final _that = this;
switch (_that) {
case _PingMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic>? payload)?  $default,) {final _that = this;
switch (_that) {
case _PingMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PingMessage implements PingMessage {
  const _PingMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, final  Map<String, dynamic>? payload}): _payload = payload;
  factory _PingMessage.fromJson(Map<String, dynamic> json) => _$PingMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
 final  Map<String, dynamic>? _payload;
@override Map<String, dynamic>? get payload {
  final value = _payload;
  if (value == null) return null;
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PingMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PingMessageCopyWith<_PingMessage> get copyWith => __$PingMessageCopyWithImpl<_PingMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PingMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PingMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'PingMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$PingMessageCopyWith<$Res> implements $PingMessageCopyWith<$Res> {
  factory _$PingMessageCopyWith(_PingMessage value, $Res Function(_PingMessage) _then) = __$PingMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic>? payload
});




}
/// @nodoc
class __$PingMessageCopyWithImpl<$Res>
    implements _$PingMessageCopyWith<$Res> {
  __$PingMessageCopyWithImpl(this._self, this._then);

  final _PingMessage _self;
  final $Res Function(_PingMessage) _then;

/// Create a copy of PingMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = freezed,}) {
  return _then(_PingMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$DeliveryReceiptMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; Map<String, dynamic> get payload;
/// Create a copy of DeliveryReceiptMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryReceiptMessageCopyWith<DeliveryReceiptMessage> get copyWith => _$DeliveryReceiptMessageCopyWithImpl<DeliveryReceiptMessage>(this as DeliveryReceiptMessage, _$identity);

  /// Serializes this DeliveryReceiptMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryReceiptMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'DeliveryReceiptMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $DeliveryReceiptMessageCopyWith<$Res>  {
  factory $DeliveryReceiptMessageCopyWith(DeliveryReceiptMessage value, $Res Function(DeliveryReceiptMessage) _then) = _$DeliveryReceiptMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class _$DeliveryReceiptMessageCopyWithImpl<$Res>
    implements $DeliveryReceiptMessageCopyWith<$Res> {
  _$DeliveryReceiptMessageCopyWithImpl(this._self, this._then);

  final DeliveryReceiptMessage _self;
  final $Res Function(DeliveryReceiptMessage) _then;

/// Create a copy of DeliveryReceiptMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryReceiptMessage].
extension DeliveryReceiptMessagePatterns on DeliveryReceiptMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryReceiptMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryReceiptMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryReceiptMessage value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryReceiptMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryReceiptMessage value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryReceiptMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryReceiptMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)  $default,) {final _that = this;
switch (_that) {
case _DeliveryReceiptMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryReceiptMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeliveryReceiptMessage implements DeliveryReceiptMessage {
  const _DeliveryReceiptMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, required final  Map<String, dynamic> payload}): _payload = payload;
  factory _DeliveryReceiptMessage.fromJson(Map<String, dynamic> json) => _$DeliveryReceiptMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of DeliveryReceiptMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryReceiptMessageCopyWith<_DeliveryReceiptMessage> get copyWith => __$DeliveryReceiptMessageCopyWithImpl<_DeliveryReceiptMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeliveryReceiptMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryReceiptMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'DeliveryReceiptMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$DeliveryReceiptMessageCopyWith<$Res> implements $DeliveryReceiptMessageCopyWith<$Res> {
  factory _$DeliveryReceiptMessageCopyWith(_DeliveryReceiptMessage value, $Res Function(_DeliveryReceiptMessage) _then) = __$DeliveryReceiptMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class __$DeliveryReceiptMessageCopyWithImpl<$Res>
    implements _$DeliveryReceiptMessageCopyWith<$Res> {
  __$DeliveryReceiptMessageCopyWithImpl(this._self, this._then);

  final _DeliveryReceiptMessage _self;
  final $Res Function(_DeliveryReceiptMessage) _then;

/// Create a copy of DeliveryReceiptMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_DeliveryReceiptMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$HistorySyncRequestMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; Map<String, dynamic> get payload;
/// Create a copy of HistorySyncRequestMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistorySyncRequestMessageCopyWith<HistorySyncRequestMessage> get copyWith => _$HistorySyncRequestMessageCopyWithImpl<HistorySyncRequestMessage>(this as HistorySyncRequestMessage, _$identity);

  /// Serializes this HistorySyncRequestMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistorySyncRequestMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'HistorySyncRequestMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $HistorySyncRequestMessageCopyWith<$Res>  {
  factory $HistorySyncRequestMessageCopyWith(HistorySyncRequestMessage value, $Res Function(HistorySyncRequestMessage) _then) = _$HistorySyncRequestMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class _$HistorySyncRequestMessageCopyWithImpl<$Res>
    implements $HistorySyncRequestMessageCopyWith<$Res> {
  _$HistorySyncRequestMessageCopyWithImpl(this._self, this._then);

  final HistorySyncRequestMessage _self;
  final $Res Function(HistorySyncRequestMessage) _then;

/// Create a copy of HistorySyncRequestMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [HistorySyncRequestMessage].
extension HistorySyncRequestMessagePatterns on HistorySyncRequestMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistorySyncRequestMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistorySyncRequestMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistorySyncRequestMessage value)  $default,){
final _that = this;
switch (_that) {
case _HistorySyncRequestMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistorySyncRequestMessage value)?  $default,){
final _that = this;
switch (_that) {
case _HistorySyncRequestMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistorySyncRequestMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)  $default,) {final _that = this;
switch (_that) {
case _HistorySyncRequestMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,) {final _that = this;
switch (_that) {
case _HistorySyncRequestMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistorySyncRequestMessage implements HistorySyncRequestMessage {
  const _HistorySyncRequestMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, required final  Map<String, dynamic> payload}): _payload = payload;
  factory _HistorySyncRequestMessage.fromJson(Map<String, dynamic> json) => _$HistorySyncRequestMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of HistorySyncRequestMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistorySyncRequestMessageCopyWith<_HistorySyncRequestMessage> get copyWith => __$HistorySyncRequestMessageCopyWithImpl<_HistorySyncRequestMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistorySyncRequestMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistorySyncRequestMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'HistorySyncRequestMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$HistorySyncRequestMessageCopyWith<$Res> implements $HistorySyncRequestMessageCopyWith<$Res> {
  factory _$HistorySyncRequestMessageCopyWith(_HistorySyncRequestMessage value, $Res Function(_HistorySyncRequestMessage) _then) = __$HistorySyncRequestMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class __$HistorySyncRequestMessageCopyWithImpl<$Res>
    implements _$HistorySyncRequestMessageCopyWith<$Res> {
  __$HistorySyncRequestMessageCopyWithImpl(this._self, this._then);

  final _HistorySyncRequestMessage _self;
  final $Res Function(_HistorySyncRequestMessage) _then;

/// Create a copy of HistorySyncRequestMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_HistorySyncRequestMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$ClipboardUpdateReceivedMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; Map<String, dynamic> get payload;
/// Create a copy of ClipboardUpdateReceivedMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClipboardUpdateReceivedMessageCopyWith<ClipboardUpdateReceivedMessage> get copyWith => _$ClipboardUpdateReceivedMessageCopyWithImpl<ClipboardUpdateReceivedMessage>(this as ClipboardUpdateReceivedMessage, _$identity);

  /// Serializes this ClipboardUpdateReceivedMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClipboardUpdateReceivedMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'ClipboardUpdateReceivedMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $ClipboardUpdateReceivedMessageCopyWith<$Res>  {
  factory $ClipboardUpdateReceivedMessageCopyWith(ClipboardUpdateReceivedMessage value, $Res Function(ClipboardUpdateReceivedMessage) _then) = _$ClipboardUpdateReceivedMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class _$ClipboardUpdateReceivedMessageCopyWithImpl<$Res>
    implements $ClipboardUpdateReceivedMessageCopyWith<$Res> {
  _$ClipboardUpdateReceivedMessageCopyWithImpl(this._self, this._then);

  final ClipboardUpdateReceivedMessage _self;
  final $Res Function(ClipboardUpdateReceivedMessage) _then;

/// Create a copy of ClipboardUpdateReceivedMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ClipboardUpdateReceivedMessage].
extension ClipboardUpdateReceivedMessagePatterns on ClipboardUpdateReceivedMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClipboardUpdateReceivedMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClipboardUpdateReceivedMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClipboardUpdateReceivedMessage value)  $default,){
final _that = this;
switch (_that) {
case _ClipboardUpdateReceivedMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClipboardUpdateReceivedMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ClipboardUpdateReceivedMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClipboardUpdateReceivedMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)  $default,) {final _that = this;
switch (_that) {
case _ClipboardUpdateReceivedMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,) {final _that = this;
switch (_that) {
case _ClipboardUpdateReceivedMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClipboardUpdateReceivedMessage implements ClipboardUpdateReceivedMessage {
  const _ClipboardUpdateReceivedMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, final  Map<String, dynamic> payload = const {}}): _payload = payload;
  factory _ClipboardUpdateReceivedMessage.fromJson(Map<String, dynamic> json) => _$ClipboardUpdateReceivedMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
 final  Map<String, dynamic> _payload;
@override@JsonKey() Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of ClipboardUpdateReceivedMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClipboardUpdateReceivedMessageCopyWith<_ClipboardUpdateReceivedMessage> get copyWith => __$ClipboardUpdateReceivedMessageCopyWithImpl<_ClipboardUpdateReceivedMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClipboardUpdateReceivedMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClipboardUpdateReceivedMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'ClipboardUpdateReceivedMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$ClipboardUpdateReceivedMessageCopyWith<$Res> implements $ClipboardUpdateReceivedMessageCopyWith<$Res> {
  factory _$ClipboardUpdateReceivedMessageCopyWith(_ClipboardUpdateReceivedMessage value, $Res Function(_ClipboardUpdateReceivedMessage) _then) = __$ClipboardUpdateReceivedMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class __$ClipboardUpdateReceivedMessageCopyWithImpl<$Res>
    implements _$ClipboardUpdateReceivedMessageCopyWith<$Res> {
  __$ClipboardUpdateReceivedMessageCopyWithImpl(this._self, this._then);

  final _ClipboardUpdateReceivedMessage _self;
  final $Res Function(_ClipboardUpdateReceivedMessage) _then;

/// Create a copy of ClipboardUpdateReceivedMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_ClipboardUpdateReceivedMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$ClipboardUpdateRelayMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; ClipboardPayload get payload; String get sourceDeviceId;
/// Create a copy of ClipboardUpdateRelayMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClipboardUpdateRelayMessageCopyWith<ClipboardUpdateRelayMessage> get copyWith => _$ClipboardUpdateRelayMessageCopyWithImpl<ClipboardUpdateRelayMessage>(this as ClipboardUpdateRelayMessage, _$identity);

  /// Serializes this ClipboardUpdateRelayMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClipboardUpdateRelayMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.sourceDeviceId, sourceDeviceId) || other.sourceDeviceId == sourceDeviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,payload,sourceDeviceId);

@override
String toString() {
  return 'ClipboardUpdateRelayMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload, sourceDeviceId: $sourceDeviceId)';
}


}

/// @nodoc
abstract mixin class $ClipboardUpdateRelayMessageCopyWith<$Res>  {
  factory $ClipboardUpdateRelayMessageCopyWith(ClipboardUpdateRelayMessage value, $Res Function(ClipboardUpdateRelayMessage) _then) = _$ClipboardUpdateRelayMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, ClipboardPayload payload, String sourceDeviceId
});


$ClipboardPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class _$ClipboardUpdateRelayMessageCopyWithImpl<$Res>
    implements $ClipboardUpdateRelayMessageCopyWith<$Res> {
  _$ClipboardUpdateRelayMessageCopyWithImpl(this._self, this._then);

  final ClipboardUpdateRelayMessage _self;
  final $Res Function(ClipboardUpdateRelayMessage) _then;

/// Create a copy of ClipboardUpdateRelayMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,Object? sourceDeviceId = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as ClipboardPayload,sourceDeviceId: null == sourceDeviceId ? _self.sourceDeviceId : sourceDeviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ClipboardUpdateRelayMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClipboardPayloadCopyWith<$Res> get payload {
  
  return $ClipboardPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClipboardUpdateRelayMessage].
extension ClipboardUpdateRelayMessagePatterns on ClipboardUpdateRelayMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClipboardUpdateRelayMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClipboardUpdateRelayMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClipboardUpdateRelayMessage value)  $default,){
final _that = this;
switch (_that) {
case _ClipboardUpdateRelayMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClipboardUpdateRelayMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ClipboardUpdateRelayMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  ClipboardPayload payload,  String sourceDeviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClipboardUpdateRelayMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload,_that.sourceDeviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  ClipboardPayload payload,  String sourceDeviceId)  $default,) {final _that = this;
switch (_that) {
case _ClipboardUpdateRelayMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload,_that.sourceDeviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  ClipboardPayload payload,  String sourceDeviceId)?  $default,) {final _that = this;
switch (_that) {
case _ClipboardUpdateRelayMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload,_that.sourceDeviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClipboardUpdateRelayMessage implements ClipboardUpdateRelayMessage {
  const _ClipboardUpdateRelayMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, required this.payload, required this.sourceDeviceId});
  factory _ClipboardUpdateRelayMessage.fromJson(Map<String, dynamic> json) => _$ClipboardUpdateRelayMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
@override final  ClipboardPayload payload;
@override final  String sourceDeviceId;

/// Create a copy of ClipboardUpdateRelayMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClipboardUpdateRelayMessageCopyWith<_ClipboardUpdateRelayMessage> get copyWith => __$ClipboardUpdateRelayMessageCopyWithImpl<_ClipboardUpdateRelayMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClipboardUpdateRelayMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClipboardUpdateRelayMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.sourceDeviceId, sourceDeviceId) || other.sourceDeviceId == sourceDeviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,payload,sourceDeviceId);

@override
String toString() {
  return 'ClipboardUpdateRelayMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload, sourceDeviceId: $sourceDeviceId)';
}


}

/// @nodoc
abstract mixin class _$ClipboardUpdateRelayMessageCopyWith<$Res> implements $ClipboardUpdateRelayMessageCopyWith<$Res> {
  factory _$ClipboardUpdateRelayMessageCopyWith(_ClipboardUpdateRelayMessage value, $Res Function(_ClipboardUpdateRelayMessage) _then) = __$ClipboardUpdateRelayMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, ClipboardPayload payload, String sourceDeviceId
});


@override $ClipboardPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class __$ClipboardUpdateRelayMessageCopyWithImpl<$Res>
    implements _$ClipboardUpdateRelayMessageCopyWith<$Res> {
  __$ClipboardUpdateRelayMessageCopyWithImpl(this._self, this._then);

  final _ClipboardUpdateRelayMessage _self;
  final $Res Function(_ClipboardUpdateRelayMessage) _then;

/// Create a copy of ClipboardUpdateRelayMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,Object? sourceDeviceId = null,}) {
  return _then(_ClipboardUpdateRelayMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as ClipboardPayload,sourceDeviceId: null == sourceDeviceId ? _self.sourceDeviceId : sourceDeviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ClipboardUpdateRelayMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClipboardPayloadCopyWith<$Res> get payload {
  
  return $ClipboardPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}


/// @nodoc
mixin _$PongMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; Map<String, dynamic>? get payload;
/// Create a copy of PongMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PongMessageCopyWith<PongMessage> get copyWith => _$PongMessageCopyWithImpl<PongMessage>(this as PongMessage, _$identity);

  /// Serializes this PongMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PongMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'PongMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $PongMessageCopyWith<$Res>  {
  factory $PongMessageCopyWith(PongMessage value, $Res Function(PongMessage) _then) = _$PongMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic>? payload
});




}
/// @nodoc
class _$PongMessageCopyWithImpl<$Res>
    implements $PongMessageCopyWith<$Res> {
  _$PongMessageCopyWithImpl(this._self, this._then);

  final PongMessage _self;
  final $Res Function(PongMessage) _then;

/// Create a copy of PongMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PongMessage].
extension PongMessagePatterns on PongMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PongMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PongMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PongMessage value)  $default,){
final _that = this;
switch (_that) {
case _PongMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PongMessage value)?  $default,){
final _that = this;
switch (_that) {
case _PongMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic>? payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PongMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic>? payload)  $default,) {final _that = this;
switch (_that) {
case _PongMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic>? payload)?  $default,) {final _that = this;
switch (_that) {
case _PongMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PongMessage implements PongMessage {
  const _PongMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, final  Map<String, dynamic>? payload}): _payload = payload;
  factory _PongMessage.fromJson(Map<String, dynamic> json) => _$PongMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
 final  Map<String, dynamic>? _payload;
@override Map<String, dynamic>? get payload {
  final value = _payload;
  if (value == null) return null;
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PongMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PongMessageCopyWith<_PongMessage> get copyWith => __$PongMessageCopyWithImpl<_PongMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PongMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PongMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'PongMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$PongMessageCopyWith<$Res> implements $PongMessageCopyWith<$Res> {
  factory _$PongMessageCopyWith(_PongMessage value, $Res Function(_PongMessage) _then) = __$PongMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic>? payload
});




}
/// @nodoc
class __$PongMessageCopyWithImpl<$Res>
    implements _$PongMessageCopyWith<$Res> {
  __$PongMessageCopyWithImpl(this._self, this._then);

  final _PongMessage _self;
  final $Res Function(_PongMessage) _then;

/// Create a copy of PongMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = freezed,}) {
  return _then(_PongMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$ErrorMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; Map<String, dynamic> get payload;
/// Create a copy of ErrorMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorMessageCopyWith<ErrorMessage> get copyWith => _$ErrorMessageCopyWithImpl<ErrorMessage>(this as ErrorMessage, _$identity);

  /// Serializes this ErrorMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'ErrorMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $ErrorMessageCopyWith<$Res>  {
  factory $ErrorMessageCopyWith(ErrorMessage value, $Res Function(ErrorMessage) _then) = _$ErrorMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class _$ErrorMessageCopyWithImpl<$Res>
    implements $ErrorMessageCopyWith<$Res> {
  _$ErrorMessageCopyWithImpl(this._self, this._then);

  final ErrorMessage _self;
  final $Res Function(ErrorMessage) _then;

/// Create a copy of ErrorMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ErrorMessage].
extension ErrorMessagePatterns on ErrorMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErrorMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErrorMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErrorMessage value)  $default,){
final _that = this;
switch (_that) {
case _ErrorMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErrorMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ErrorMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErrorMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)  $default,) {final _that = this;
switch (_that) {
case _ErrorMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,) {final _that = this;
switch (_that) {
case _ErrorMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ErrorMessage implements ErrorMessage {
  const _ErrorMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, required final  Map<String, dynamic> payload}): _payload = payload;
  factory _ErrorMessage.fromJson(Map<String, dynamic> json) => _$ErrorMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of ErrorMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorMessageCopyWith<_ErrorMessage> get copyWith => __$ErrorMessageCopyWithImpl<_ErrorMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'ErrorMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$ErrorMessageCopyWith<$Res> implements $ErrorMessageCopyWith<$Res> {
  factory _$ErrorMessageCopyWith(_ErrorMessage value, $Res Function(_ErrorMessage) _then) = __$ErrorMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class __$ErrorMessageCopyWithImpl<$Res>
    implements _$ErrorMessageCopyWith<$Res> {
  __$ErrorMessageCopyWithImpl(this._self, this._then);

  final _ErrorMessage _self;
  final $Res Function(_ErrorMessage) _then;

/// Create a copy of ErrorMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_ErrorMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$AckMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; Map<String, dynamic> get payload;
/// Create a copy of AckMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AckMessageCopyWith<AckMessage> get copyWith => _$AckMessageCopyWithImpl<AckMessage>(this as AckMessage, _$identity);

  /// Serializes this AckMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AckMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'AckMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $AckMessageCopyWith<$Res>  {
  factory $AckMessageCopyWith(AckMessage value, $Res Function(AckMessage) _then) = _$AckMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class _$AckMessageCopyWithImpl<$Res>
    implements $AckMessageCopyWith<$Res> {
  _$AckMessageCopyWithImpl(this._self, this._then);

  final AckMessage _self;
  final $Res Function(AckMessage) _then;

/// Create a copy of AckMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [AckMessage].
extension AckMessagePatterns on AckMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AckMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AckMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AckMessage value)  $default,){
final _that = this;
switch (_that) {
case _AckMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AckMessage value)?  $default,){
final _that = this;
switch (_that) {
case _AckMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AckMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)  $default,) {final _that = this;
switch (_that) {
case _AckMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,) {final _that = this;
switch (_that) {
case _AckMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AckMessage implements AckMessage {
  const _AckMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, required final  Map<String, dynamic> payload}): _payload = payload;
  factory _AckMessage.fromJson(Map<String, dynamic> json) => _$AckMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of AckMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AckMessageCopyWith<_AckMessage> get copyWith => __$AckMessageCopyWithImpl<_AckMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AckMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AckMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'AckMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$AckMessageCopyWith<$Res> implements $AckMessageCopyWith<$Res> {
  factory _$AckMessageCopyWith(_AckMessage value, $Res Function(_AckMessage) _then) = __$AckMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class __$AckMessageCopyWithImpl<$Res>
    implements _$AckMessageCopyWith<$Res> {
  __$AckMessageCopyWithImpl(this._self, this._then);

  final _AckMessage _self;
  final $Res Function(_AckMessage) _then;

/// Create a copy of AckMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_AckMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$HistorySyncResponseMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; Map<String, dynamic> get payload;
/// Create a copy of HistorySyncResponseMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistorySyncResponseMessageCopyWith<HistorySyncResponseMessage> get copyWith => _$HistorySyncResponseMessageCopyWithImpl<HistorySyncResponseMessage>(this as HistorySyncResponseMessage, _$identity);

  /// Serializes this HistorySyncResponseMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistorySyncResponseMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'HistorySyncResponseMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $HistorySyncResponseMessageCopyWith<$Res>  {
  factory $HistorySyncResponseMessageCopyWith(HistorySyncResponseMessage value, $Res Function(HistorySyncResponseMessage) _then) = _$HistorySyncResponseMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class _$HistorySyncResponseMessageCopyWithImpl<$Res>
    implements $HistorySyncResponseMessageCopyWith<$Res> {
  _$HistorySyncResponseMessageCopyWithImpl(this._self, this._then);

  final HistorySyncResponseMessage _self;
  final $Res Function(HistorySyncResponseMessage) _then;

/// Create a copy of HistorySyncResponseMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [HistorySyncResponseMessage].
extension HistorySyncResponseMessagePatterns on HistorySyncResponseMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistorySyncResponseMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistorySyncResponseMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistorySyncResponseMessage value)  $default,){
final _that = this;
switch (_that) {
case _HistorySyncResponseMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistorySyncResponseMessage value)?  $default,){
final _that = this;
switch (_that) {
case _HistorySyncResponseMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistorySyncResponseMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)  $default,) {final _that = this;
switch (_that) {
case _HistorySyncResponseMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,) {final _that = this;
switch (_that) {
case _HistorySyncResponseMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistorySyncResponseMessage implements HistorySyncResponseMessage {
  const _HistorySyncResponseMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, required final  Map<String, dynamic> payload}): _payload = payload;
  factory _HistorySyncResponseMessage.fromJson(Map<String, dynamic> json) => _$HistorySyncResponseMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of HistorySyncResponseMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistorySyncResponseMessageCopyWith<_HistorySyncResponseMessage> get copyWith => __$HistorySyncResponseMessageCopyWithImpl<_HistorySyncResponseMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistorySyncResponseMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistorySyncResponseMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'HistorySyncResponseMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$HistorySyncResponseMessageCopyWith<$Res> implements $HistorySyncResponseMessageCopyWith<$Res> {
  factory _$HistorySyncResponseMessageCopyWith(_HistorySyncResponseMessage value, $Res Function(_HistorySyncResponseMessage) _then) = __$HistorySyncResponseMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class __$HistorySyncResponseMessageCopyWithImpl<$Res>
    implements _$HistorySyncResponseMessageCopyWith<$Res> {
  __$HistorySyncResponseMessageCopyWithImpl(this._self, this._then);

  final _HistorySyncResponseMessage _self;
  final $Res Function(_HistorySyncResponseMessage) _then;

/// Create a copy of HistorySyncResponseMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_HistorySyncResponseMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$DeviceOnlineMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; Map<String, dynamic> get payload;
/// Create a copy of DeviceOnlineMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceOnlineMessageCopyWith<DeviceOnlineMessage> get copyWith => _$DeviceOnlineMessageCopyWithImpl<DeviceOnlineMessage>(this as DeviceOnlineMessage, _$identity);

  /// Serializes this DeviceOnlineMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceOnlineMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'DeviceOnlineMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $DeviceOnlineMessageCopyWith<$Res>  {
  factory $DeviceOnlineMessageCopyWith(DeviceOnlineMessage value, $Res Function(DeviceOnlineMessage) _then) = _$DeviceOnlineMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class _$DeviceOnlineMessageCopyWithImpl<$Res>
    implements $DeviceOnlineMessageCopyWith<$Res> {
  _$DeviceOnlineMessageCopyWithImpl(this._self, this._then);

  final DeviceOnlineMessage _self;
  final $Res Function(DeviceOnlineMessage) _then;

/// Create a copy of DeviceOnlineMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceOnlineMessage].
extension DeviceOnlineMessagePatterns on DeviceOnlineMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceOnlineMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceOnlineMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceOnlineMessage value)  $default,){
final _that = this;
switch (_that) {
case _DeviceOnlineMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceOnlineMessage value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceOnlineMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceOnlineMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)  $default,) {final _that = this;
switch (_that) {
case _DeviceOnlineMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,) {final _that = this;
switch (_that) {
case _DeviceOnlineMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceOnlineMessage implements DeviceOnlineMessage {
  const _DeviceOnlineMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, required final  Map<String, dynamic> payload}): _payload = payload;
  factory _DeviceOnlineMessage.fromJson(Map<String, dynamic> json) => _$DeviceOnlineMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of DeviceOnlineMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceOnlineMessageCopyWith<_DeviceOnlineMessage> get copyWith => __$DeviceOnlineMessageCopyWithImpl<_DeviceOnlineMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceOnlineMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceOnlineMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'DeviceOnlineMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$DeviceOnlineMessageCopyWith<$Res> implements $DeviceOnlineMessageCopyWith<$Res> {
  factory _$DeviceOnlineMessageCopyWith(_DeviceOnlineMessage value, $Res Function(_DeviceOnlineMessage) _then) = __$DeviceOnlineMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class __$DeviceOnlineMessageCopyWithImpl<$Res>
    implements _$DeviceOnlineMessageCopyWith<$Res> {
  __$DeviceOnlineMessageCopyWithImpl(this._self, this._then);

  final _DeviceOnlineMessage _self;
  final $Res Function(_DeviceOnlineMessage) _then;

/// Create a copy of DeviceOnlineMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_DeviceOnlineMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$DeviceOfflineMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp; Map<String, dynamic> get payload;
/// Create a copy of DeviceOfflineMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceOfflineMessageCopyWith<DeviceOfflineMessage> get copyWith => _$DeviceOfflineMessageCopyWithImpl<DeviceOfflineMessage>(this as DeviceOfflineMessage, _$identity);

  /// Serializes this DeviceOfflineMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceOfflineMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'DeviceOfflineMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $DeviceOfflineMessageCopyWith<$Res>  {
  factory $DeviceOfflineMessageCopyWith(DeviceOfflineMessage value, $Res Function(DeviceOfflineMessage) _then) = _$DeviceOfflineMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class _$DeviceOfflineMessageCopyWithImpl<$Res>
    implements $DeviceOfflineMessageCopyWith<$Res> {
  _$DeviceOfflineMessageCopyWithImpl(this._self, this._then);

  final DeviceOfflineMessage _self;
  final $Res Function(DeviceOfflineMessage) _then;

/// Create a copy of DeviceOfflineMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceOfflineMessage].
extension DeviceOfflineMessagePatterns on DeviceOfflineMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceOfflineMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceOfflineMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceOfflineMessage value)  $default,){
final _that = this;
switch (_that) {
case _DeviceOfflineMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceOfflineMessage value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceOfflineMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceOfflineMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)  $default,) {final _that = this;
switch (_that) {
case _DeviceOfflineMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp,  Map<String, dynamic> payload)?  $default,) {final _that = this;
switch (_that) {
case _DeviceOfflineMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceOfflineMessage implements DeviceOfflineMessage {
  const _DeviceOfflineMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp, required final  Map<String, dynamic> payload}): _payload = payload;
  factory _DeviceOfflineMessage.fromJson(Map<String, dynamic> json) => _$DeviceOfflineMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of DeviceOfflineMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceOfflineMessageCopyWith<_DeviceOfflineMessage> get copyWith => __$DeviceOfflineMessageCopyWithImpl<_DeviceOfflineMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceOfflineMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceOfflineMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'DeviceOfflineMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$DeviceOfflineMessageCopyWith<$Res> implements $DeviceOfflineMessageCopyWith<$Res> {
  factory _$DeviceOfflineMessageCopyWith(_DeviceOfflineMessage value, $Res Function(_DeviceOfflineMessage) _then) = __$DeviceOfflineMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp, Map<String, dynamic> payload
});




}
/// @nodoc
class __$DeviceOfflineMessageCopyWithImpl<$Res>
    implements _$DeviceOfflineMessageCopyWith<$Res> {
  __$DeviceOfflineMessageCopyWithImpl(this._self, this._then);

  final _DeviceOfflineMessage _self;
  final $Res Function(_DeviceOfflineMessage) _then;

/// Create a copy of DeviceOfflineMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,Object? payload = null,}) {
  return _then(_DeviceOfflineMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$AuthSuccessMessage {

 SyncMessageType get type; int get version; String get messageId; String get deviceId; String get timestamp;
/// Create a copy of AuthSuccessMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSuccessMessageCopyWith<AuthSuccessMessage> get copyWith => _$AuthSuccessMessageCopyWithImpl<AuthSuccessMessage>(this as AuthSuccessMessage, _$identity);

  /// Serializes this AuthSuccessMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSuccessMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp);

@override
String toString() {
  return 'AuthSuccessMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $AuthSuccessMessageCopyWith<$Res>  {
  factory $AuthSuccessMessageCopyWith(AuthSuccessMessage value, $Res Function(AuthSuccessMessage) _then) = _$AuthSuccessMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp
});




}
/// @nodoc
class _$AuthSuccessMessageCopyWithImpl<$Res>
    implements $AuthSuccessMessageCopyWith<$Res> {
  _$AuthSuccessMessageCopyWithImpl(this._self, this._then);

  final AuthSuccessMessage _self;
  final $Res Function(AuthSuccessMessage) _then;

/// Create a copy of AuthSuccessMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthSuccessMessage].
extension AuthSuccessMessagePatterns on AuthSuccessMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthSuccessMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthSuccessMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthSuccessMessage value)  $default,){
final _that = this;
switch (_that) {
case _AuthSuccessMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthSuccessMessage value)?  $default,){
final _that = this;
switch (_that) {
case _AuthSuccessMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthSuccessMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp)  $default,) {final _that = this;
switch (_that) {
case _AuthSuccessMessage():
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  int version,  String messageId,  String deviceId,  String timestamp)?  $default,) {final _that = this;
switch (_that) {
case _AuthSuccessMessage() when $default != null:
return $default(_that.type,_that.version,_that.messageId,_that.deviceId,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthSuccessMessage implements AuthSuccessMessage {
  const _AuthSuccessMessage({required this.type, this.version = 1, required this.messageId, required this.deviceId, required this.timestamp});
  factory _AuthSuccessMessage.fromJson(Map<String, dynamic> json) => _$AuthSuccessMessageFromJson(json);

@override final  SyncMessageType type;
@override@JsonKey() final  int version;
@override final  String messageId;
@override final  String deviceId;
@override final  String timestamp;

/// Create a copy of AuthSuccessMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthSuccessMessageCopyWith<_AuthSuccessMessage> get copyWith => __$AuthSuccessMessageCopyWithImpl<_AuthSuccessMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthSuccessMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSuccessMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,messageId,deviceId,timestamp);

@override
String toString() {
  return 'AuthSuccessMessage(type: $type, version: $version, messageId: $messageId, deviceId: $deviceId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$AuthSuccessMessageCopyWith<$Res> implements $AuthSuccessMessageCopyWith<$Res> {
  factory _$AuthSuccessMessageCopyWith(_AuthSuccessMessage value, $Res Function(_AuthSuccessMessage) _then) = __$AuthSuccessMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, int version, String messageId, String deviceId, String timestamp
});




}
/// @nodoc
class __$AuthSuccessMessageCopyWithImpl<$Res>
    implements _$AuthSuccessMessageCopyWith<$Res> {
  __$AuthSuccessMessageCopyWithImpl(this._self, this._then);

  final _AuthSuccessMessage _self;
  final $Res Function(_AuthSuccessMessage) _then;

/// Create a copy of AuthSuccessMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? messageId = null,Object? deviceId = null,Object? timestamp = null,}) {
  return _then(_AuthSuccessMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ClientMessage {

 Object get message;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientMessage&&const DeepCollectionEquality().equals(other.message, message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(message));

@override
String toString() {
  return 'ClientMessage(message: $message)';
}


}

/// @nodoc
class $ClientMessageCopyWith<$Res>  {
$ClientMessageCopyWith(ClientMessage _, $Res Function(ClientMessage) __);
}


/// Adds pattern-matching-related methods to [ClientMessage].
extension ClientMessagePatterns on ClientMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ClientMessageClipboardUpdate value)?  clipboardUpdate,TResult Function( ClientMessagePing value)?  ping,TResult Function( ClientMessageDeliveryReceipt value)?  deliveryReceipt,TResult Function( ClientMessageHistorySyncRequest value)?  historySyncRequest,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ClientMessageClipboardUpdate() when clipboardUpdate != null:
return clipboardUpdate(_that);case ClientMessagePing() when ping != null:
return ping(_that);case ClientMessageDeliveryReceipt() when deliveryReceipt != null:
return deliveryReceipt(_that);case ClientMessageHistorySyncRequest() when historySyncRequest != null:
return historySyncRequest(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ClientMessageClipboardUpdate value)  clipboardUpdate,required TResult Function( ClientMessagePing value)  ping,required TResult Function( ClientMessageDeliveryReceipt value)  deliveryReceipt,required TResult Function( ClientMessageHistorySyncRequest value)  historySyncRequest,}){
final _that = this;
switch (_that) {
case ClientMessageClipboardUpdate():
return clipboardUpdate(_that);case ClientMessagePing():
return ping(_that);case ClientMessageDeliveryReceipt():
return deliveryReceipt(_that);case ClientMessageHistorySyncRequest():
return historySyncRequest(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ClientMessageClipboardUpdate value)?  clipboardUpdate,TResult? Function( ClientMessagePing value)?  ping,TResult? Function( ClientMessageDeliveryReceipt value)?  deliveryReceipt,TResult? Function( ClientMessageHistorySyncRequest value)?  historySyncRequest,}){
final _that = this;
switch (_that) {
case ClientMessageClipboardUpdate() when clipboardUpdate != null:
return clipboardUpdate(_that);case ClientMessagePing() when ping != null:
return ping(_that);case ClientMessageDeliveryReceipt() when deliveryReceipt != null:
return deliveryReceipt(_that);case ClientMessageHistorySyncRequest() when historySyncRequest != null:
return historySyncRequest(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ClipboardUpdateMessage message)?  clipboardUpdate,TResult Function( PingMessage message)?  ping,TResult Function( DeliveryReceiptMessage message)?  deliveryReceipt,TResult Function( HistorySyncRequestMessage message)?  historySyncRequest,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ClientMessageClipboardUpdate() when clipboardUpdate != null:
return clipboardUpdate(_that.message);case ClientMessagePing() when ping != null:
return ping(_that.message);case ClientMessageDeliveryReceipt() when deliveryReceipt != null:
return deliveryReceipt(_that.message);case ClientMessageHistorySyncRequest() when historySyncRequest != null:
return historySyncRequest(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ClipboardUpdateMessage message)  clipboardUpdate,required TResult Function( PingMessage message)  ping,required TResult Function( DeliveryReceiptMessage message)  deliveryReceipt,required TResult Function( HistorySyncRequestMessage message)  historySyncRequest,}) {final _that = this;
switch (_that) {
case ClientMessageClipboardUpdate():
return clipboardUpdate(_that.message);case ClientMessagePing():
return ping(_that.message);case ClientMessageDeliveryReceipt():
return deliveryReceipt(_that.message);case ClientMessageHistorySyncRequest():
return historySyncRequest(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ClipboardUpdateMessage message)?  clipboardUpdate,TResult? Function( PingMessage message)?  ping,TResult? Function( DeliveryReceiptMessage message)?  deliveryReceipt,TResult? Function( HistorySyncRequestMessage message)?  historySyncRequest,}) {final _that = this;
switch (_that) {
case ClientMessageClipboardUpdate() when clipboardUpdate != null:
return clipboardUpdate(_that.message);case ClientMessagePing() when ping != null:
return ping(_that.message);case ClientMessageDeliveryReceipt() when deliveryReceipt != null:
return deliveryReceipt(_that.message);case ClientMessageHistorySyncRequest() when historySyncRequest != null:
return historySyncRequest(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ClientMessageClipboardUpdate implements ClientMessage {
  const ClientMessageClipboardUpdate(this.message);
  

@override final  ClipboardUpdateMessage message;

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientMessageClipboardUpdateCopyWith<ClientMessageClipboardUpdate> get copyWith => _$ClientMessageClipboardUpdateCopyWithImpl<ClientMessageClipboardUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientMessageClipboardUpdate&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ClientMessage.clipboardUpdate(message: $message)';
}


}

/// @nodoc
abstract mixin class $ClientMessageClipboardUpdateCopyWith<$Res> implements $ClientMessageCopyWith<$Res> {
  factory $ClientMessageClipboardUpdateCopyWith(ClientMessageClipboardUpdate value, $Res Function(ClientMessageClipboardUpdate) _then) = _$ClientMessageClipboardUpdateCopyWithImpl;
@useResult
$Res call({
 ClipboardUpdateMessage message
});


$ClipboardUpdateMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ClientMessageClipboardUpdateCopyWithImpl<$Res>
    implements $ClientMessageClipboardUpdateCopyWith<$Res> {
  _$ClientMessageClipboardUpdateCopyWithImpl(this._self, this._then);

  final ClientMessageClipboardUpdate _self;
  final $Res Function(ClientMessageClipboardUpdate) _then;

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ClientMessageClipboardUpdate(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ClipboardUpdateMessage,
  ));
}

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClipboardUpdateMessageCopyWith<$Res> get message {
  
  return $ClipboardUpdateMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ClientMessagePing implements ClientMessage {
  const ClientMessagePing(this.message);
  

@override final  PingMessage message;

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientMessagePingCopyWith<ClientMessagePing> get copyWith => _$ClientMessagePingCopyWithImpl<ClientMessagePing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientMessagePing&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ClientMessage.ping(message: $message)';
}


}

/// @nodoc
abstract mixin class $ClientMessagePingCopyWith<$Res> implements $ClientMessageCopyWith<$Res> {
  factory $ClientMessagePingCopyWith(ClientMessagePing value, $Res Function(ClientMessagePing) _then) = _$ClientMessagePingCopyWithImpl;
@useResult
$Res call({
 PingMessage message
});


$PingMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ClientMessagePingCopyWithImpl<$Res>
    implements $ClientMessagePingCopyWith<$Res> {
  _$ClientMessagePingCopyWithImpl(this._self, this._then);

  final ClientMessagePing _self;
  final $Res Function(ClientMessagePing) _then;

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ClientMessagePing(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as PingMessage,
  ));
}

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PingMessageCopyWith<$Res> get message {
  
  return $PingMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ClientMessageDeliveryReceipt implements ClientMessage {
  const ClientMessageDeliveryReceipt(this.message);
  

@override final  DeliveryReceiptMessage message;

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientMessageDeliveryReceiptCopyWith<ClientMessageDeliveryReceipt> get copyWith => _$ClientMessageDeliveryReceiptCopyWithImpl<ClientMessageDeliveryReceipt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientMessageDeliveryReceipt&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ClientMessage.deliveryReceipt(message: $message)';
}


}

/// @nodoc
abstract mixin class $ClientMessageDeliveryReceiptCopyWith<$Res> implements $ClientMessageCopyWith<$Res> {
  factory $ClientMessageDeliveryReceiptCopyWith(ClientMessageDeliveryReceipt value, $Res Function(ClientMessageDeliveryReceipt) _then) = _$ClientMessageDeliveryReceiptCopyWithImpl;
@useResult
$Res call({
 DeliveryReceiptMessage message
});


$DeliveryReceiptMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ClientMessageDeliveryReceiptCopyWithImpl<$Res>
    implements $ClientMessageDeliveryReceiptCopyWith<$Res> {
  _$ClientMessageDeliveryReceiptCopyWithImpl(this._self, this._then);

  final ClientMessageDeliveryReceipt _self;
  final $Res Function(ClientMessageDeliveryReceipt) _then;

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ClientMessageDeliveryReceipt(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as DeliveryReceiptMessage,
  ));
}

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeliveryReceiptMessageCopyWith<$Res> get message {
  
  return $DeliveryReceiptMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ClientMessageHistorySyncRequest implements ClientMessage {
  const ClientMessageHistorySyncRequest(this.message);
  

@override final  HistorySyncRequestMessage message;

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientMessageHistorySyncRequestCopyWith<ClientMessageHistorySyncRequest> get copyWith => _$ClientMessageHistorySyncRequestCopyWithImpl<ClientMessageHistorySyncRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientMessageHistorySyncRequest&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ClientMessage.historySyncRequest(message: $message)';
}


}

/// @nodoc
abstract mixin class $ClientMessageHistorySyncRequestCopyWith<$Res> implements $ClientMessageCopyWith<$Res> {
  factory $ClientMessageHistorySyncRequestCopyWith(ClientMessageHistorySyncRequest value, $Res Function(ClientMessageHistorySyncRequest) _then) = _$ClientMessageHistorySyncRequestCopyWithImpl;
@useResult
$Res call({
 HistorySyncRequestMessage message
});


$HistorySyncRequestMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ClientMessageHistorySyncRequestCopyWithImpl<$Res>
    implements $ClientMessageHistorySyncRequestCopyWith<$Res> {
  _$ClientMessageHistorySyncRequestCopyWithImpl(this._self, this._then);

  final ClientMessageHistorySyncRequest _self;
  final $Res Function(ClientMessageHistorySyncRequest) _then;

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ClientMessageHistorySyncRequest(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as HistorySyncRequestMessage,
  ));
}

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistorySyncRequestMessageCopyWith<$Res> get message {
  
  return $HistorySyncRequestMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc
mixin _$ServerMessage {

 Object get message;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMessage&&const DeepCollectionEquality().equals(other.message, message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(message));

@override
String toString() {
  return 'ServerMessage(message: $message)';
}


}

/// @nodoc
class $ServerMessageCopyWith<$Res>  {
$ServerMessageCopyWith(ServerMessage _, $Res Function(ServerMessage) __);
}


/// Adds pattern-matching-related methods to [ServerMessage].
extension ServerMessagePatterns on ServerMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServerMessageClipboardUpdateReceived value)?  clipboardUpdateReceived,TResult Function( ServerMessageClipboardUpdateRelay value)?  clipboardUpdateRelay,TResult Function( ServerMessagePong value)?  pong,TResult Function( ServerMessageError value)?  error,TResult Function( ServerMessageAck value)?  ack,TResult Function( ServerMessageHistorySyncResponse value)?  historySyncResponse,TResult Function( ServerMessageDeviceOnline value)?  deviceOnline,TResult Function( ServerMessageDeviceOffline value)?  deviceOffline,TResult Function( ServerMessageAuthSuccess value)?  authSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServerMessageClipboardUpdateReceived() when clipboardUpdateReceived != null:
return clipboardUpdateReceived(_that);case ServerMessageClipboardUpdateRelay() when clipboardUpdateRelay != null:
return clipboardUpdateRelay(_that);case ServerMessagePong() when pong != null:
return pong(_that);case ServerMessageError() when error != null:
return error(_that);case ServerMessageAck() when ack != null:
return ack(_that);case ServerMessageHistorySyncResponse() when historySyncResponse != null:
return historySyncResponse(_that);case ServerMessageDeviceOnline() when deviceOnline != null:
return deviceOnline(_that);case ServerMessageDeviceOffline() when deviceOffline != null:
return deviceOffline(_that);case ServerMessageAuthSuccess() when authSuccess != null:
return authSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServerMessageClipboardUpdateReceived value)  clipboardUpdateReceived,required TResult Function( ServerMessageClipboardUpdateRelay value)  clipboardUpdateRelay,required TResult Function( ServerMessagePong value)  pong,required TResult Function( ServerMessageError value)  error,required TResult Function( ServerMessageAck value)  ack,required TResult Function( ServerMessageHistorySyncResponse value)  historySyncResponse,required TResult Function( ServerMessageDeviceOnline value)  deviceOnline,required TResult Function( ServerMessageDeviceOffline value)  deviceOffline,required TResult Function( ServerMessageAuthSuccess value)  authSuccess,}){
final _that = this;
switch (_that) {
case ServerMessageClipboardUpdateReceived():
return clipboardUpdateReceived(_that);case ServerMessageClipboardUpdateRelay():
return clipboardUpdateRelay(_that);case ServerMessagePong():
return pong(_that);case ServerMessageError():
return error(_that);case ServerMessageAck():
return ack(_that);case ServerMessageHistorySyncResponse():
return historySyncResponse(_that);case ServerMessageDeviceOnline():
return deviceOnline(_that);case ServerMessageDeviceOffline():
return deviceOffline(_that);case ServerMessageAuthSuccess():
return authSuccess(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServerMessageClipboardUpdateReceived value)?  clipboardUpdateReceived,TResult? Function( ServerMessageClipboardUpdateRelay value)?  clipboardUpdateRelay,TResult? Function( ServerMessagePong value)?  pong,TResult? Function( ServerMessageError value)?  error,TResult? Function( ServerMessageAck value)?  ack,TResult? Function( ServerMessageHistorySyncResponse value)?  historySyncResponse,TResult? Function( ServerMessageDeviceOnline value)?  deviceOnline,TResult? Function( ServerMessageDeviceOffline value)?  deviceOffline,TResult? Function( ServerMessageAuthSuccess value)?  authSuccess,}){
final _that = this;
switch (_that) {
case ServerMessageClipboardUpdateReceived() when clipboardUpdateReceived != null:
return clipboardUpdateReceived(_that);case ServerMessageClipboardUpdateRelay() when clipboardUpdateRelay != null:
return clipboardUpdateRelay(_that);case ServerMessagePong() when pong != null:
return pong(_that);case ServerMessageError() when error != null:
return error(_that);case ServerMessageAck() when ack != null:
return ack(_that);case ServerMessageHistorySyncResponse() when historySyncResponse != null:
return historySyncResponse(_that);case ServerMessageDeviceOnline() when deviceOnline != null:
return deviceOnline(_that);case ServerMessageDeviceOffline() when deviceOffline != null:
return deviceOffline(_that);case ServerMessageAuthSuccess() when authSuccess != null:
return authSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ClipboardUpdateReceivedMessage message)?  clipboardUpdateReceived,TResult Function( ClipboardUpdateRelayMessage message)?  clipboardUpdateRelay,TResult Function( PongMessage message)?  pong,TResult Function( ErrorMessage message)?  error,TResult Function( AckMessage message)?  ack,TResult Function( HistorySyncResponseMessage message)?  historySyncResponse,TResult Function( DeviceOnlineMessage message)?  deviceOnline,TResult Function( DeviceOfflineMessage message)?  deviceOffline,TResult Function( AuthSuccessMessage message)?  authSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServerMessageClipboardUpdateReceived() when clipboardUpdateReceived != null:
return clipboardUpdateReceived(_that.message);case ServerMessageClipboardUpdateRelay() when clipboardUpdateRelay != null:
return clipboardUpdateRelay(_that.message);case ServerMessagePong() when pong != null:
return pong(_that.message);case ServerMessageError() when error != null:
return error(_that.message);case ServerMessageAck() when ack != null:
return ack(_that.message);case ServerMessageHistorySyncResponse() when historySyncResponse != null:
return historySyncResponse(_that.message);case ServerMessageDeviceOnline() when deviceOnline != null:
return deviceOnline(_that.message);case ServerMessageDeviceOffline() when deviceOffline != null:
return deviceOffline(_that.message);case ServerMessageAuthSuccess() when authSuccess != null:
return authSuccess(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ClipboardUpdateReceivedMessage message)  clipboardUpdateReceived,required TResult Function( ClipboardUpdateRelayMessage message)  clipboardUpdateRelay,required TResult Function( PongMessage message)  pong,required TResult Function( ErrorMessage message)  error,required TResult Function( AckMessage message)  ack,required TResult Function( HistorySyncResponseMessage message)  historySyncResponse,required TResult Function( DeviceOnlineMessage message)  deviceOnline,required TResult Function( DeviceOfflineMessage message)  deviceOffline,required TResult Function( AuthSuccessMessage message)  authSuccess,}) {final _that = this;
switch (_that) {
case ServerMessageClipboardUpdateReceived():
return clipboardUpdateReceived(_that.message);case ServerMessageClipboardUpdateRelay():
return clipboardUpdateRelay(_that.message);case ServerMessagePong():
return pong(_that.message);case ServerMessageError():
return error(_that.message);case ServerMessageAck():
return ack(_that.message);case ServerMessageHistorySyncResponse():
return historySyncResponse(_that.message);case ServerMessageDeviceOnline():
return deviceOnline(_that.message);case ServerMessageDeviceOffline():
return deviceOffline(_that.message);case ServerMessageAuthSuccess():
return authSuccess(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ClipboardUpdateReceivedMessage message)?  clipboardUpdateReceived,TResult? Function( ClipboardUpdateRelayMessage message)?  clipboardUpdateRelay,TResult? Function( PongMessage message)?  pong,TResult? Function( ErrorMessage message)?  error,TResult? Function( AckMessage message)?  ack,TResult? Function( HistorySyncResponseMessage message)?  historySyncResponse,TResult? Function( DeviceOnlineMessage message)?  deviceOnline,TResult? Function( DeviceOfflineMessage message)?  deviceOffline,TResult? Function( AuthSuccessMessage message)?  authSuccess,}) {final _that = this;
switch (_that) {
case ServerMessageClipboardUpdateReceived() when clipboardUpdateReceived != null:
return clipboardUpdateReceived(_that.message);case ServerMessageClipboardUpdateRelay() when clipboardUpdateRelay != null:
return clipboardUpdateRelay(_that.message);case ServerMessagePong() when pong != null:
return pong(_that.message);case ServerMessageError() when error != null:
return error(_that.message);case ServerMessageAck() when ack != null:
return ack(_that.message);case ServerMessageHistorySyncResponse() when historySyncResponse != null:
return historySyncResponse(_that.message);case ServerMessageDeviceOnline() when deviceOnline != null:
return deviceOnline(_that.message);case ServerMessageDeviceOffline() when deviceOffline != null:
return deviceOffline(_that.message);case ServerMessageAuthSuccess() when authSuccess != null:
return authSuccess(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ServerMessageClipboardUpdateReceived implements ServerMessage {
  const ServerMessageClipboardUpdateReceived(this.message);
  

@override final  ClipboardUpdateReceivedMessage message;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerMessageClipboardUpdateReceivedCopyWith<ServerMessageClipboardUpdateReceived> get copyWith => _$ServerMessageClipboardUpdateReceivedCopyWithImpl<ServerMessageClipboardUpdateReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMessageClipboardUpdateReceived&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ServerMessage.clipboardUpdateReceived(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerMessageClipboardUpdateReceivedCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerMessageClipboardUpdateReceivedCopyWith(ServerMessageClipboardUpdateReceived value, $Res Function(ServerMessageClipboardUpdateReceived) _then) = _$ServerMessageClipboardUpdateReceivedCopyWithImpl;
@useResult
$Res call({
 ClipboardUpdateReceivedMessage message
});


$ClipboardUpdateReceivedMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ServerMessageClipboardUpdateReceivedCopyWithImpl<$Res>
    implements $ServerMessageClipboardUpdateReceivedCopyWith<$Res> {
  _$ServerMessageClipboardUpdateReceivedCopyWithImpl(this._self, this._then);

  final ServerMessageClipboardUpdateReceived _self;
  final $Res Function(ServerMessageClipboardUpdateReceived) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerMessageClipboardUpdateReceived(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ClipboardUpdateReceivedMessage,
  ));
}

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClipboardUpdateReceivedMessageCopyWith<$Res> get message {
  
  return $ClipboardUpdateReceivedMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ServerMessageClipboardUpdateRelay implements ServerMessage {
  const ServerMessageClipboardUpdateRelay(this.message);
  

@override final  ClipboardUpdateRelayMessage message;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerMessageClipboardUpdateRelayCopyWith<ServerMessageClipboardUpdateRelay> get copyWith => _$ServerMessageClipboardUpdateRelayCopyWithImpl<ServerMessageClipboardUpdateRelay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMessageClipboardUpdateRelay&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ServerMessage.clipboardUpdateRelay(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerMessageClipboardUpdateRelayCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerMessageClipboardUpdateRelayCopyWith(ServerMessageClipboardUpdateRelay value, $Res Function(ServerMessageClipboardUpdateRelay) _then) = _$ServerMessageClipboardUpdateRelayCopyWithImpl;
@useResult
$Res call({
 ClipboardUpdateRelayMessage message
});


$ClipboardUpdateRelayMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ServerMessageClipboardUpdateRelayCopyWithImpl<$Res>
    implements $ServerMessageClipboardUpdateRelayCopyWith<$Res> {
  _$ServerMessageClipboardUpdateRelayCopyWithImpl(this._self, this._then);

  final ServerMessageClipboardUpdateRelay _self;
  final $Res Function(ServerMessageClipboardUpdateRelay) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerMessageClipboardUpdateRelay(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ClipboardUpdateRelayMessage,
  ));
}

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClipboardUpdateRelayMessageCopyWith<$Res> get message {
  
  return $ClipboardUpdateRelayMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ServerMessagePong implements ServerMessage {
  const ServerMessagePong(this.message);
  

@override final  PongMessage message;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerMessagePongCopyWith<ServerMessagePong> get copyWith => _$ServerMessagePongCopyWithImpl<ServerMessagePong>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMessagePong&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ServerMessage.pong(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerMessagePongCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerMessagePongCopyWith(ServerMessagePong value, $Res Function(ServerMessagePong) _then) = _$ServerMessagePongCopyWithImpl;
@useResult
$Res call({
 PongMessage message
});


$PongMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ServerMessagePongCopyWithImpl<$Res>
    implements $ServerMessagePongCopyWith<$Res> {
  _$ServerMessagePongCopyWithImpl(this._self, this._then);

  final ServerMessagePong _self;
  final $Res Function(ServerMessagePong) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerMessagePong(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as PongMessage,
  ));
}

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PongMessageCopyWith<$Res> get message {
  
  return $PongMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ServerMessageError implements ServerMessage {
  const ServerMessageError(this.message);
  

@override final  ErrorMessage message;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerMessageErrorCopyWith<ServerMessageError> get copyWith => _$ServerMessageErrorCopyWithImpl<ServerMessageError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMessageError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ServerMessage.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerMessageErrorCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerMessageErrorCopyWith(ServerMessageError value, $Res Function(ServerMessageError) _then) = _$ServerMessageErrorCopyWithImpl;
@useResult
$Res call({
 ErrorMessage message
});


$ErrorMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ServerMessageErrorCopyWithImpl<$Res>
    implements $ServerMessageErrorCopyWith<$Res> {
  _$ServerMessageErrorCopyWithImpl(this._self, this._then);

  final ServerMessageError _self;
  final $Res Function(ServerMessageError) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerMessageError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ErrorMessage,
  ));
}

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ErrorMessageCopyWith<$Res> get message {
  
  return $ErrorMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ServerMessageAck implements ServerMessage {
  const ServerMessageAck(this.message);
  

@override final  AckMessage message;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerMessageAckCopyWith<ServerMessageAck> get copyWith => _$ServerMessageAckCopyWithImpl<ServerMessageAck>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMessageAck&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ServerMessage.ack(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerMessageAckCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerMessageAckCopyWith(ServerMessageAck value, $Res Function(ServerMessageAck) _then) = _$ServerMessageAckCopyWithImpl;
@useResult
$Res call({
 AckMessage message
});


$AckMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ServerMessageAckCopyWithImpl<$Res>
    implements $ServerMessageAckCopyWith<$Res> {
  _$ServerMessageAckCopyWithImpl(this._self, this._then);

  final ServerMessageAck _self;
  final $Res Function(ServerMessageAck) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerMessageAck(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AckMessage,
  ));
}

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AckMessageCopyWith<$Res> get message {
  
  return $AckMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ServerMessageHistorySyncResponse implements ServerMessage {
  const ServerMessageHistorySyncResponse(this.message);
  

@override final  HistorySyncResponseMessage message;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerMessageHistorySyncResponseCopyWith<ServerMessageHistorySyncResponse> get copyWith => _$ServerMessageHistorySyncResponseCopyWithImpl<ServerMessageHistorySyncResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMessageHistorySyncResponse&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ServerMessage.historySyncResponse(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerMessageHistorySyncResponseCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerMessageHistorySyncResponseCopyWith(ServerMessageHistorySyncResponse value, $Res Function(ServerMessageHistorySyncResponse) _then) = _$ServerMessageHistorySyncResponseCopyWithImpl;
@useResult
$Res call({
 HistorySyncResponseMessage message
});


$HistorySyncResponseMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ServerMessageHistorySyncResponseCopyWithImpl<$Res>
    implements $ServerMessageHistorySyncResponseCopyWith<$Res> {
  _$ServerMessageHistorySyncResponseCopyWithImpl(this._self, this._then);

  final ServerMessageHistorySyncResponse _self;
  final $Res Function(ServerMessageHistorySyncResponse) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerMessageHistorySyncResponse(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as HistorySyncResponseMessage,
  ));
}

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistorySyncResponseMessageCopyWith<$Res> get message {
  
  return $HistorySyncResponseMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ServerMessageDeviceOnline implements ServerMessage {
  const ServerMessageDeviceOnline(this.message);
  

@override final  DeviceOnlineMessage message;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerMessageDeviceOnlineCopyWith<ServerMessageDeviceOnline> get copyWith => _$ServerMessageDeviceOnlineCopyWithImpl<ServerMessageDeviceOnline>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMessageDeviceOnline&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ServerMessage.deviceOnline(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerMessageDeviceOnlineCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerMessageDeviceOnlineCopyWith(ServerMessageDeviceOnline value, $Res Function(ServerMessageDeviceOnline) _then) = _$ServerMessageDeviceOnlineCopyWithImpl;
@useResult
$Res call({
 DeviceOnlineMessage message
});


$DeviceOnlineMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ServerMessageDeviceOnlineCopyWithImpl<$Res>
    implements $ServerMessageDeviceOnlineCopyWith<$Res> {
  _$ServerMessageDeviceOnlineCopyWithImpl(this._self, this._then);

  final ServerMessageDeviceOnline _self;
  final $Res Function(ServerMessageDeviceOnline) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerMessageDeviceOnline(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as DeviceOnlineMessage,
  ));
}

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceOnlineMessageCopyWith<$Res> get message {
  
  return $DeviceOnlineMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ServerMessageDeviceOffline implements ServerMessage {
  const ServerMessageDeviceOffline(this.message);
  

@override final  DeviceOfflineMessage message;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerMessageDeviceOfflineCopyWith<ServerMessageDeviceOffline> get copyWith => _$ServerMessageDeviceOfflineCopyWithImpl<ServerMessageDeviceOffline>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMessageDeviceOffline&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ServerMessage.deviceOffline(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerMessageDeviceOfflineCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerMessageDeviceOfflineCopyWith(ServerMessageDeviceOffline value, $Res Function(ServerMessageDeviceOffline) _then) = _$ServerMessageDeviceOfflineCopyWithImpl;
@useResult
$Res call({
 DeviceOfflineMessage message
});


$DeviceOfflineMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ServerMessageDeviceOfflineCopyWithImpl<$Res>
    implements $ServerMessageDeviceOfflineCopyWith<$Res> {
  _$ServerMessageDeviceOfflineCopyWithImpl(this._self, this._then);

  final ServerMessageDeviceOffline _self;
  final $Res Function(ServerMessageDeviceOffline) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerMessageDeviceOffline(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as DeviceOfflineMessage,
  ));
}

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceOfflineMessageCopyWith<$Res> get message {
  
  return $DeviceOfflineMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ServerMessageAuthSuccess implements ServerMessage {
  const ServerMessageAuthSuccess(this.message);
  

@override final  AuthSuccessMessage message;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerMessageAuthSuccessCopyWith<ServerMessageAuthSuccess> get copyWith => _$ServerMessageAuthSuccessCopyWithImpl<ServerMessageAuthSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMessageAuthSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ServerMessage.authSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerMessageAuthSuccessCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerMessageAuthSuccessCopyWith(ServerMessageAuthSuccess value, $Res Function(ServerMessageAuthSuccess) _then) = _$ServerMessageAuthSuccessCopyWithImpl;
@useResult
$Res call({
 AuthSuccessMessage message
});


$AuthSuccessMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ServerMessageAuthSuccessCopyWithImpl<$Res>
    implements $ServerMessageAuthSuccessCopyWith<$Res> {
  _$ServerMessageAuthSuccessCopyWithImpl(this._self, this._then);

  final ServerMessageAuthSuccess _self;
  final $Res Function(ServerMessageAuthSuccess) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerMessageAuthSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AuthSuccessMessage,
  ));
}

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthSuccessMessageCopyWith<$Res> get message {
  
  return $AuthSuccessMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc
mixin _$SyncMessage {

 Object get message;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncMessage&&const DeepCollectionEquality().equals(other.message, message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(message));

@override
String toString() {
  return 'SyncMessage(message: $message)';
}


}

/// @nodoc
class $SyncMessageCopyWith<$Res>  {
$SyncMessageCopyWith(SyncMessage _, $Res Function(SyncMessage) __);
}


/// Adds pattern-matching-related methods to [SyncMessage].
extension SyncMessagePatterns on SyncMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SyncMessageClient value)?  client,TResult Function( SyncMessageServer value)?  server,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SyncMessageClient() when client != null:
return client(_that);case SyncMessageServer() when server != null:
return server(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SyncMessageClient value)  client,required TResult Function( SyncMessageServer value)  server,}){
final _that = this;
switch (_that) {
case SyncMessageClient():
return client(_that);case SyncMessageServer():
return server(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SyncMessageClient value)?  client,TResult? Function( SyncMessageServer value)?  server,}){
final _that = this;
switch (_that) {
case SyncMessageClient() when client != null:
return client(_that);case SyncMessageServer() when server != null:
return server(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ClientMessage message)?  client,TResult Function( ServerMessage message)?  server,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SyncMessageClient() when client != null:
return client(_that.message);case SyncMessageServer() when server != null:
return server(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ClientMessage message)  client,required TResult Function( ServerMessage message)  server,}) {final _that = this;
switch (_that) {
case SyncMessageClient():
return client(_that.message);case SyncMessageServer():
return server(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ClientMessage message)?  client,TResult? Function( ServerMessage message)?  server,}) {final _that = this;
switch (_that) {
case SyncMessageClient() when client != null:
return client(_that.message);case SyncMessageServer() when server != null:
return server(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SyncMessageClient implements SyncMessage {
  const SyncMessageClient(this.message);
  

@override final  ClientMessage message;

/// Create a copy of SyncMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncMessageClientCopyWith<SyncMessageClient> get copyWith => _$SyncMessageClientCopyWithImpl<SyncMessageClient>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncMessageClient&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SyncMessage.client(message: $message)';
}


}

/// @nodoc
abstract mixin class $SyncMessageClientCopyWith<$Res> implements $SyncMessageCopyWith<$Res> {
  factory $SyncMessageClientCopyWith(SyncMessageClient value, $Res Function(SyncMessageClient) _then) = _$SyncMessageClientCopyWithImpl;
@useResult
$Res call({
 ClientMessage message
});


$ClientMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$SyncMessageClientCopyWithImpl<$Res>
    implements $SyncMessageClientCopyWith<$Res> {
  _$SyncMessageClientCopyWithImpl(this._self, this._then);

  final SyncMessageClient _self;
  final $Res Function(SyncMessageClient) _then;

/// Create a copy of SyncMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SyncMessageClient(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ClientMessage,
  ));
}

/// Create a copy of SyncMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientMessageCopyWith<$Res> get message {
  
  return $ClientMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class SyncMessageServer implements SyncMessage {
  const SyncMessageServer(this.message);
  

@override final  ServerMessage message;

/// Create a copy of SyncMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncMessageServerCopyWith<SyncMessageServer> get copyWith => _$SyncMessageServerCopyWithImpl<SyncMessageServer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncMessageServer&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SyncMessage.server(message: $message)';
}


}

/// @nodoc
abstract mixin class $SyncMessageServerCopyWith<$Res> implements $SyncMessageCopyWith<$Res> {
  factory $SyncMessageServerCopyWith(SyncMessageServer value, $Res Function(SyncMessageServer) _then) = _$SyncMessageServerCopyWithImpl;
@useResult
$Res call({
 ServerMessage message
});


$ServerMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$SyncMessageServerCopyWithImpl<$Res>
    implements $SyncMessageServerCopyWith<$Res> {
  _$SyncMessageServerCopyWithImpl(this._self, this._then);

  final SyncMessageServer _self;
  final $Res Function(SyncMessageServer) _then;

/// Create a copy of SyncMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SyncMessageServer(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ServerMessage,
  ));
}

/// Create a copy of SyncMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServerMessageCopyWith<$Res> get message {
  
  return $ServerMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}


/// @nodoc
mixin _$AuthMessage {

 SyncMessageType get type; String get token;
/// Create a copy of AuthMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthMessageCopyWith<AuthMessage> get copyWith => _$AuthMessageCopyWithImpl<AuthMessage>(this as AuthMessage, _$identity);

  /// Serializes this AuthMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,token);

@override
String toString() {
  return 'AuthMessage(type: $type, token: $token)';
}


}

/// @nodoc
abstract mixin class $AuthMessageCopyWith<$Res>  {
  factory $AuthMessageCopyWith(AuthMessage value, $Res Function(AuthMessage) _then) = _$AuthMessageCopyWithImpl;
@useResult
$Res call({
 SyncMessageType type, String token
});




}
/// @nodoc
class _$AuthMessageCopyWithImpl<$Res>
    implements $AuthMessageCopyWith<$Res> {
  _$AuthMessageCopyWithImpl(this._self, this._then);

  final AuthMessage _self;
  final $Res Function(AuthMessage) _then;

/// Create a copy of AuthMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? token = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthMessage].
extension AuthMessagePatterns on AuthMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthMessage value)  $default,){
final _that = this;
switch (_that) {
case _AuthMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthMessage value)?  $default,){
final _that = this;
switch (_that) {
case _AuthMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncMessageType type,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthMessage() when $default != null:
return $default(_that.type,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncMessageType type,  String token)  $default,) {final _that = this;
switch (_that) {
case _AuthMessage():
return $default(_that.type,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncMessageType type,  String token)?  $default,) {final _that = this;
switch (_that) {
case _AuthMessage() when $default != null:
return $default(_that.type,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthMessage implements AuthMessage {
  const _AuthMessage({required this.type, required this.token});
  factory _AuthMessage.fromJson(Map<String, dynamic> json) => _$AuthMessageFromJson(json);

@override final  SyncMessageType type;
@override final  String token;

/// Create a copy of AuthMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthMessageCopyWith<_AuthMessage> get copyWith => __$AuthMessageCopyWithImpl<_AuthMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,token);

@override
String toString() {
  return 'AuthMessage(type: $type, token: $token)';
}


}

/// @nodoc
abstract mixin class _$AuthMessageCopyWith<$Res> implements $AuthMessageCopyWith<$Res> {
  factory _$AuthMessageCopyWith(_AuthMessage value, $Res Function(_AuthMessage) _then) = __$AuthMessageCopyWithImpl;
@override @useResult
$Res call({
 SyncMessageType type, String token
});




}
/// @nodoc
class __$AuthMessageCopyWithImpl<$Res>
    implements _$AuthMessageCopyWith<$Res> {
  __$AuthMessageCopyWithImpl(this._self, this._then);

  final _AuthMessage _self;
  final $Res Function(_AuthMessage) _then;

/// Create a copy of AuthMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? token = null,}) {
  return _then(_AuthMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncMessageType,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
