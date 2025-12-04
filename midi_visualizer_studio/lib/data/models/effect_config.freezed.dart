// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'effect_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EffectConfig {

 EffectType get type; int get durationMs; double get scale;
/// Create a copy of EffectConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EffectConfigCopyWith<EffectConfig> get copyWith => _$EffectConfigCopyWithImpl<EffectConfig>(this as EffectConfig, _$identity);

  /// Serializes this EffectConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EffectConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.scale, scale) || other.scale == scale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,durationMs,scale);

@override
String toString() {
  return 'EffectConfig(type: $type, durationMs: $durationMs, scale: $scale)';
}


}

/// @nodoc
abstract mixin class $EffectConfigCopyWith<$Res>  {
  factory $EffectConfigCopyWith(EffectConfig value, $Res Function(EffectConfig) _then) = _$EffectConfigCopyWithImpl;
@useResult
$Res call({
 EffectType type, int durationMs, double scale
});




}
/// @nodoc
class _$EffectConfigCopyWithImpl<$Res>
    implements $EffectConfigCopyWith<$Res> {
  _$EffectConfigCopyWithImpl(this._self, this._then);

  final EffectConfig _self;
  final $Res Function(EffectConfig) _then;

/// Create a copy of EffectConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? durationMs = null,Object? scale = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EffectType,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EffectConfig].
extension EffectConfigPatterns on EffectConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EffectConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EffectConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EffectConfig value)  $default,){
final _that = this;
switch (_that) {
case _EffectConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EffectConfig value)?  $default,){
final _that = this;
switch (_that) {
case _EffectConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EffectType type,  int durationMs,  double scale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EffectConfig() when $default != null:
return $default(_that.type,_that.durationMs,_that.scale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EffectType type,  int durationMs,  double scale)  $default,) {final _that = this;
switch (_that) {
case _EffectConfig():
return $default(_that.type,_that.durationMs,_that.scale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EffectType type,  int durationMs,  double scale)?  $default,) {final _that = this;
switch (_that) {
case _EffectConfig() when $default != null:
return $default(_that.type,_that.durationMs,_that.scale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EffectConfig implements EffectConfig {
  const _EffectConfig({this.type = EffectType.none, this.durationMs = 300, this.scale = 1.5});
  factory _EffectConfig.fromJson(Map<String, dynamic> json) => _$EffectConfigFromJson(json);

@override@JsonKey() final  EffectType type;
@override@JsonKey() final  int durationMs;
@override@JsonKey() final  double scale;

/// Create a copy of EffectConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EffectConfigCopyWith<_EffectConfig> get copyWith => __$EffectConfigCopyWithImpl<_EffectConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EffectConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EffectConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.scale, scale) || other.scale == scale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,durationMs,scale);

@override
String toString() {
  return 'EffectConfig(type: $type, durationMs: $durationMs, scale: $scale)';
}


}

/// @nodoc
abstract mixin class _$EffectConfigCopyWith<$Res> implements $EffectConfigCopyWith<$Res> {
  factory _$EffectConfigCopyWith(_EffectConfig value, $Res Function(_EffectConfig) _then) = __$EffectConfigCopyWithImpl;
@override @useResult
$Res call({
 EffectType type, int durationMs, double scale
});




}
/// @nodoc
class __$EffectConfigCopyWithImpl<$Res>
    implements _$EffectConfigCopyWith<$Res> {
  __$EffectConfigCopyWithImpl(this._self, this._then);

  final _EffectConfig _self;
  final $Res Function(_EffectConfig) _then;

/// Create a copy of EffectConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? durationMs = null,Object? scale = null,}) {
  return _then(_EffectConfig(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EffectType,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
