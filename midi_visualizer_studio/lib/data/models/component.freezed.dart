// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'component.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Component _$ComponentFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'pad':
          return ComponentPad.fromJson(
            json
          );
                case 'knob':
          return ComponentKnob.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Component',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Component {

 String get id; String get name; double get x; double get y; double get width; double get height; double get rotation; int get zIndex; bool get isLocked; int? get midiChannel;
/// Create a copy of Component
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComponentCopyWith<Component> get copyWith => _$ComponentCopyWithImpl<Component>(this as Component, _$identity);

  /// Serializes this Component to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Component&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.zIndex, zIndex) || other.zIndex == zIndex)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.midiChannel, midiChannel) || other.midiChannel == midiChannel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,x,y,width,height,rotation,zIndex,isLocked,midiChannel);

@override
String toString() {
  return 'Component(id: $id, name: $name, x: $x, y: $y, width: $width, height: $height, rotation: $rotation, zIndex: $zIndex, isLocked: $isLocked, midiChannel: $midiChannel)';
}


}

/// @nodoc
abstract mixin class $ComponentCopyWith<$Res>  {
  factory $ComponentCopyWith(Component value, $Res Function(Component) _then) = _$ComponentCopyWithImpl;
@useResult
$Res call({
 String id, String name, double x, double y, double width, double height, double rotation, int zIndex, bool isLocked, int? midiChannel
});




}
/// @nodoc
class _$ComponentCopyWithImpl<$Res>
    implements $ComponentCopyWith<$Res> {
  _$ComponentCopyWithImpl(this._self, this._then);

  final Component _self;
  final $Res Function(Component) _then;

/// Create a copy of Component
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? x = null,Object? y = null,Object? width = null,Object? height = null,Object? rotation = null,Object? zIndex = null,Object? isLocked = null,Object? midiChannel = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,zIndex: null == zIndex ? _self.zIndex : zIndex // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,midiChannel: freezed == midiChannel ? _self.midiChannel : midiChannel // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Component].
extension ComponentPatterns on Component {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ComponentPad value)?  pad,TResult Function( ComponentKnob value)?  knob,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ComponentPad() when pad != null:
return pad(_that);case ComponentKnob() when knob != null:
return knob(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ComponentPad value)  pad,required TResult Function( ComponentKnob value)  knob,}){
final _that = this;
switch (_that) {
case ComponentPad():
return pad(_that);case ComponentKnob():
return knob(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ComponentPad value)?  pad,TResult? Function( ComponentKnob value)?  knob,}){
final _that = this;
switch (_that) {
case ComponentPad() when pad != null:
return pad(_that);case ComponentKnob() when knob != null:
return knob(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String name,  double x,  double y,  double width,  double height,  double rotation,  int zIndex,  bool isLocked,  PadShape shape,  String? pathData,  String onColor,  String offColor,  int? midiChannel,  int? midiNote)?  pad,TResult Function( String id,  String name,  double x,  double y,  double width,  double height,  double rotation,  int zIndex,  bool isLocked,  KnobStyle style,  double minAngle,  double maxAngle,  bool isRelative,  KnobRelativeEffect relativeEffect,  int? midiChannel,  int? midiCc)?  knob,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ComponentPad() when pad != null:
return pad(_that.id,_that.name,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.zIndex,_that.isLocked,_that.shape,_that.pathData,_that.onColor,_that.offColor,_that.midiChannel,_that.midiNote);case ComponentKnob() when knob != null:
return knob(_that.id,_that.name,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.zIndex,_that.isLocked,_that.style,_that.minAngle,_that.maxAngle,_that.isRelative,_that.relativeEffect,_that.midiChannel,_that.midiCc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String name,  double x,  double y,  double width,  double height,  double rotation,  int zIndex,  bool isLocked,  PadShape shape,  String? pathData,  String onColor,  String offColor,  int? midiChannel,  int? midiNote)  pad,required TResult Function( String id,  String name,  double x,  double y,  double width,  double height,  double rotation,  int zIndex,  bool isLocked,  KnobStyle style,  double minAngle,  double maxAngle,  bool isRelative,  KnobRelativeEffect relativeEffect,  int? midiChannel,  int? midiCc)  knob,}) {final _that = this;
switch (_that) {
case ComponentPad():
return pad(_that.id,_that.name,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.zIndex,_that.isLocked,_that.shape,_that.pathData,_that.onColor,_that.offColor,_that.midiChannel,_that.midiNote);case ComponentKnob():
return knob(_that.id,_that.name,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.zIndex,_that.isLocked,_that.style,_that.minAngle,_that.maxAngle,_that.isRelative,_that.relativeEffect,_that.midiChannel,_that.midiCc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String name,  double x,  double y,  double width,  double height,  double rotation,  int zIndex,  bool isLocked,  PadShape shape,  String? pathData,  String onColor,  String offColor,  int? midiChannel,  int? midiNote)?  pad,TResult? Function( String id,  String name,  double x,  double y,  double width,  double height,  double rotation,  int zIndex,  bool isLocked,  KnobStyle style,  double minAngle,  double maxAngle,  bool isRelative,  KnobRelativeEffect relativeEffect,  int? midiChannel,  int? midiCc)?  knob,}) {final _that = this;
switch (_that) {
case ComponentPad() when pad != null:
return pad(_that.id,_that.name,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.zIndex,_that.isLocked,_that.shape,_that.pathData,_that.onColor,_that.offColor,_that.midiChannel,_that.midiNote);case ComponentKnob() when knob != null:
return knob(_that.id,_that.name,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.zIndex,_that.isLocked,_that.style,_that.minAngle,_that.maxAngle,_that.isRelative,_that.relativeEffect,_that.midiChannel,_that.midiCc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ComponentPad implements Component {
  const ComponentPad({required this.id, required this.name, required this.x, required this.y, required this.width, required this.height, this.rotation = 0, this.zIndex = 0, this.isLocked = false, this.shape = PadShape.rect, this.pathData, this.onColor = '#00FF00', this.offColor = '#333333', this.midiChannel, this.midiNote, final  String? $type}): $type = $type ?? 'pad';
  factory ComponentPad.fromJson(Map<String, dynamic> json) => _$ComponentPadFromJson(json);

@override final  String id;
@override final  String name;
@override final  double x;
@override final  double y;
@override final  double width;
@override final  double height;
@override@JsonKey() final  double rotation;
@override@JsonKey() final  int zIndex;
@override@JsonKey() final  bool isLocked;
@JsonKey() final  PadShape shape;
 final  String? pathData;
@JsonKey() final  String onColor;
@JsonKey() final  String offColor;
@override final  int? midiChannel;
 final  int? midiNote;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Component
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComponentPadCopyWith<ComponentPad> get copyWith => _$ComponentPadCopyWithImpl<ComponentPad>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComponentPadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComponentPad&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.zIndex, zIndex) || other.zIndex == zIndex)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.shape, shape) || other.shape == shape)&&(identical(other.pathData, pathData) || other.pathData == pathData)&&(identical(other.onColor, onColor) || other.onColor == onColor)&&(identical(other.offColor, offColor) || other.offColor == offColor)&&(identical(other.midiChannel, midiChannel) || other.midiChannel == midiChannel)&&(identical(other.midiNote, midiNote) || other.midiNote == midiNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,x,y,width,height,rotation,zIndex,isLocked,shape,pathData,onColor,offColor,midiChannel,midiNote);

@override
String toString() {
  return 'Component.pad(id: $id, name: $name, x: $x, y: $y, width: $width, height: $height, rotation: $rotation, zIndex: $zIndex, isLocked: $isLocked, shape: $shape, pathData: $pathData, onColor: $onColor, offColor: $offColor, midiChannel: $midiChannel, midiNote: $midiNote)';
}


}

/// @nodoc
abstract mixin class $ComponentPadCopyWith<$Res> implements $ComponentCopyWith<$Res> {
  factory $ComponentPadCopyWith(ComponentPad value, $Res Function(ComponentPad) _then) = _$ComponentPadCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double x, double y, double width, double height, double rotation, int zIndex, bool isLocked, PadShape shape, String? pathData, String onColor, String offColor, int? midiChannel, int? midiNote
});




}
/// @nodoc
class _$ComponentPadCopyWithImpl<$Res>
    implements $ComponentPadCopyWith<$Res> {
  _$ComponentPadCopyWithImpl(this._self, this._then);

  final ComponentPad _self;
  final $Res Function(ComponentPad) _then;

/// Create a copy of Component
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? x = null,Object? y = null,Object? width = null,Object? height = null,Object? rotation = null,Object? zIndex = null,Object? isLocked = null,Object? shape = null,Object? pathData = freezed,Object? onColor = null,Object? offColor = null,Object? midiChannel = freezed,Object? midiNote = freezed,}) {
  return _then(ComponentPad(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,zIndex: null == zIndex ? _self.zIndex : zIndex // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as PadShape,pathData: freezed == pathData ? _self.pathData : pathData // ignore: cast_nullable_to_non_nullable
as String?,onColor: null == onColor ? _self.onColor : onColor // ignore: cast_nullable_to_non_nullable
as String,offColor: null == offColor ? _self.offColor : offColor // ignore: cast_nullable_to_non_nullable
as String,midiChannel: freezed == midiChannel ? _self.midiChannel : midiChannel // ignore: cast_nullable_to_non_nullable
as int?,midiNote: freezed == midiNote ? _self.midiNote : midiNote // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ComponentKnob implements Component {
  const ComponentKnob({required this.id, required this.name, required this.x, required this.y, required this.width, required this.height, this.rotation = 0, this.zIndex = 0, this.isLocked = false, this.style = KnobStyle.vectorArc, this.minAngle = -135.0, this.maxAngle = 135.0, this.isRelative = false, this.relativeEffect = KnobRelativeEffect.tint, this.midiChannel, this.midiCc, final  String? $type}): $type = $type ?? 'knob';
  factory ComponentKnob.fromJson(Map<String, dynamic> json) => _$ComponentKnobFromJson(json);

@override final  String id;
@override final  String name;
@override final  double x;
@override final  double y;
@override final  double width;
@override final  double height;
@override@JsonKey() final  double rotation;
@override@JsonKey() final  int zIndex;
@override@JsonKey() final  bool isLocked;
@JsonKey() final  KnobStyle style;
@JsonKey() final  double minAngle;
@JsonKey() final  double maxAngle;
@JsonKey() final  bool isRelative;
@JsonKey() final  KnobRelativeEffect relativeEffect;
@override final  int? midiChannel;
 final  int? midiCc;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Component
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComponentKnobCopyWith<ComponentKnob> get copyWith => _$ComponentKnobCopyWithImpl<ComponentKnob>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComponentKnobToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComponentKnob&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.zIndex, zIndex) || other.zIndex == zIndex)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.style, style) || other.style == style)&&(identical(other.minAngle, minAngle) || other.minAngle == minAngle)&&(identical(other.maxAngle, maxAngle) || other.maxAngle == maxAngle)&&(identical(other.isRelative, isRelative) || other.isRelative == isRelative)&&(identical(other.relativeEffect, relativeEffect) || other.relativeEffect == relativeEffect)&&(identical(other.midiChannel, midiChannel) || other.midiChannel == midiChannel)&&(identical(other.midiCc, midiCc) || other.midiCc == midiCc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,x,y,width,height,rotation,zIndex,isLocked,style,minAngle,maxAngle,isRelative,relativeEffect,midiChannel,midiCc);

@override
String toString() {
  return 'Component.knob(id: $id, name: $name, x: $x, y: $y, width: $width, height: $height, rotation: $rotation, zIndex: $zIndex, isLocked: $isLocked, style: $style, minAngle: $minAngle, maxAngle: $maxAngle, isRelative: $isRelative, relativeEffect: $relativeEffect, midiChannel: $midiChannel, midiCc: $midiCc)';
}


}

/// @nodoc
abstract mixin class $ComponentKnobCopyWith<$Res> implements $ComponentCopyWith<$Res> {
  factory $ComponentKnobCopyWith(ComponentKnob value, $Res Function(ComponentKnob) _then) = _$ComponentKnobCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double x, double y, double width, double height, double rotation, int zIndex, bool isLocked, KnobStyle style, double minAngle, double maxAngle, bool isRelative, KnobRelativeEffect relativeEffect, int? midiChannel, int? midiCc
});




}
/// @nodoc
class _$ComponentKnobCopyWithImpl<$Res>
    implements $ComponentKnobCopyWith<$Res> {
  _$ComponentKnobCopyWithImpl(this._self, this._then);

  final ComponentKnob _self;
  final $Res Function(ComponentKnob) _then;

/// Create a copy of Component
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? x = null,Object? y = null,Object? width = null,Object? height = null,Object? rotation = null,Object? zIndex = null,Object? isLocked = null,Object? style = null,Object? minAngle = null,Object? maxAngle = null,Object? isRelative = null,Object? relativeEffect = null,Object? midiChannel = freezed,Object? midiCc = freezed,}) {
  return _then(ComponentKnob(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,zIndex: null == zIndex ? _self.zIndex : zIndex // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as KnobStyle,minAngle: null == minAngle ? _self.minAngle : minAngle // ignore: cast_nullable_to_non_nullable
as double,maxAngle: null == maxAngle ? _self.maxAngle : maxAngle // ignore: cast_nullable_to_non_nullable
as double,isRelative: null == isRelative ? _self.isRelative : isRelative // ignore: cast_nullable_to_non_nullable
as bool,relativeEffect: null == relativeEffect ? _self.relativeEffect : relativeEffect // ignore: cast_nullable_to_non_nullable
as KnobRelativeEffect,midiChannel: freezed == midiChannel ? _self.midiChannel : midiChannel // ignore: cast_nullable_to_non_nullable
as int?,midiCc: freezed == midiCc ? _self.midiCc : midiCc // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
