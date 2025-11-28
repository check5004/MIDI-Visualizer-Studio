// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent()';
}


}

/// @nodoc
class $SettingsEventCopyWith<$Res>  {
$SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}


/// Adds pattern-matching-related methods to [SettingsEvent].
extension SettingsEventPatterns on SettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadSettings value)?  loadSettings,TResult Function( ToggleTheme value)?  toggleTheme,TResult Function( UpdateChromaKeyColor value)?  updateChromaKeyColor,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings(_that);case ToggleTheme() when toggleTheme != null:
return toggleTheme(_that);case UpdateChromaKeyColor() when updateChromaKeyColor != null:
return updateChromaKeyColor(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadSettings value)  loadSettings,required TResult Function( ToggleTheme value)  toggleTheme,required TResult Function( UpdateChromaKeyColor value)  updateChromaKeyColor,}){
final _that = this;
switch (_that) {
case LoadSettings():
return loadSettings(_that);case ToggleTheme():
return toggleTheme(_that);case UpdateChromaKeyColor():
return updateChromaKeyColor(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadSettings value)?  loadSettings,TResult? Function( ToggleTheme value)?  toggleTheme,TResult? Function( UpdateChromaKeyColor value)?  updateChromaKeyColor,}){
final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings(_that);case ToggleTheme() when toggleTheme != null:
return toggleTheme(_that);case UpdateChromaKeyColor() when updateChromaKeyColor != null:
return updateChromaKeyColor(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadSettings,TResult Function( ThemeMode mode)?  toggleTheme,TResult Function( int color)?  updateChromaKeyColor,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings();case ToggleTheme() when toggleTheme != null:
return toggleTheme(_that.mode);case UpdateChromaKeyColor() when updateChromaKeyColor != null:
return updateChromaKeyColor(_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadSettings,required TResult Function( ThemeMode mode)  toggleTheme,required TResult Function( int color)  updateChromaKeyColor,}) {final _that = this;
switch (_that) {
case LoadSettings():
return loadSettings();case ToggleTheme():
return toggleTheme(_that.mode);case UpdateChromaKeyColor():
return updateChromaKeyColor(_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadSettings,TResult? Function( ThemeMode mode)?  toggleTheme,TResult? Function( int color)?  updateChromaKeyColor,}) {final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings();case ToggleTheme() when toggleTheme != null:
return toggleTheme(_that.mode);case UpdateChromaKeyColor() when updateChromaKeyColor != null:
return updateChromaKeyColor(_that.color);case _:
  return null;

}
}

}

/// @nodoc


class LoadSettings implements SettingsEvent {
  const LoadSettings();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadSettings);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.loadSettings()';
}


}




/// @nodoc


class ToggleTheme implements SettingsEvent {
  const ToggleTheme(this.mode);
  

 final  ThemeMode mode;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleThemeCopyWith<ToggleTheme> get copyWith => _$ToggleThemeCopyWithImpl<ToggleTheme>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleTheme&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'SettingsEvent.toggleTheme(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $ToggleThemeCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $ToggleThemeCopyWith(ToggleTheme value, $Res Function(ToggleTheme) _then) = _$ToggleThemeCopyWithImpl;
@useResult
$Res call({
 ThemeMode mode
});




}
/// @nodoc
class _$ToggleThemeCopyWithImpl<$Res>
    implements $ToggleThemeCopyWith<$Res> {
  _$ToggleThemeCopyWithImpl(this._self, this._then);

  final ToggleTheme _self;
  final $Res Function(ToggleTheme) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(ToggleTheme(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}


}

/// @nodoc


class UpdateChromaKeyColor implements SettingsEvent {
  const UpdateChromaKeyColor(this.color);
  

 final  int color;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateChromaKeyColorCopyWith<UpdateChromaKeyColor> get copyWith => _$UpdateChromaKeyColorCopyWithImpl<UpdateChromaKeyColor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateChromaKeyColor&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,color);

@override
String toString() {
  return 'SettingsEvent.updateChromaKeyColor(color: $color)';
}


}

/// @nodoc
abstract mixin class $UpdateChromaKeyColorCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $UpdateChromaKeyColorCopyWith(UpdateChromaKeyColor value, $Res Function(UpdateChromaKeyColor) _then) = _$UpdateChromaKeyColorCopyWithImpl;
@useResult
$Res call({
 int color
});




}
/// @nodoc
class _$UpdateChromaKeyColorCopyWithImpl<$Res>
    implements $UpdateChromaKeyColorCopyWith<$Res> {
  _$UpdateChromaKeyColorCopyWithImpl(this._self, this._then);

  final UpdateChromaKeyColor _self;
  final $Res Function(UpdateChromaKeyColor) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? color = null,}) {
  return _then(UpdateChromaKeyColor(
null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
