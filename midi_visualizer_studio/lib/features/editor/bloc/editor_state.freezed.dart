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

 EditorStatus get status; Project? get project; EditorMode get mode; EditorTool get currentTool; double get zoomLevel; Offset get viewOffset; Size get viewportSize; List<Offset> get currentPathPoints; Offset? get drawingStartPoint; Rect? get currentDrawingRect; bool get showGrid; bool get snapToGrid; double get gridSize; int get floodFillTolerance; Set<String> get selectedComponentIds; Set<String> get activeComponentIds; String? get lastSelectedId; String? get errorMessage; bool get isInteractingWithInspector; bool get hasUnsavedChanges; Project? get tempProject;
/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditorStateCopyWith<EditorState> get copyWith => _$EditorStateCopyWithImpl<EditorState>(this as EditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditorState&&(identical(other.status, status) || other.status == status)&&(identical(other.project, project) || other.project == project)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.currentTool, currentTool) || other.currentTool == currentTool)&&(identical(other.zoomLevel, zoomLevel) || other.zoomLevel == zoomLevel)&&(identical(other.viewOffset, viewOffset) || other.viewOffset == viewOffset)&&(identical(other.viewportSize, viewportSize) || other.viewportSize == viewportSize)&&const DeepCollectionEquality().equals(other.currentPathPoints, currentPathPoints)&&(identical(other.drawingStartPoint, drawingStartPoint) || other.drawingStartPoint == drawingStartPoint)&&(identical(other.currentDrawingRect, currentDrawingRect) || other.currentDrawingRect == currentDrawingRect)&&(identical(other.showGrid, showGrid) || other.showGrid == showGrid)&&(identical(other.snapToGrid, snapToGrid) || other.snapToGrid == snapToGrid)&&(identical(other.gridSize, gridSize) || other.gridSize == gridSize)&&(identical(other.floodFillTolerance, floodFillTolerance) || other.floodFillTolerance == floodFillTolerance)&&const DeepCollectionEquality().equals(other.selectedComponentIds, selectedComponentIds)&&const DeepCollectionEquality().equals(other.activeComponentIds, activeComponentIds)&&(identical(other.lastSelectedId, lastSelectedId) || other.lastSelectedId == lastSelectedId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isInteractingWithInspector, isInteractingWithInspector) || other.isInteractingWithInspector == isInteractingWithInspector)&&(identical(other.hasUnsavedChanges, hasUnsavedChanges) || other.hasUnsavedChanges == hasUnsavedChanges)&&(identical(other.tempProject, tempProject) || other.tempProject == tempProject));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,project,mode,currentTool,zoomLevel,viewOffset,viewportSize,const DeepCollectionEquality().hash(currentPathPoints),drawingStartPoint,currentDrawingRect,showGrid,snapToGrid,gridSize,floodFillTolerance,const DeepCollectionEquality().hash(selectedComponentIds),const DeepCollectionEquality().hash(activeComponentIds),lastSelectedId,errorMessage,isInteractingWithInspector,hasUnsavedChanges,tempProject]);

@override
String toString() {
  return 'EditorState(status: $status, project: $project, mode: $mode, currentTool: $currentTool, zoomLevel: $zoomLevel, viewOffset: $viewOffset, viewportSize: $viewportSize, currentPathPoints: $currentPathPoints, drawingStartPoint: $drawingStartPoint, currentDrawingRect: $currentDrawingRect, showGrid: $showGrid, snapToGrid: $snapToGrid, gridSize: $gridSize, floodFillTolerance: $floodFillTolerance, selectedComponentIds: $selectedComponentIds, activeComponentIds: $activeComponentIds, lastSelectedId: $lastSelectedId, errorMessage: $errorMessage, isInteractingWithInspector: $isInteractingWithInspector, hasUnsavedChanges: $hasUnsavedChanges, tempProject: $tempProject)';
}


}

/// @nodoc
abstract mixin class $EditorStateCopyWith<$Res>  {
  factory $EditorStateCopyWith(EditorState value, $Res Function(EditorState) _then) = _$EditorStateCopyWithImpl;
@useResult
$Res call({
 EditorStatus status, Project? project, EditorMode mode, EditorTool currentTool, double zoomLevel, Offset viewOffset, Size viewportSize, List<Offset> currentPathPoints, Offset? drawingStartPoint, Rect? currentDrawingRect, bool showGrid, bool snapToGrid, double gridSize, int floodFillTolerance, Set<String> selectedComponentIds, Set<String> activeComponentIds, String? lastSelectedId, String? errorMessage, bool isInteractingWithInspector, bool hasUnsavedChanges, Project? tempProject
});


$ProjectCopyWith<$Res>? get project;$ProjectCopyWith<$Res>? get tempProject;

}
/// @nodoc
class _$EditorStateCopyWithImpl<$Res>
    implements $EditorStateCopyWith<$Res> {
  _$EditorStateCopyWithImpl(this._self, this._then);

  final EditorState _self;
  final $Res Function(EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? project = freezed,Object? mode = null,Object? currentTool = null,Object? zoomLevel = null,Object? viewOffset = null,Object? viewportSize = null,Object? currentPathPoints = null,Object? drawingStartPoint = freezed,Object? currentDrawingRect = freezed,Object? showGrid = null,Object? snapToGrid = null,Object? gridSize = null,Object? floodFillTolerance = null,Object? selectedComponentIds = null,Object? activeComponentIds = null,Object? lastSelectedId = freezed,Object? errorMessage = freezed,Object? isInteractingWithInspector = null,Object? hasUnsavedChanges = null,Object? tempProject = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EditorStatus,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as EditorMode,currentTool: null == currentTool ? _self.currentTool : currentTool // ignore: cast_nullable_to_non_nullable
as EditorTool,zoomLevel: null == zoomLevel ? _self.zoomLevel : zoomLevel // ignore: cast_nullable_to_non_nullable
as double,viewOffset: null == viewOffset ? _self.viewOffset : viewOffset // ignore: cast_nullable_to_non_nullable
as Offset,viewportSize: null == viewportSize ? _self.viewportSize : viewportSize // ignore: cast_nullable_to_non_nullable
as Size,currentPathPoints: null == currentPathPoints ? _self.currentPathPoints : currentPathPoints // ignore: cast_nullable_to_non_nullable
as List<Offset>,drawingStartPoint: freezed == drawingStartPoint ? _self.drawingStartPoint : drawingStartPoint // ignore: cast_nullable_to_non_nullable
as Offset?,currentDrawingRect: freezed == currentDrawingRect ? _self.currentDrawingRect : currentDrawingRect // ignore: cast_nullable_to_non_nullable
as Rect?,showGrid: null == showGrid ? _self.showGrid : showGrid // ignore: cast_nullable_to_non_nullable
as bool,snapToGrid: null == snapToGrid ? _self.snapToGrid : snapToGrid // ignore: cast_nullable_to_non_nullable
as bool,gridSize: null == gridSize ? _self.gridSize : gridSize // ignore: cast_nullable_to_non_nullable
as double,floodFillTolerance: null == floodFillTolerance ? _self.floodFillTolerance : floodFillTolerance // ignore: cast_nullable_to_non_nullable
as int,selectedComponentIds: null == selectedComponentIds ? _self.selectedComponentIds : selectedComponentIds // ignore: cast_nullable_to_non_nullable
as Set<String>,activeComponentIds: null == activeComponentIds ? _self.activeComponentIds : activeComponentIds // ignore: cast_nullable_to_non_nullable
as Set<String>,lastSelectedId: freezed == lastSelectedId ? _self.lastSelectedId : lastSelectedId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isInteractingWithInspector: null == isInteractingWithInspector ? _self.isInteractingWithInspector : isInteractingWithInspector // ignore: cast_nullable_to_non_nullable
as bool,hasUnsavedChanges: null == hasUnsavedChanges ? _self.hasUnsavedChanges : hasUnsavedChanges // ignore: cast_nullable_to_non_nullable
as bool,tempProject: freezed == tempProject ? _self.tempProject : tempProject // ignore: cast_nullable_to_non_nullable
as Project?,
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
}/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res>? get tempProject {
    if (_self.tempProject == null) {
    return null;
  }

  return $ProjectCopyWith<$Res>(_self.tempProject!, (value) {
    return _then(_self.copyWith(tempProject: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EditorStatus status,  Project? project,  EditorMode mode,  EditorTool currentTool,  double zoomLevel,  Offset viewOffset,  Size viewportSize,  List<Offset> currentPathPoints,  Offset? drawingStartPoint,  Rect? currentDrawingRect,  bool showGrid,  bool snapToGrid,  double gridSize,  int floodFillTolerance,  Set<String> selectedComponentIds,  Set<String> activeComponentIds,  String? lastSelectedId,  String? errorMessage,  bool isInteractingWithInspector,  bool hasUnsavedChanges,  Project? tempProject)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.status,_that.project,_that.mode,_that.currentTool,_that.zoomLevel,_that.viewOffset,_that.viewportSize,_that.currentPathPoints,_that.drawingStartPoint,_that.currentDrawingRect,_that.showGrid,_that.snapToGrid,_that.gridSize,_that.floodFillTolerance,_that.selectedComponentIds,_that.activeComponentIds,_that.lastSelectedId,_that.errorMessage,_that.isInteractingWithInspector,_that.hasUnsavedChanges,_that.tempProject);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EditorStatus status,  Project? project,  EditorMode mode,  EditorTool currentTool,  double zoomLevel,  Offset viewOffset,  Size viewportSize,  List<Offset> currentPathPoints,  Offset? drawingStartPoint,  Rect? currentDrawingRect,  bool showGrid,  bool snapToGrid,  double gridSize,  int floodFillTolerance,  Set<String> selectedComponentIds,  Set<String> activeComponentIds,  String? lastSelectedId,  String? errorMessage,  bool isInteractingWithInspector,  bool hasUnsavedChanges,  Project? tempProject)  $default,) {final _that = this;
switch (_that) {
case _EditorState():
return $default(_that.status,_that.project,_that.mode,_that.currentTool,_that.zoomLevel,_that.viewOffset,_that.viewportSize,_that.currentPathPoints,_that.drawingStartPoint,_that.currentDrawingRect,_that.showGrid,_that.snapToGrid,_that.gridSize,_that.floodFillTolerance,_that.selectedComponentIds,_that.activeComponentIds,_that.lastSelectedId,_that.errorMessage,_that.isInteractingWithInspector,_that.hasUnsavedChanges,_that.tempProject);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EditorStatus status,  Project? project,  EditorMode mode,  EditorTool currentTool,  double zoomLevel,  Offset viewOffset,  Size viewportSize,  List<Offset> currentPathPoints,  Offset? drawingStartPoint,  Rect? currentDrawingRect,  bool showGrid,  bool snapToGrid,  double gridSize,  int floodFillTolerance,  Set<String> selectedComponentIds,  Set<String> activeComponentIds,  String? lastSelectedId,  String? errorMessage,  bool isInteractingWithInspector,  bool hasUnsavedChanges,  Project? tempProject)?  $default,) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.status,_that.project,_that.mode,_that.currentTool,_that.zoomLevel,_that.viewOffset,_that.viewportSize,_that.currentPathPoints,_that.drawingStartPoint,_that.currentDrawingRect,_that.showGrid,_that.snapToGrid,_that.gridSize,_that.floodFillTolerance,_that.selectedComponentIds,_that.activeComponentIds,_that.lastSelectedId,_that.errorMessage,_that.isInteractingWithInspector,_that.hasUnsavedChanges,_that.tempProject);case _:
  return null;

}
}

}

/// @nodoc


class _EditorState implements EditorState {
  const _EditorState({this.status = EditorStatus.initial, this.project, this.mode = EditorMode.edit, this.currentTool = EditorTool.select, this.zoomLevel = 1.0, this.viewOffset = Offset.zero, this.viewportSize = Size.zero, final  List<Offset> currentPathPoints = const [], this.drawingStartPoint, this.currentDrawingRect, this.showGrid = true, this.snapToGrid = true, this.gridSize = 10.0, this.floodFillTolerance = 10, final  Set<String> selectedComponentIds = const {}, final  Set<String> activeComponentIds = const {}, this.lastSelectedId, this.errorMessage, this.isInteractingWithInspector = false, this.hasUnsavedChanges = false, this.tempProject}): _currentPathPoints = currentPathPoints,_selectedComponentIds = selectedComponentIds,_activeComponentIds = activeComponentIds;
  

@override@JsonKey() final  EditorStatus status;
@override final  Project? project;
@override@JsonKey() final  EditorMode mode;
@override@JsonKey() final  EditorTool currentTool;
@override@JsonKey() final  double zoomLevel;
@override@JsonKey() final  Offset viewOffset;
@override@JsonKey() final  Size viewportSize;
 final  List<Offset> _currentPathPoints;
@override@JsonKey() List<Offset> get currentPathPoints {
  if (_currentPathPoints is EqualUnmodifiableListView) return _currentPathPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentPathPoints);
}

@override final  Offset? drawingStartPoint;
@override final  Rect? currentDrawingRect;
@override@JsonKey() final  bool showGrid;
@override@JsonKey() final  bool snapToGrid;
@override@JsonKey() final  double gridSize;
@override@JsonKey() final  int floodFillTolerance;
 final  Set<String> _selectedComponentIds;
@override@JsonKey() Set<String> get selectedComponentIds {
  if (_selectedComponentIds is EqualUnmodifiableSetView) return _selectedComponentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedComponentIds);
}

 final  Set<String> _activeComponentIds;
@override@JsonKey() Set<String> get activeComponentIds {
  if (_activeComponentIds is EqualUnmodifiableSetView) return _activeComponentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_activeComponentIds);
}

@override final  String? lastSelectedId;
@override final  String? errorMessage;
@override@JsonKey() final  bool isInteractingWithInspector;
@override@JsonKey() final  bool hasUnsavedChanges;
@override final  Project? tempProject;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditorStateCopyWith<_EditorState> get copyWith => __$EditorStateCopyWithImpl<_EditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditorState&&(identical(other.status, status) || other.status == status)&&(identical(other.project, project) || other.project == project)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.currentTool, currentTool) || other.currentTool == currentTool)&&(identical(other.zoomLevel, zoomLevel) || other.zoomLevel == zoomLevel)&&(identical(other.viewOffset, viewOffset) || other.viewOffset == viewOffset)&&(identical(other.viewportSize, viewportSize) || other.viewportSize == viewportSize)&&const DeepCollectionEquality().equals(other._currentPathPoints, _currentPathPoints)&&(identical(other.drawingStartPoint, drawingStartPoint) || other.drawingStartPoint == drawingStartPoint)&&(identical(other.currentDrawingRect, currentDrawingRect) || other.currentDrawingRect == currentDrawingRect)&&(identical(other.showGrid, showGrid) || other.showGrid == showGrid)&&(identical(other.snapToGrid, snapToGrid) || other.snapToGrid == snapToGrid)&&(identical(other.gridSize, gridSize) || other.gridSize == gridSize)&&(identical(other.floodFillTolerance, floodFillTolerance) || other.floodFillTolerance == floodFillTolerance)&&const DeepCollectionEquality().equals(other._selectedComponentIds, _selectedComponentIds)&&const DeepCollectionEquality().equals(other._activeComponentIds, _activeComponentIds)&&(identical(other.lastSelectedId, lastSelectedId) || other.lastSelectedId == lastSelectedId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isInteractingWithInspector, isInteractingWithInspector) || other.isInteractingWithInspector == isInteractingWithInspector)&&(identical(other.hasUnsavedChanges, hasUnsavedChanges) || other.hasUnsavedChanges == hasUnsavedChanges)&&(identical(other.tempProject, tempProject) || other.tempProject == tempProject));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,project,mode,currentTool,zoomLevel,viewOffset,viewportSize,const DeepCollectionEquality().hash(_currentPathPoints),drawingStartPoint,currentDrawingRect,showGrid,snapToGrid,gridSize,floodFillTolerance,const DeepCollectionEquality().hash(_selectedComponentIds),const DeepCollectionEquality().hash(_activeComponentIds),lastSelectedId,errorMessage,isInteractingWithInspector,hasUnsavedChanges,tempProject]);

@override
String toString() {
  return 'EditorState(status: $status, project: $project, mode: $mode, currentTool: $currentTool, zoomLevel: $zoomLevel, viewOffset: $viewOffset, viewportSize: $viewportSize, currentPathPoints: $currentPathPoints, drawingStartPoint: $drawingStartPoint, currentDrawingRect: $currentDrawingRect, showGrid: $showGrid, snapToGrid: $snapToGrid, gridSize: $gridSize, floodFillTolerance: $floodFillTolerance, selectedComponentIds: $selectedComponentIds, activeComponentIds: $activeComponentIds, lastSelectedId: $lastSelectedId, errorMessage: $errorMessage, isInteractingWithInspector: $isInteractingWithInspector, hasUnsavedChanges: $hasUnsavedChanges, tempProject: $tempProject)';
}


}

/// @nodoc
abstract mixin class _$EditorStateCopyWith<$Res> implements $EditorStateCopyWith<$Res> {
  factory _$EditorStateCopyWith(_EditorState value, $Res Function(_EditorState) _then) = __$EditorStateCopyWithImpl;
@override @useResult
$Res call({
 EditorStatus status, Project? project, EditorMode mode, EditorTool currentTool, double zoomLevel, Offset viewOffset, Size viewportSize, List<Offset> currentPathPoints, Offset? drawingStartPoint, Rect? currentDrawingRect, bool showGrid, bool snapToGrid, double gridSize, int floodFillTolerance, Set<String> selectedComponentIds, Set<String> activeComponentIds, String? lastSelectedId, String? errorMessage, bool isInteractingWithInspector, bool hasUnsavedChanges, Project? tempProject
});


@override $ProjectCopyWith<$Res>? get project;@override $ProjectCopyWith<$Res>? get tempProject;

}
/// @nodoc
class __$EditorStateCopyWithImpl<$Res>
    implements _$EditorStateCopyWith<$Res> {
  __$EditorStateCopyWithImpl(this._self, this._then);

  final _EditorState _self;
  final $Res Function(_EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? project = freezed,Object? mode = null,Object? currentTool = null,Object? zoomLevel = null,Object? viewOffset = null,Object? viewportSize = null,Object? currentPathPoints = null,Object? drawingStartPoint = freezed,Object? currentDrawingRect = freezed,Object? showGrid = null,Object? snapToGrid = null,Object? gridSize = null,Object? floodFillTolerance = null,Object? selectedComponentIds = null,Object? activeComponentIds = null,Object? lastSelectedId = freezed,Object? errorMessage = freezed,Object? isInteractingWithInspector = null,Object? hasUnsavedChanges = null,Object? tempProject = freezed,}) {
  return _then(_EditorState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EditorStatus,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as EditorMode,currentTool: null == currentTool ? _self.currentTool : currentTool // ignore: cast_nullable_to_non_nullable
as EditorTool,zoomLevel: null == zoomLevel ? _self.zoomLevel : zoomLevel // ignore: cast_nullable_to_non_nullable
as double,viewOffset: null == viewOffset ? _self.viewOffset : viewOffset // ignore: cast_nullable_to_non_nullable
as Offset,viewportSize: null == viewportSize ? _self.viewportSize : viewportSize // ignore: cast_nullable_to_non_nullable
as Size,currentPathPoints: null == currentPathPoints ? _self._currentPathPoints : currentPathPoints // ignore: cast_nullable_to_non_nullable
as List<Offset>,drawingStartPoint: freezed == drawingStartPoint ? _self.drawingStartPoint : drawingStartPoint // ignore: cast_nullable_to_non_nullable
as Offset?,currentDrawingRect: freezed == currentDrawingRect ? _self.currentDrawingRect : currentDrawingRect // ignore: cast_nullable_to_non_nullable
as Rect?,showGrid: null == showGrid ? _self.showGrid : showGrid // ignore: cast_nullable_to_non_nullable
as bool,snapToGrid: null == snapToGrid ? _self.snapToGrid : snapToGrid // ignore: cast_nullable_to_non_nullable
as bool,gridSize: null == gridSize ? _self.gridSize : gridSize // ignore: cast_nullable_to_non_nullable
as double,floodFillTolerance: null == floodFillTolerance ? _self.floodFillTolerance : floodFillTolerance // ignore: cast_nullable_to_non_nullable
as int,selectedComponentIds: null == selectedComponentIds ? _self._selectedComponentIds : selectedComponentIds // ignore: cast_nullable_to_non_nullable
as Set<String>,activeComponentIds: null == activeComponentIds ? _self._activeComponentIds : activeComponentIds // ignore: cast_nullable_to_non_nullable
as Set<String>,lastSelectedId: freezed == lastSelectedId ? _self.lastSelectedId : lastSelectedId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isInteractingWithInspector: null == isInteractingWithInspector ? _self.isInteractingWithInspector : isInteractingWithInspector // ignore: cast_nullable_to_non_nullable
as bool,hasUnsavedChanges: null == hasUnsavedChanges ? _self.hasUnsavedChanges : hasUnsavedChanges // ignore: cast_nullable_to_non_nullable
as bool,tempProject: freezed == tempProject ? _self.tempProject : tempProject // ignore: cast_nullable_to_non_nullable
as Project?,
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
}/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res>? get tempProject {
    if (_self.tempProject == null) {
    return null;
  }

  return $ProjectCopyWith<$Res>(_self.tempProject!, (value) {
    return _then(_self.copyWith(tempProject: value));
  });
}
}

// dart format on
