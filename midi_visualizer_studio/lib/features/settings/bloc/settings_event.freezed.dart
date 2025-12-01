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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadSettings value)?  loadSettings,TResult Function( ToggleTheme value)?  toggleTheme,TResult Function( UpdateChromaKeyColor value)?  updateChromaKeyColor,TResult Function( ToggleWindowless value)?  toggleWindowless,TResult Function( UpdateShortcut value)?  updateShortcut,TResult Function( ResetShortcuts value)?  resetShortcuts,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings(_that);case ToggleTheme() when toggleTheme != null:
return toggleTheme(_that);case UpdateChromaKeyColor() when updateChromaKeyColor != null:
return updateChromaKeyColor(_that);case ToggleWindowless() when toggleWindowless != null:
return toggleWindowless(_that);case UpdateShortcut() when updateShortcut != null:
return updateShortcut(_that);case ResetShortcuts() when resetShortcuts != null:
return resetShortcuts(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadSettings value)  loadSettings,required TResult Function( ToggleTheme value)  toggleTheme,required TResult Function( UpdateChromaKeyColor value)  updateChromaKeyColor,required TResult Function( ToggleWindowless value)  toggleWindowless,required TResult Function( UpdateShortcut value)  updateShortcut,required TResult Function( ResetShortcuts value)  resetShortcuts,}){
final _that = this;
switch (_that) {
case LoadSettings():
return loadSettings(_that);case ToggleTheme():
return toggleTheme(_that);case UpdateChromaKeyColor():
return updateChromaKeyColor(_that);case ToggleWindowless():
return toggleWindowless(_that);case UpdateShortcut():
return updateShortcut(_that);case ResetShortcuts():
return resetShortcuts(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadSettings value)?  loadSettings,TResult? Function( ToggleTheme value)?  toggleTheme,TResult? Function( UpdateChromaKeyColor value)?  updateChromaKeyColor,TResult? Function( ToggleWindowless value)?  toggleWindowless,TResult? Function( UpdateShortcut value)?  updateShortcut,TResult? Function( ResetShortcuts value)?  resetShortcuts,}){
final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings(_that);case ToggleTheme() when toggleTheme != null:
return toggleTheme(_that);case UpdateChromaKeyColor() when updateChromaKeyColor != null:
return updateChromaKeyColor(_that);case ToggleWindowless() when toggleWindowless != null:
return toggleWindowless(_that);case UpdateShortcut() when updateShortcut != null:
return updateShortcut(_that);case ResetShortcuts() when resetShortcuts != null:
return resetShortcuts(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadSettings,TResult Function( ThemeMode mode)?  toggleTheme,TResult Function( int color)?  updateChromaKeyColor,TResult Function( bool isWindowless)?  toggleWindowless,TResult Function( String actionId,  ShortcutConfig config)?  updateShortcut,TResult Function()?  resetShortcuts,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings();case ToggleTheme() when toggleTheme != null:
return toggleTheme(_that.mode);case UpdateChromaKeyColor() when updateChromaKeyColor != null:
return updateChromaKeyColor(_that.color);case ToggleWindowless() when toggleWindowless != null:
return toggleWindowless(_that.isWindowless);case UpdateShortcut() when updateShortcut != null:
return updateShortcut(_that.actionId,_that.config);case ResetShortcuts() when resetShortcuts != null:
return resetShortcuts();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadSettings,required TResult Function( ThemeMode mode)  toggleTheme,required TResult Function( int color)  updateChromaKeyColor,required TResult Function( bool isWindowless)  toggleWindowless,required TResult Function( String actionId,  ShortcutConfig config)  updateShortcut,required TResult Function()  resetShortcuts,}) {final _that = this;
switch (_that) {
case LoadSettings():
return loadSettings();case ToggleTheme():
return toggleTheme(_that.mode);case UpdateChromaKeyColor():
return updateChromaKeyColor(_that.color);case ToggleWindowless():
return toggleWindowless(_that.isWindowless);case UpdateShortcut():
return updateShortcut(_that.actionId,_that.config);case ResetShortcuts():
return resetShortcuts();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadSettings,TResult? Function( ThemeMode mode)?  toggleTheme,TResult? Function( int color)?  updateChromaKeyColor,TResult? Function( bool isWindowless)?  toggleWindowless,TResult? Function( String actionId,  ShortcutConfig config)?  updateShortcut,TResult? Function()?  resetShortcuts,}) {final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings();case ToggleTheme() when toggleTheme != null:
return toggleTheme(_that.mode);case UpdateChromaKeyColor() when updateChromaKeyColor != null:
return updateChromaKeyColor(_that.color);case ToggleWindowless() when toggleWindowless != null:
return toggleWindowless(_that.isWindowless);case UpdateShortcut() when updateShortcut != null:
return updateShortcut(_that.actionId,_that.config);case ResetShortcuts() when resetShortcuts != null:
return resetShortcuts();case _:
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

/// @nodoc


class ToggleWindowless implements SettingsEvent {
  const ToggleWindowless(this.isWindowless);
  

 final  bool isWindowless;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleWindowlessCopyWith<ToggleWindowless> get copyWith => _$ToggleWindowlessCopyWithImpl<ToggleWindowless>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleWindowless&&(identical(other.isWindowless, isWindowless) || other.isWindowless == isWindowless));
}


@override
int get hashCode => Object.hash(runtimeType,isWindowless);

@override
String toString() {
  return 'SettingsEvent.toggleWindowless(isWindowless: $isWindowless)';
}


}

/// @nodoc
abstract mixin class $ToggleWindowlessCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $ToggleWindowlessCopyWith(ToggleWindowless value, $Res Function(ToggleWindowless) _then) = _$ToggleWindowlessCopyWithImpl;
@useResult
$Res call({
 bool isWindowless
});




}
/// @nodoc
class _$ToggleWindowlessCopyWithImpl<$Res>
    implements $ToggleWindowlessCopyWith<$Res> {
  _$ToggleWindowlessCopyWithImpl(this._self, this._then);

  final ToggleWindowless _self;
  final $Res Function(ToggleWindowless) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isWindowless = null,}) {
  return _then(ToggleWindowless(
null == isWindowless ? _self.isWindowless : isWindowless // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class UpdateShortcut implements SettingsEvent {
  const UpdateShortcut(this.actionId, this.config);
  

 final  String actionId;
 final  ShortcutConfig config;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateShortcutCopyWith<UpdateShortcut> get copyWith => _$UpdateShortcutCopyWithImpl<UpdateShortcut>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateShortcut&&(identical(other.actionId, actionId) || other.actionId == actionId)&&(identical(other.config, config) || other.config == config));
}


@override
int get hashCode => Object.hash(runtimeType,actionId,config);

@override
String toString() {
  return 'SettingsEvent.updateShortcut(actionId: $actionId, config: $config)';
}


}

/// @nodoc
abstract mixin class $UpdateShortcutCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $UpdateShortcutCopyWith(UpdateShortcut value, $Res Function(UpdateShortcut) _then) = _$UpdateShortcutCopyWithImpl;
@useResult
$Res call({
 String actionId, ShortcutConfig config
});


$ShortcutConfigCopyWith<$Res> get config;

}
/// @nodoc
class _$UpdateShortcutCopyWithImpl<$Res>
    implements $UpdateShortcutCopyWith<$Res> {
  _$UpdateShortcutCopyWithImpl(this._self, this._then);

  final UpdateShortcut _self;
  final $Res Function(UpdateShortcut) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? actionId = null,Object? config = null,}) {
  return _then(UpdateShortcut(
null == actionId ? _self.actionId : actionId // ignore: cast_nullable_to_non_nullable
as String,null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as ShortcutConfig,
  ));
}

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShortcutConfigCopyWith<$Res> get config {
  
  return $ShortcutConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

/// @nodoc


class ResetShortcuts implements SettingsEvent {
  const ResetShortcuts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetShortcuts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.resetShortcuts()';
}


}




// dart format on
