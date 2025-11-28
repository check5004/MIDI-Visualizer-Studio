// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditorState {

 EditorStatus get status; Project? get project; Set<String> get selectedComponentIds; EditorMode get mode; double get zoomLevel; EditorTool get currentTool; List<Offset> get currentPathPoints; String? get errorMessage;
/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditorStateCopyWith<EditorState> get copyWith => _$EditorStateCopyWithImpl<EditorState>(this as EditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditorState&&(identical(other.status, status) || other.status == status)&&(identical(other.project, project) || other.project == project)&&const DeepCollectionEquality().equals(other.selectedComponentIds, selectedComponentIds)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.zoomLevel, zoomLevel) || other.zoomLevel == zoomLevel)&&(identical(other.currentTool, currentTool) || other.currentTool == currentTool)&&const DeepCollectionEquality().equals(other.currentPathPoints, currentPathPoints)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,project,const DeepCollectionEquality().hash(selectedComponentIds),mode,zoomLevel,currentTool,const DeepCollectionEquality().hash(currentPathPoints),errorMessage);

@override
String toString() {
  return 'EditorState(status: $status, project: $project, selectedComponentIds: $selectedComponentIds, mode: $mode, zoomLevel: $zoomLevel, currentTool: $currentTool, currentPathPoints: $currentPathPoints, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $EditorStateCopyWith<$Res>  {
  factory $EditorStateCopyWith(EditorState value, $Res Function(EditorState) _then) = _$EditorStateCopyWithImpl;
@useResult
$Res call({
 EditorStatus status, Project? project, Set<String> selectedComponentIds, EditorMode mode, double zoomLevel, EditorTool currentTool, List<Offset> currentPathPoints, String? errorMessage
});


$ProjectCopyWith<$Res>? get project;

}
/// @nodoc
class _$EditorStateCopyWithImpl<$Res>
    implements $EditorStateCopyWith<$Res> {
  _$EditorStateCopyWithImpl(this._self, this._then);

  final EditorState _self;
  final $Res Function(EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? project = freezed,Object? selectedComponentIds = null,Object? mode = null,Object? zoomLevel = null,Object? currentTool = null,Object? currentPathPoints = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EditorStatus,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project?,selectedComponentIds: null == selectedComponentIds ? _self.selectedComponentIds : selectedComponentIds // ignore: cast_nullable_to_non_nullable
as Set<String>,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as EditorMode,zoomLevel: null == zoomLevel ? _self.zoomLevel : zoomLevel // ignore: cast_nullable_to_non_nullable
as double,currentTool: null == currentTool ? _self.currentTool : currentTool // ignore: cast_nullable_to_non_nullable
as EditorTool,currentPathPoints: null == currentPathPoints ? _self.currentPathPoints : currentPathPoints // ignore: cast_nullable_to_non_nullable
as List<Offset>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res>? get project {
    if (_self.project == null) {
    return null;
  }

  return $ProjectCopyWith<$Res>(_self.project!, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}


/// Adds pattern-matching-related methods to [EditorState].
extension EditorStatePatterns on EditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditorState value)  $default,){
final _that = this;
switch (_that) {
case _EditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditorState value)?  $default,){
final _that = this;
switch (_that) {
case _EditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EditorStatus status,  Project? project,  Set<String> selectedComponentIds,  EditorMode mode,  double zoomLevel,  EditorTool currentTool,  List<Offset> currentPathPoints,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.status,_that.project,_that.selectedComponentIds,_that.mode,_that.zoomLevel,_that.currentTool,_that.currentPathPoints,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EditorStatus status,  Project? project,  Set<String> selectedComponentIds,  EditorMode mode,  double zoomLevel,  EditorTool currentTool,  List<Offset> currentPathPoints,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _EditorState():
return $default(_that.status,_that.project,_that.selectedComponentIds,_that.mode,_that.zoomLevel,_that.currentTool,_that.currentPathPoints,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EditorStatus status,  Project? project,  Set<String> selectedComponentIds,  EditorMode mode,  double zoomLevel,  EditorTool currentTool,  List<Offset> currentPathPoints,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.status,_that.project,_that.selectedComponentIds,_that.mode,_that.zoomLevel,_that.currentTool,_that.currentPathPoints,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _EditorState implements EditorState {
  const _EditorState({this.status = EditorStatus.initial, this.project, final  Set<String> selectedComponentIds = const {}, this.mode = EditorMode.edit, this.zoomLevel = 1.0, this.currentTool = EditorTool.select, final  List<Offset> currentPathPoints = const [], this.errorMessage}): _selectedComponentIds = selectedComponentIds,_currentPathPoints = currentPathPoints;
  

@override@JsonKey() final  EditorStatus status;
@override final  Project? project;
 final  Set<String> _selectedComponentIds;
@override@JsonKey() Set<String> get selectedComponentIds {
  if (_selectedComponentIds is EqualUnmodifiableSetView) return _selectedComponentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedComponentIds);
}

@override@JsonKey() final  EditorMode mode;
@override@JsonKey() final  double zoomLevel;
@override@JsonKey() final  EditorTool currentTool;
 final  List<Offset> _currentPathPoints;
@override@JsonKey() List<Offset> get currentPathPoints {
  if (_currentPathPoints is EqualUnmodifiableListView) return _currentPathPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentPathPoints);
}

@override final  String? errorMessage;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditorStateCopyWith<_EditorState> get copyWith => __$EditorStateCopyWithImpl<_EditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditorState&&(identical(other.status, status) || other.status == status)&&(identical(other.project, project) || other.project == project)&&const DeepCollectionEquality().equals(other._selectedComponentIds, _selectedComponentIds)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.zoomLevel, zoomLevel) || other.zoomLevel == zoomLevel)&&(identical(other.currentTool, currentTool) || other.currentTool == currentTool)&&const DeepCollectionEquality().equals(other._currentPathPoints, _currentPathPoints)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,project,const DeepCollectionEquality().hash(_selectedComponentIds),mode,zoomLevel,currentTool,const DeepCollectionEquality().hash(_currentPathPoints),errorMessage);

@override
String toString() {
  return 'EditorState(status: $status, project: $project, selectedComponentIds: $selectedComponentIds, mode: $mode, zoomLevel: $zoomLevel, currentTool: $currentTool, currentPathPoints: $currentPathPoints, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$EditorStateCopyWith<$Res> implements $EditorStateCopyWith<$Res> {
  factory _$EditorStateCopyWith(_EditorState value, $Res Function(_EditorState) _then) = __$EditorStateCopyWithImpl;
@override @useResult
$Res call({
 EditorStatus status, Project? project, Set<String> selectedComponentIds, EditorMode mode, double zoomLevel, EditorTool currentTool, List<Offset> currentPathPoints, String? errorMessage
});


@override $ProjectCopyWith<$Res>? get project;

}
/// @nodoc
class __$EditorStateCopyWithImpl<$Res>
    implements _$EditorStateCopyWith<$Res> {
  __$EditorStateCopyWithImpl(this._self, this._then);

  final _EditorState _self;
  final $Res Function(_EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? project = freezed,Object? selectedComponentIds = null,Object? mode = null,Object? zoomLevel = null,Object? currentTool = null,Object? currentPathPoints = null,Object? errorMessage = freezed,}) {
  return _then(_EditorState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EditorStatus,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project?,selectedComponentIds: null == selectedComponentIds ? _self._selectedComponentIds : selectedComponentIds // ignore: cast_nullable_to_non_nullable
as Set<String>,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as EditorMode,zoomLevel: null == zoomLevel ? _self.zoomLevel : zoomLevel // ignore: cast_nullable_to_non_nullable
as double,currentTool: null == currentTool ? _self.currentTool : currentTool // ignore: cast_nullable_to_non_nullable
as EditorTool,currentPathPoints: null == currentPathPoints ? _self._currentPathPoints : currentPathPoints // ignore: cast_nullable_to_non_nullable
as List<Offset>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res>? get project {
    if (_self.project == null) {
    return null;
  }

  return $ProjectCopyWith<$Res>(_self.project!, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}

// dart format on
