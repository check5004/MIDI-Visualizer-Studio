// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shortcut_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShortcutConfig {

 int get keyId; bool get isControl; bool get isMeta; bool get isAlt; bool get isShift;
/// Create a copy of ShortcutConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShortcutConfigCopyWith<ShortcutConfig> get copyWith => _$ShortcutConfigCopyWithImpl<ShortcutConfig>(this as ShortcutConfig, _$identity);

  /// Serializes this ShortcutConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShortcutConfig&&(identical(other.keyId, keyId) || other.keyId == keyId)&&(identical(other.isControl, isControl) || other.isControl == isControl)&&(identical(other.isMeta, isMeta) || other.isMeta == isMeta)&&(identical(other.isAlt, isAlt) || other.isAlt == isAlt)&&(identical(other.isShift, isShift) || other.isShift == isShift));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,keyId,isControl,isMeta,isAlt,isShift);

@override
String toString() {
  return 'ShortcutConfig(keyId: $keyId, isControl: $isControl, isMeta: $isMeta, isAlt: $isAlt, isShift: $isShift)';
}


}

/// @nodoc
abstract mixin class $ShortcutConfigCopyWith<$Res>  {
  factory $ShortcutConfigCopyWith(ShortcutConfig value, $Res Function(ShortcutConfig) _then) = _$ShortcutConfigCopyWithImpl;
@useResult
$Res call({
 int keyId, bool isControl, bool isMeta, bool isAlt, bool isShift
});




}
/// @nodoc
class _$ShortcutConfigCopyWithImpl<$Res>
    implements $ShortcutConfigCopyWith<$Res> {
  _$ShortcutConfigCopyWithImpl(this._self, this._then);

  final ShortcutConfig _self;
  final $Res Function(ShortcutConfig) _then;

/// Create a copy of ShortcutConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keyId = null,Object? isControl = null,Object? isMeta = null,Object? isAlt = null,Object? isShift = null,}) {
  return _then(_self.copyWith(
keyId: null == keyId ? _self.keyId : keyId // ignore: cast_nullable_to_non_nullable
as int,isControl: null == isControl ? _self.isControl : isControl // ignore: cast_nullable_to_non_nullable
as bool,isMeta: null == isMeta ? _self.isMeta : isMeta // ignore: cast_nullable_to_non_nullable
as bool,isAlt: null == isAlt ? _self.isAlt : isAlt // ignore: cast_nullable_to_non_nullable
as bool,isShift: null == isShift ? _self.isShift : isShift // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ShortcutConfig].
extension ShortcutConfigPatterns on ShortcutConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShortcutConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShortcutConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShortcutConfig value)  $default,){
final _that = this;
switch (_that) {
case _ShortcutConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShortcutConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ShortcutConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int keyId,  bool isControl,  bool isMeta,  bool isAlt,  bool isShift)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShortcutConfig() when $default != null:
return $default(_that.keyId,_that.isControl,_that.isMeta,_that.isAlt,_that.isShift);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int keyId,  bool isControl,  bool isMeta,  bool isAlt,  bool isShift)  $default,) {final _that = this;
switch (_that) {
case _ShortcutConfig():
return $default(_that.keyId,_that.isControl,_that.isMeta,_that.isAlt,_that.isShift);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int keyId,  bool isControl,  bool isMeta,  bool isAlt,  bool isShift)?  $default,) {final _that = this;
switch (_that) {
case _ShortcutConfig() when $default != null:
return $default(_that.keyId,_that.isControl,_that.isMeta,_that.isAlt,_that.isShift);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShortcutConfig extends ShortcutConfig {
  const _ShortcutConfig({required this.keyId, this.isControl = false, this.isMeta = false, this.isAlt = false, this.isShift = false}): super._();
  factory _ShortcutConfig.fromJson(Map<String, dynamic> json) => _$ShortcutConfigFromJson(json);

@override final  int keyId;
@override@JsonKey() final  bool isControl;
@override@JsonKey() final  bool isMeta;
@override@JsonKey() final  bool isAlt;
@override@JsonKey() final  bool isShift;

/// Create a copy of ShortcutConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShortcutConfigCopyWith<_ShortcutConfig> get copyWith => __$ShortcutConfigCopyWithImpl<_ShortcutConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShortcutConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShortcutConfig&&(identical(other.keyId, keyId) || other.keyId == keyId)&&(identical(other.isControl, isControl) || other.isControl == isControl)&&(identical(other.isMeta, isMeta) || other.isMeta == isMeta)&&(identical(other.isAlt, isAlt) || other.isAlt == isAlt)&&(identical(other.isShift, isShift) || other.isShift == isShift));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,keyId,isControl,isMeta,isAlt,isShift);

@override
String toString() {
  return 'ShortcutConfig(keyId: $keyId, isControl: $isControl, isMeta: $isMeta, isAlt: $isAlt, isShift: $isShift)';
}


}

/// @nodoc
abstract mixin class _$ShortcutConfigCopyWith<$Res> implements $ShortcutConfigCopyWith<$Res> {
  factory _$ShortcutConfigCopyWith(_ShortcutConfig value, $Res Function(_ShortcutConfig) _then) = __$ShortcutConfigCopyWithImpl;
@override @useResult
$Res call({
 int keyId, bool isControl, bool isMeta, bool isAlt, bool isShift
});




}
/// @nodoc
class __$ShortcutConfigCopyWithImpl<$Res>
    implements _$ShortcutConfigCopyWith<$Res> {
  __$ShortcutConfigCopyWithImpl(this._self, this._then);

  final _ShortcutConfig _self;
  final $Res Function(_ShortcutConfig) _then;

/// Create a copy of ShortcutConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keyId = null,Object? isControl = null,Object? isMeta = null,Object? isAlt = null,Object? isShift = null,}) {
  return _then(_ShortcutConfig(
keyId: null == keyId ? _self.keyId : keyId // ignore: cast_nullable_to_non_nullable
as int,isControl: null == isControl ? _self.isControl : isControl // ignore: cast_nullable_to_non_nullable
as bool,isMeta: null == isMeta ? _self.isMeta : isMeta // ignore: cast_nullable_to_non_nullable
as bool,isAlt: null == isAlt ? _self.isAlt : isAlt // ignore: cast_nullable_to_non_nullable
as bool,isShift: null == isShift ? _self.isShift : isShift // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
