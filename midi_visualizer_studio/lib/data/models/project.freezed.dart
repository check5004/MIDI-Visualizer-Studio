// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Project {

 String get id; String get name; String get version; String get description; String get author; DateTime? get createdAt; DateTime? get updatedAt; double get canvasWidth; double get canvasHeight; String get backgroundColor; String get chromaKeyColor; double? get previewWindowWidth; double? get previewWindowHeight; EffectConfig get defaultOnEffectConfig; EffectConfig get defaultOffEffectConfig; List<Component> get layers;
/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectCopyWith<Project> get copyWith => _$ProjectCopyWithImpl<Project>(this as Project, _$identity);

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Project&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.version, version) || other.version == version)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.canvasWidth, canvasWidth) || other.canvasWidth == canvasWidth)&&(identical(other.canvasHeight, canvasHeight) || other.canvasHeight == canvasHeight)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.chromaKeyColor, chromaKeyColor) || other.chromaKeyColor == chromaKeyColor)&&(identical(other.previewWindowWidth, previewWindowWidth) || other.previewWindowWidth == previewWindowWidth)&&(identical(other.previewWindowHeight, previewWindowHeight) || other.previewWindowHeight == previewWindowHeight)&&(identical(other.defaultOnEffectConfig, defaultOnEffectConfig) || other.defaultOnEffectConfig == defaultOnEffectConfig)&&(identical(other.defaultOffEffectConfig, defaultOffEffectConfig) || other.defaultOffEffectConfig == defaultOffEffectConfig)&&const DeepCollectionEquality().equals(other.layers, layers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,version,description,author,createdAt,updatedAt,canvasWidth,canvasHeight,backgroundColor,chromaKeyColor,previewWindowWidth,previewWindowHeight,defaultOnEffectConfig,defaultOffEffectConfig,const DeepCollectionEquality().hash(layers));

@override
String toString() {
  return 'Project(id: $id, name: $name, version: $version, description: $description, author: $author, createdAt: $createdAt, updatedAt: $updatedAt, canvasWidth: $canvasWidth, canvasHeight: $canvasHeight, backgroundColor: $backgroundColor, chromaKeyColor: $chromaKeyColor, previewWindowWidth: $previewWindowWidth, previewWindowHeight: $previewWindowHeight, defaultOnEffectConfig: $defaultOnEffectConfig, defaultOffEffectConfig: $defaultOffEffectConfig, layers: $layers)';
}


}

/// @nodoc
abstract mixin class $ProjectCopyWith<$Res>  {
  factory $ProjectCopyWith(Project value, $Res Function(Project) _then) = _$ProjectCopyWithImpl;
@useResult
$Res call({
 String id, String name, String version, String description, String author, DateTime? createdAt, DateTime? updatedAt, double canvasWidth, double canvasHeight, String backgroundColor, String chromaKeyColor, double? previewWindowWidth, double? previewWindowHeight, EffectConfig defaultOnEffectConfig, EffectConfig defaultOffEffectConfig, List<Component> layers
});


$EffectConfigCopyWith<$Res> get defaultOnEffectConfig;$EffectConfigCopyWith<$Res> get defaultOffEffectConfig;

}
/// @nodoc
class _$ProjectCopyWithImpl<$Res>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._self, this._then);

  final Project _self;
  final $Res Function(Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? version = null,Object? description = null,Object? author = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? canvasWidth = null,Object? canvasHeight = null,Object? backgroundColor = null,Object? chromaKeyColor = null,Object? previewWindowWidth = freezed,Object? previewWindowHeight = freezed,Object? defaultOnEffectConfig = null,Object? defaultOffEffectConfig = null,Object? layers = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,canvasWidth: null == canvasWidth ? _self.canvasWidth : canvasWidth // ignore: cast_nullable_to_non_nullable
as double,canvasHeight: null == canvasHeight ? _self.canvasHeight : canvasHeight // ignore: cast_nullable_to_non_nullable
as double,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,chromaKeyColor: null == chromaKeyColor ? _self.chromaKeyColor : chromaKeyColor // ignore: cast_nullable_to_non_nullable
as String,previewWindowWidth: freezed == previewWindowWidth ? _self.previewWindowWidth : previewWindowWidth // ignore: cast_nullable_to_non_nullable
as double?,previewWindowHeight: freezed == previewWindowHeight ? _self.previewWindowHeight : previewWindowHeight // ignore: cast_nullable_to_non_nullable
as double?,defaultOnEffectConfig: null == defaultOnEffectConfig ? _self.defaultOnEffectConfig : defaultOnEffectConfig // ignore: cast_nullable_to_non_nullable
as EffectConfig,defaultOffEffectConfig: null == defaultOffEffectConfig ? _self.defaultOffEffectConfig : defaultOffEffectConfig // ignore: cast_nullable_to_non_nullable
as EffectConfig,layers: null == layers ? _self.layers : layers // ignore: cast_nullable_to_non_nullable
as List<Component>,
  ));
}
/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EffectConfigCopyWith<$Res> get defaultOnEffectConfig {
  
  return $EffectConfigCopyWith<$Res>(_self.defaultOnEffectConfig, (value) {
    return _then(_self.copyWith(defaultOnEffectConfig: value));
  });
}/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EffectConfigCopyWith<$Res> get defaultOffEffectConfig {
  
  return $EffectConfigCopyWith<$Res>(_self.defaultOffEffectConfig, (value) {
    return _then(_self.copyWith(defaultOffEffectConfig: value));
  });
}
}


/// Adds pattern-matching-related methods to [Project].
extension ProjectPatterns on Project {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Project value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Project value)  $default,){
final _that = this;
switch (_that) {
case _Project():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Project value)?  $default,){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String version,  String description,  String author,  DateTime? createdAt,  DateTime? updatedAt,  double canvasWidth,  double canvasHeight,  String backgroundColor,  String chromaKeyColor,  double? previewWindowWidth,  double? previewWindowHeight,  EffectConfig defaultOnEffectConfig,  EffectConfig defaultOffEffectConfig,  List<Component> layers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.name,_that.version,_that.description,_that.author,_that.createdAt,_that.updatedAt,_that.canvasWidth,_that.canvasHeight,_that.backgroundColor,_that.chromaKeyColor,_that.previewWindowWidth,_that.previewWindowHeight,_that.defaultOnEffectConfig,_that.defaultOffEffectConfig,_that.layers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String version,  String description,  String author,  DateTime? createdAt,  DateTime? updatedAt,  double canvasWidth,  double canvasHeight,  String backgroundColor,  String chromaKeyColor,  double? previewWindowWidth,  double? previewWindowHeight,  EffectConfig defaultOnEffectConfig,  EffectConfig defaultOffEffectConfig,  List<Component> layers)  $default,) {final _that = this;
switch (_that) {
case _Project():
return $default(_that.id,_that.name,_that.version,_that.description,_that.author,_that.createdAt,_that.updatedAt,_that.canvasWidth,_that.canvasHeight,_that.backgroundColor,_that.chromaKeyColor,_that.previewWindowWidth,_that.previewWindowHeight,_that.defaultOnEffectConfig,_that.defaultOffEffectConfig,_that.layers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String version,  String description,  String author,  DateTime? createdAt,  DateTime? updatedAt,  double canvasWidth,  double canvasHeight,  String backgroundColor,  String chromaKeyColor,  double? previewWindowWidth,  double? previewWindowHeight,  EffectConfig defaultOnEffectConfig,  EffectConfig defaultOffEffectConfig,  List<Component> layers)?  $default,) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.name,_that.version,_that.description,_that.author,_that.createdAt,_that.updatedAt,_that.canvasWidth,_that.canvasHeight,_that.backgroundColor,_that.chromaKeyColor,_that.previewWindowWidth,_that.previewWindowHeight,_that.defaultOnEffectConfig,_that.defaultOffEffectConfig,_that.layers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Project implements Project {
  const _Project({required this.id, required this.name, required this.version, this.description = '', this.author = '', this.createdAt, this.updatedAt, this.canvasWidth = 800, this.canvasHeight = 600, this.backgroundColor = '#000000', this.chromaKeyColor = '#00FF00', this.previewWindowWidth, this.previewWindowHeight, this.defaultOnEffectConfig = const EffectConfig(), this.defaultOffEffectConfig = const EffectConfig(), final  List<Component> layers = const []}): _layers = layers;
  factory _Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

@override final  String id;
@override final  String name;
@override final  String version;
@override@JsonKey() final  String description;
@override@JsonKey() final  String author;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override@JsonKey() final  double canvasWidth;
@override@JsonKey() final  double canvasHeight;
@override@JsonKey() final  String backgroundColor;
@override@JsonKey() final  String chromaKeyColor;
@override final  double? previewWindowWidth;
@override final  double? previewWindowHeight;
@override@JsonKey() final  EffectConfig defaultOnEffectConfig;
@override@JsonKey() final  EffectConfig defaultOffEffectConfig;
 final  List<Component> _layers;
@override@JsonKey() List<Component> get layers {
  if (_layers is EqualUnmodifiableListView) return _layers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_layers);
}


/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectCopyWith<_Project> get copyWith => __$ProjectCopyWithImpl<_Project>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Project&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.version, version) || other.version == version)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.canvasWidth, canvasWidth) || other.canvasWidth == canvasWidth)&&(identical(other.canvasHeight, canvasHeight) || other.canvasHeight == canvasHeight)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.chromaKeyColor, chromaKeyColor) || other.chromaKeyColor == chromaKeyColor)&&(identical(other.previewWindowWidth, previewWindowWidth) || other.previewWindowWidth == previewWindowWidth)&&(identical(other.previewWindowHeight, previewWindowHeight) || other.previewWindowHeight == previewWindowHeight)&&(identical(other.defaultOnEffectConfig, defaultOnEffectConfig) || other.defaultOnEffectConfig == defaultOnEffectConfig)&&(identical(other.defaultOffEffectConfig, defaultOffEffectConfig) || other.defaultOffEffectConfig == defaultOffEffectConfig)&&const DeepCollectionEquality().equals(other._layers, _layers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,version,description,author,createdAt,updatedAt,canvasWidth,canvasHeight,backgroundColor,chromaKeyColor,previewWindowWidth,previewWindowHeight,defaultOnEffectConfig,defaultOffEffectConfig,const DeepCollectionEquality().hash(_layers));

@override
String toString() {
  return 'Project(id: $id, name: $name, version: $version, description: $description, author: $author, createdAt: $createdAt, updatedAt: $updatedAt, canvasWidth: $canvasWidth, canvasHeight: $canvasHeight, backgroundColor: $backgroundColor, chromaKeyColor: $chromaKeyColor, previewWindowWidth: $previewWindowWidth, previewWindowHeight: $previewWindowHeight, defaultOnEffectConfig: $defaultOnEffectConfig, defaultOffEffectConfig: $defaultOffEffectConfig, layers: $layers)';
}


}

/// @nodoc
abstract mixin class _$ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$ProjectCopyWith(_Project value, $Res Function(_Project) _then) = __$ProjectCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String version, String description, String author, DateTime? createdAt, DateTime? updatedAt, double canvasWidth, double canvasHeight, String backgroundColor, String chromaKeyColor, double? previewWindowWidth, double? previewWindowHeight, EffectConfig defaultOnEffectConfig, EffectConfig defaultOffEffectConfig, List<Component> layers
});


@override $EffectConfigCopyWith<$Res> get defaultOnEffectConfig;@override $EffectConfigCopyWith<$Res> get defaultOffEffectConfig;

}
/// @nodoc
class __$ProjectCopyWithImpl<$Res>
    implements _$ProjectCopyWith<$Res> {
  __$ProjectCopyWithImpl(this._self, this._then);

  final _Project _self;
  final $Res Function(_Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? version = null,Object? description = null,Object? author = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? canvasWidth = null,Object? canvasHeight = null,Object? backgroundColor = null,Object? chromaKeyColor = null,Object? previewWindowWidth = freezed,Object? previewWindowHeight = freezed,Object? defaultOnEffectConfig = null,Object? defaultOffEffectConfig = null,Object? layers = null,}) {
  return _then(_Project(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,canvasWidth: null == canvasWidth ? _self.canvasWidth : canvasWidth // ignore: cast_nullable_to_non_nullable
as double,canvasHeight: null == canvasHeight ? _self.canvasHeight : canvasHeight // ignore: cast_nullable_to_non_nullable
as double,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,chromaKeyColor: null == chromaKeyColor ? _self.chromaKeyColor : chromaKeyColor // ignore: cast_nullable_to_non_nullable
as String,previewWindowWidth: freezed == previewWindowWidth ? _self.previewWindowWidth : previewWindowWidth // ignore: cast_nullable_to_non_nullable
as double?,previewWindowHeight: freezed == previewWindowHeight ? _self.previewWindowHeight : previewWindowHeight // ignore: cast_nullable_to_non_nullable
as double?,defaultOnEffectConfig: null == defaultOnEffectConfig ? _self.defaultOnEffectConfig : defaultOnEffectConfig // ignore: cast_nullable_to_non_nullable
as EffectConfig,defaultOffEffectConfig: null == defaultOffEffectConfig ? _self.defaultOffEffectConfig : defaultOffEffectConfig // ignore: cast_nullable_to_non_nullable
as EffectConfig,layers: null == layers ? _self._layers : layers // ignore: cast_nullable_to_non_nullable
as List<Component>,
  ));
}

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EffectConfigCopyWith<$Res> get defaultOnEffectConfig {
  
  return $EffectConfigCopyWith<$Res>(_self.defaultOnEffectConfig, (value) {
    return _then(_self.copyWith(defaultOnEffectConfig: value));
  });
}/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EffectConfigCopyWith<$Res> get defaultOffEffectConfig {
  
  return $EffectConfigCopyWith<$Res>(_self.defaultOffEffectConfig, (value) {
    return _then(_self.copyWith(defaultOffEffectConfig: value));
  });
}
}

// dart format on
