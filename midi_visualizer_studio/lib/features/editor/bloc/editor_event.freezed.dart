// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditorEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditorEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent()';
}


}

/// @nodoc
class $EditorEventCopyWith<$Res>  {
$EditorEventCopyWith(EditorEvent _, $Res Function(EditorEvent) __);
}


/// Adds pattern-matching-related methods to [EditorEvent].
extension EditorEventPatterns on EditorEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadProject value)?  loadProject,TResult Function( UpdateViewTransform value)?  updateViewTransform,TResult Function( UpdateViewportSize value)?  updateViewportSize,TResult Function( CenterOnContent value)?  centerOnContent,TResult Function( AddComponent value)?  addComponent,TResult Function( UpdateComponent value)?  updateComponent,TResult Function( UpdateComponents value)?  updateComponents,TResult Function( SelectComponent value)?  selectComponent,TResult Function( SelectComponents value)?  selectComponents,TResult Function( ReorderComponent value)?  reorderComponent,TResult Function( UpdateProjectSettings value)?  updateProjectSettings,TResult Function( ToggleMode value)?  toggleMode,TResult Function( SetZoom value)?  setZoom,TResult Function( ZoomIn value)?  zoomIn,TResult Function( ZoomOut value)?  zoomOut,TResult Function( SelectTool value)?  selectTool,TResult Function( AddPathPoint value)?  addPathPoint,TResult Function( FinishPath value)?  finishPath,TResult Function( CancelPath value)?  cancelPath,TResult Function( RestoreProject value)?  restoreProject,TResult Function( UndoEvent value)?  undo,TResult Function( RedoEvent value)?  redo,TResult Function( ToggleGrid value)?  toggleGrid,TResult Function( ToggleSnapToGrid value)?  toggleSnapToGrid,TResult Function( SetGridSize value)?  setGridSize,TResult Function( HandleMidiMessage value)?  handleMidiMessage,TResult Function( SaveProject value)?  saveProject,TResult Function( ExportProject value)?  exportProject,TResult Function( FillImageArea value)?  fillImageArea,TResult Function( SetFloodFillTolerance value)?  setFloodFillTolerance,TResult Function( CopyEvent value)?  copy,TResult Function( PasteEvent value)?  paste,TResult Function( CutEvent value)?  cut,TResult Function( DeleteEvent value)?  delete,TResult Function( DuplicateEvent value)?  duplicate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that);case UpdateViewTransform() when updateViewTransform != null:
return updateViewTransform(_that);case UpdateViewportSize() when updateViewportSize != null:
return updateViewportSize(_that);case CenterOnContent() when centerOnContent != null:
return centerOnContent(_that);case AddComponent() when addComponent != null:
return addComponent(_that);case UpdateComponent() when updateComponent != null:
return updateComponent(_that);case UpdateComponents() when updateComponents != null:
return updateComponents(_that);case SelectComponent() when selectComponent != null:
return selectComponent(_that);case SelectComponents() when selectComponents != null:
return selectComponents(_that);case ReorderComponent() when reorderComponent != null:
return reorderComponent(_that);case UpdateProjectSettings() when updateProjectSettings != null:
return updateProjectSettings(_that);case ToggleMode() when toggleMode != null:
return toggleMode(_that);case SetZoom() when setZoom != null:
return setZoom(_that);case ZoomIn() when zoomIn != null:
return zoomIn(_that);case ZoomOut() when zoomOut != null:
return zoomOut(_that);case SelectTool() when selectTool != null:
return selectTool(_that);case AddPathPoint() when addPathPoint != null:
return addPathPoint(_that);case FinishPath() when finishPath != null:
return finishPath(_that);case CancelPath() when cancelPath != null:
return cancelPath(_that);case RestoreProject() when restoreProject != null:
return restoreProject(_that);case UndoEvent() when undo != null:
return undo(_that);case RedoEvent() when redo != null:
return redo(_that);case ToggleGrid() when toggleGrid != null:
return toggleGrid(_that);case ToggleSnapToGrid() when toggleSnapToGrid != null:
return toggleSnapToGrid(_that);case SetGridSize() when setGridSize != null:
return setGridSize(_that);case HandleMidiMessage() when handleMidiMessage != null:
return handleMidiMessage(_that);case SaveProject() when saveProject != null:
return saveProject(_that);case ExportProject() when exportProject != null:
return exportProject(_that);case FillImageArea() when fillImageArea != null:
return fillImageArea(_that);case SetFloodFillTolerance() when setFloodFillTolerance != null:
return setFloodFillTolerance(_that);case CopyEvent() when copy != null:
return copy(_that);case PasteEvent() when paste != null:
return paste(_that);case CutEvent() when cut != null:
return cut(_that);case DeleteEvent() when delete != null:
return delete(_that);case DuplicateEvent() when duplicate != null:
return duplicate(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadProject value)  loadProject,required TResult Function( UpdateViewTransform value)  updateViewTransform,required TResult Function( UpdateViewportSize value)  updateViewportSize,required TResult Function( CenterOnContent value)  centerOnContent,required TResult Function( AddComponent value)  addComponent,required TResult Function( UpdateComponent value)  updateComponent,required TResult Function( UpdateComponents value)  updateComponents,required TResult Function( SelectComponent value)  selectComponent,required TResult Function( SelectComponents value)  selectComponents,required TResult Function( ReorderComponent value)  reorderComponent,required TResult Function( UpdateProjectSettings value)  updateProjectSettings,required TResult Function( ToggleMode value)  toggleMode,required TResult Function( SetZoom value)  setZoom,required TResult Function( ZoomIn value)  zoomIn,required TResult Function( ZoomOut value)  zoomOut,required TResult Function( SelectTool value)  selectTool,required TResult Function( AddPathPoint value)  addPathPoint,required TResult Function( FinishPath value)  finishPath,required TResult Function( CancelPath value)  cancelPath,required TResult Function( RestoreProject value)  restoreProject,required TResult Function( UndoEvent value)  undo,required TResult Function( RedoEvent value)  redo,required TResult Function( ToggleGrid value)  toggleGrid,required TResult Function( ToggleSnapToGrid value)  toggleSnapToGrid,required TResult Function( SetGridSize value)  setGridSize,required TResult Function( HandleMidiMessage value)  handleMidiMessage,required TResult Function( SaveProject value)  saveProject,required TResult Function( ExportProject value)  exportProject,required TResult Function( FillImageArea value)  fillImageArea,required TResult Function( SetFloodFillTolerance value)  setFloodFillTolerance,required TResult Function( CopyEvent value)  copy,required TResult Function( PasteEvent value)  paste,required TResult Function( CutEvent value)  cut,required TResult Function( DeleteEvent value)  delete,required TResult Function( DuplicateEvent value)  duplicate,}){
final _that = this;
switch (_that) {
case LoadProject():
return loadProject(_that);case UpdateViewTransform():
return updateViewTransform(_that);case UpdateViewportSize():
return updateViewportSize(_that);case CenterOnContent():
return centerOnContent(_that);case AddComponent():
return addComponent(_that);case UpdateComponent():
return updateComponent(_that);case UpdateComponents():
return updateComponents(_that);case SelectComponent():
return selectComponent(_that);case SelectComponents():
return selectComponents(_that);case ReorderComponent():
return reorderComponent(_that);case UpdateProjectSettings():
return updateProjectSettings(_that);case ToggleMode():
return toggleMode(_that);case SetZoom():
return setZoom(_that);case ZoomIn():
return zoomIn(_that);case ZoomOut():
return zoomOut(_that);case SelectTool():
return selectTool(_that);case AddPathPoint():
return addPathPoint(_that);case FinishPath():
return finishPath(_that);case CancelPath():
return cancelPath(_that);case RestoreProject():
return restoreProject(_that);case UndoEvent():
return undo(_that);case RedoEvent():
return redo(_that);case ToggleGrid():
return toggleGrid(_that);case ToggleSnapToGrid():
return toggleSnapToGrid(_that);case SetGridSize():
return setGridSize(_that);case HandleMidiMessage():
return handleMidiMessage(_that);case SaveProject():
return saveProject(_that);case ExportProject():
return exportProject(_that);case FillImageArea():
return fillImageArea(_that);case SetFloodFillTolerance():
return setFloodFillTolerance(_that);case CopyEvent():
return copy(_that);case PasteEvent():
return paste(_that);case CutEvent():
return cut(_that);case DeleteEvent():
return delete(_that);case DuplicateEvent():
return duplicate(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadProject value)?  loadProject,TResult? Function( UpdateViewTransform value)?  updateViewTransform,TResult? Function( UpdateViewportSize value)?  updateViewportSize,TResult? Function( CenterOnContent value)?  centerOnContent,TResult? Function( AddComponent value)?  addComponent,TResult? Function( UpdateComponent value)?  updateComponent,TResult? Function( UpdateComponents value)?  updateComponents,TResult? Function( SelectComponent value)?  selectComponent,TResult? Function( SelectComponents value)?  selectComponents,TResult? Function( ReorderComponent value)?  reorderComponent,TResult? Function( UpdateProjectSettings value)?  updateProjectSettings,TResult? Function( ToggleMode value)?  toggleMode,TResult? Function( SetZoom value)?  setZoom,TResult? Function( ZoomIn value)?  zoomIn,TResult? Function( ZoomOut value)?  zoomOut,TResult? Function( SelectTool value)?  selectTool,TResult? Function( AddPathPoint value)?  addPathPoint,TResult? Function( FinishPath value)?  finishPath,TResult? Function( CancelPath value)?  cancelPath,TResult? Function( RestoreProject value)?  restoreProject,TResult? Function( UndoEvent value)?  undo,TResult? Function( RedoEvent value)?  redo,TResult? Function( ToggleGrid value)?  toggleGrid,TResult? Function( ToggleSnapToGrid value)?  toggleSnapToGrid,TResult? Function( SetGridSize value)?  setGridSize,TResult? Function( HandleMidiMessage value)?  handleMidiMessage,TResult? Function( SaveProject value)?  saveProject,TResult? Function( ExportProject value)?  exportProject,TResult? Function( FillImageArea value)?  fillImageArea,TResult? Function( SetFloodFillTolerance value)?  setFloodFillTolerance,TResult? Function( CopyEvent value)?  copy,TResult? Function( PasteEvent value)?  paste,TResult? Function( CutEvent value)?  cut,TResult? Function( DeleteEvent value)?  delete,TResult? Function( DuplicateEvent value)?  duplicate,}){
final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that);case UpdateViewTransform() when updateViewTransform != null:
return updateViewTransform(_that);case UpdateViewportSize() when updateViewportSize != null:
return updateViewportSize(_that);case CenterOnContent() when centerOnContent != null:
return centerOnContent(_that);case AddComponent() when addComponent != null:
return addComponent(_that);case UpdateComponent() when updateComponent != null:
return updateComponent(_that);case UpdateComponents() when updateComponents != null:
return updateComponents(_that);case SelectComponent() when selectComponent != null:
return selectComponent(_that);case SelectComponents() when selectComponents != null:
return selectComponents(_that);case ReorderComponent() when reorderComponent != null:
return reorderComponent(_that);case UpdateProjectSettings() when updateProjectSettings != null:
return updateProjectSettings(_that);case ToggleMode() when toggleMode != null:
return toggleMode(_that);case SetZoom() when setZoom != null:
return setZoom(_that);case ZoomIn() when zoomIn != null:
return zoomIn(_that);case ZoomOut() when zoomOut != null:
return zoomOut(_that);case SelectTool() when selectTool != null:
return selectTool(_that);case AddPathPoint() when addPathPoint != null:
return addPathPoint(_that);case FinishPath() when finishPath != null:
return finishPath(_that);case CancelPath() when cancelPath != null:
return cancelPath(_that);case RestoreProject() when restoreProject != null:
return restoreProject(_that);case UndoEvent() when undo != null:
return undo(_that);case RedoEvent() when redo != null:
return redo(_that);case ToggleGrid() when toggleGrid != null:
return toggleGrid(_that);case ToggleSnapToGrid() when toggleSnapToGrid != null:
return toggleSnapToGrid(_that);case SetGridSize() when setGridSize != null:
return setGridSize(_that);case HandleMidiMessage() when handleMidiMessage != null:
return handleMidiMessage(_that);case SaveProject() when saveProject != null:
return saveProject(_that);case ExportProject() when exportProject != null:
return exportProject(_that);case FillImageArea() when fillImageArea != null:
return fillImageArea(_that);case SetFloodFillTolerance() when setFloodFillTolerance != null:
return setFloodFillTolerance(_that);case CopyEvent() when copy != null:
return copy(_that);case PasteEvent() when paste != null:
return paste(_that);case CutEvent() when cut != null:
return cut(_that);case DeleteEvent() when delete != null:
return delete(_that);case DuplicateEvent() when duplicate != null:
return duplicate(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Project? project,  String path)?  loadProject,TResult Function( double zoom,  Offset offset)?  updateViewTransform,TResult Function( Size size)?  updateViewportSize,TResult Function()?  centerOnContent,TResult Function( Component component)?  addComponent,TResult Function( String id,  Component component)?  updateComponent,TResult Function( List<Component> components)?  updateComponents,TResult Function( String id,  bool multiSelect)?  selectComponent,TResult Function( List<String> ids,  bool multiSelect)?  selectComponents,TResult Function( int oldIndex,  int newIndex)?  reorderComponent,TResult Function( Project project)?  updateProjectSettings,TResult Function( EditorMode mode)?  toggleMode,TResult Function( double zoom)?  setZoom,TResult Function()?  zoomIn,TResult Function()?  zoomOut,TResult Function( EditorTool tool)?  selectTool,TResult Function( Offset point)?  addPathPoint,TResult Function()?  finishPath,TResult Function()?  cancelPath,TResult Function( Project project)?  restoreProject,TResult Function()?  undo,TResult Function()?  redo,TResult Function()?  toggleGrid,TResult Function()?  toggleSnapToGrid,TResult Function( double size)?  setGridSize,TResult Function( MidiPacket packet)?  handleMidiMessage,TResult Function()?  saveProject,TResult Function( String path)?  exportProject,TResult Function( String componentId,  Offset position,  Color color)?  fillImageArea,TResult Function( int tolerance)?  setFloodFillTolerance,TResult Function()?  copy,TResult Function()?  paste,TResult Function()?  cut,TResult Function()?  delete,TResult Function()?  duplicate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that.project,_that.path);case UpdateViewTransform() when updateViewTransform != null:
return updateViewTransform(_that.zoom,_that.offset);case UpdateViewportSize() when updateViewportSize != null:
return updateViewportSize(_that.size);case CenterOnContent() when centerOnContent != null:
return centerOnContent();case AddComponent() when addComponent != null:
return addComponent(_that.component);case UpdateComponent() when updateComponent != null:
return updateComponent(_that.id,_that.component);case UpdateComponents() when updateComponents != null:
return updateComponents(_that.components);case SelectComponent() when selectComponent != null:
return selectComponent(_that.id,_that.multiSelect);case SelectComponents() when selectComponents != null:
return selectComponents(_that.ids,_that.multiSelect);case ReorderComponent() when reorderComponent != null:
return reorderComponent(_that.oldIndex,_that.newIndex);case UpdateProjectSettings() when updateProjectSettings != null:
return updateProjectSettings(_that.project);case ToggleMode() when toggleMode != null:
return toggleMode(_that.mode);case SetZoom() when setZoom != null:
return setZoom(_that.zoom);case ZoomIn() when zoomIn != null:
return zoomIn();case ZoomOut() when zoomOut != null:
return zoomOut();case SelectTool() when selectTool != null:
return selectTool(_that.tool);case AddPathPoint() when addPathPoint != null:
return addPathPoint(_that.point);case FinishPath() when finishPath != null:
return finishPath();case CancelPath() when cancelPath != null:
return cancelPath();case RestoreProject() when restoreProject != null:
return restoreProject(_that.project);case UndoEvent() when undo != null:
return undo();case RedoEvent() when redo != null:
return redo();case ToggleGrid() when toggleGrid != null:
return toggleGrid();case ToggleSnapToGrid() when toggleSnapToGrid != null:
return toggleSnapToGrid();case SetGridSize() when setGridSize != null:
return setGridSize(_that.size);case HandleMidiMessage() when handleMidiMessage != null:
return handleMidiMessage(_that.packet);case SaveProject() when saveProject != null:
return saveProject();case ExportProject() when exportProject != null:
return exportProject(_that.path);case FillImageArea() when fillImageArea != null:
return fillImageArea(_that.componentId,_that.position,_that.color);case SetFloodFillTolerance() when setFloodFillTolerance != null:
return setFloodFillTolerance(_that.tolerance);case CopyEvent() when copy != null:
return copy();case PasteEvent() when paste != null:
return paste();case CutEvent() when cut != null:
return cut();case DeleteEvent() when delete != null:
return delete();case DuplicateEvent() when duplicate != null:
return duplicate();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Project? project,  String path)  loadProject,required TResult Function( double zoom,  Offset offset)  updateViewTransform,required TResult Function( Size size)  updateViewportSize,required TResult Function()  centerOnContent,required TResult Function( Component component)  addComponent,required TResult Function( String id,  Component component)  updateComponent,required TResult Function( List<Component> components)  updateComponents,required TResult Function( String id,  bool multiSelect)  selectComponent,required TResult Function( List<String> ids,  bool multiSelect)  selectComponents,required TResult Function( int oldIndex,  int newIndex)  reorderComponent,required TResult Function( Project project)  updateProjectSettings,required TResult Function( EditorMode mode)  toggleMode,required TResult Function( double zoom)  setZoom,required TResult Function()  zoomIn,required TResult Function()  zoomOut,required TResult Function( EditorTool tool)  selectTool,required TResult Function( Offset point)  addPathPoint,required TResult Function()  finishPath,required TResult Function()  cancelPath,required TResult Function( Project project)  restoreProject,required TResult Function()  undo,required TResult Function()  redo,required TResult Function()  toggleGrid,required TResult Function()  toggleSnapToGrid,required TResult Function( double size)  setGridSize,required TResult Function( MidiPacket packet)  handleMidiMessage,required TResult Function()  saveProject,required TResult Function( String path)  exportProject,required TResult Function( String componentId,  Offset position,  Color color)  fillImageArea,required TResult Function( int tolerance)  setFloodFillTolerance,required TResult Function()  copy,required TResult Function()  paste,required TResult Function()  cut,required TResult Function()  delete,required TResult Function()  duplicate,}) {final _that = this;
switch (_that) {
case LoadProject():
return loadProject(_that.project,_that.path);case UpdateViewTransform():
return updateViewTransform(_that.zoom,_that.offset);case UpdateViewportSize():
return updateViewportSize(_that.size);case CenterOnContent():
return centerOnContent();case AddComponent():
return addComponent(_that.component);case UpdateComponent():
return updateComponent(_that.id,_that.component);case UpdateComponents():
return updateComponents(_that.components);case SelectComponent():
return selectComponent(_that.id,_that.multiSelect);case SelectComponents():
return selectComponents(_that.ids,_that.multiSelect);case ReorderComponent():
return reorderComponent(_that.oldIndex,_that.newIndex);case UpdateProjectSettings():
return updateProjectSettings(_that.project);case ToggleMode():
return toggleMode(_that.mode);case SetZoom():
return setZoom(_that.zoom);case ZoomIn():
return zoomIn();case ZoomOut():
return zoomOut();case SelectTool():
return selectTool(_that.tool);case AddPathPoint():
return addPathPoint(_that.point);case FinishPath():
return finishPath();case CancelPath():
return cancelPath();case RestoreProject():
return restoreProject(_that.project);case UndoEvent():
return undo();case RedoEvent():
return redo();case ToggleGrid():
return toggleGrid();case ToggleSnapToGrid():
return toggleSnapToGrid();case SetGridSize():
return setGridSize(_that.size);case HandleMidiMessage():
return handleMidiMessage(_that.packet);case SaveProject():
return saveProject();case ExportProject():
return exportProject(_that.path);case FillImageArea():
return fillImageArea(_that.componentId,_that.position,_that.color);case SetFloodFillTolerance():
return setFloodFillTolerance(_that.tolerance);case CopyEvent():
return copy();case PasteEvent():
return paste();case CutEvent():
return cut();case DeleteEvent():
return delete();case DuplicateEvent():
return duplicate();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Project? project,  String path)?  loadProject,TResult? Function( double zoom,  Offset offset)?  updateViewTransform,TResult? Function( Size size)?  updateViewportSize,TResult? Function()?  centerOnContent,TResult? Function( Component component)?  addComponent,TResult? Function( String id,  Component component)?  updateComponent,TResult? Function( List<Component> components)?  updateComponents,TResult? Function( String id,  bool multiSelect)?  selectComponent,TResult? Function( List<String> ids,  bool multiSelect)?  selectComponents,TResult? Function( int oldIndex,  int newIndex)?  reorderComponent,TResult? Function( Project project)?  updateProjectSettings,TResult? Function( EditorMode mode)?  toggleMode,TResult? Function( double zoom)?  setZoom,TResult? Function()?  zoomIn,TResult? Function()?  zoomOut,TResult? Function( EditorTool tool)?  selectTool,TResult? Function( Offset point)?  addPathPoint,TResult? Function()?  finishPath,TResult? Function()?  cancelPath,TResult? Function( Project project)?  restoreProject,TResult? Function()?  undo,TResult? Function()?  redo,TResult? Function()?  toggleGrid,TResult? Function()?  toggleSnapToGrid,TResult? Function( double size)?  setGridSize,TResult? Function( MidiPacket packet)?  handleMidiMessage,TResult? Function()?  saveProject,TResult? Function( String path)?  exportProject,TResult? Function( String componentId,  Offset position,  Color color)?  fillImageArea,TResult? Function( int tolerance)?  setFloodFillTolerance,TResult? Function()?  copy,TResult? Function()?  paste,TResult? Function()?  cut,TResult? Function()?  delete,TResult? Function()?  duplicate,}) {final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that.project,_that.path);case UpdateViewTransform() when updateViewTransform != null:
return updateViewTransform(_that.zoom,_that.offset);case UpdateViewportSize() when updateViewportSize != null:
return updateViewportSize(_that.size);case CenterOnContent() when centerOnContent != null:
return centerOnContent();case AddComponent() when addComponent != null:
return addComponent(_that.component);case UpdateComponent() when updateComponent != null:
return updateComponent(_that.id,_that.component);case UpdateComponents() when updateComponents != null:
return updateComponents(_that.components);case SelectComponent() when selectComponent != null:
return selectComponent(_that.id,_that.multiSelect);case SelectComponents() when selectComponents != null:
return selectComponents(_that.ids,_that.multiSelect);case ReorderComponent() when reorderComponent != null:
return reorderComponent(_that.oldIndex,_that.newIndex);case UpdateProjectSettings() when updateProjectSettings != null:
return updateProjectSettings(_that.project);case ToggleMode() when toggleMode != null:
return toggleMode(_that.mode);case SetZoom() when setZoom != null:
return setZoom(_that.zoom);case ZoomIn() when zoomIn != null:
return zoomIn();case ZoomOut() when zoomOut != null:
return zoomOut();case SelectTool() when selectTool != null:
return selectTool(_that.tool);case AddPathPoint() when addPathPoint != null:
return addPathPoint(_that.point);case FinishPath() when finishPath != null:
return finishPath();case CancelPath() when cancelPath != null:
return cancelPath();case RestoreProject() when restoreProject != null:
return restoreProject(_that.project);case UndoEvent() when undo != null:
return undo();case RedoEvent() when redo != null:
return redo();case ToggleGrid() when toggleGrid != null:
return toggleGrid();case ToggleSnapToGrid() when toggleSnapToGrid != null:
return toggleSnapToGrid();case SetGridSize() when setGridSize != null:
return setGridSize(_that.size);case HandleMidiMessage() when handleMidiMessage != null:
return handleMidiMessage(_that.packet);case SaveProject() when saveProject != null:
return saveProject();case ExportProject() when exportProject != null:
return exportProject(_that.path);case FillImageArea() when fillImageArea != null:
return fillImageArea(_that.componentId,_that.position,_that.color);case SetFloodFillTolerance() when setFloodFillTolerance != null:
return setFloodFillTolerance(_that.tolerance);case CopyEvent() when copy != null:
return copy();case PasteEvent() when paste != null:
return paste();case CutEvent() when cut != null:
return cut();case DeleteEvent() when delete != null:
return delete();case DuplicateEvent() when duplicate != null:
return duplicate();case _:
  return null;

}
}

}

/// @nodoc


class LoadProject implements EditorEvent {
  const LoadProject({this.project, this.path = ''});
  

 final  Project? project;
@JsonKey() final  String path;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadProjectCopyWith<LoadProject> get copyWith => _$LoadProjectCopyWithImpl<LoadProject>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadProject&&(identical(other.project, project) || other.project == project)&&(identical(other.path, path) || other.path == path));
}


@override
int get hashCode => Object.hash(runtimeType,project,path);

@override
String toString() {
  return 'EditorEvent.loadProject(project: $project, path: $path)';
}


}

/// @nodoc
abstract mixin class $LoadProjectCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $LoadProjectCopyWith(LoadProject value, $Res Function(LoadProject) _then) = _$LoadProjectCopyWithImpl;
@useResult
$Res call({
 Project? project, String path
});


$ProjectCopyWith<$Res>? get project;

}
/// @nodoc
class _$LoadProjectCopyWithImpl<$Res>
    implements $LoadProjectCopyWith<$Res> {
  _$LoadProjectCopyWithImpl(this._self, this._then);

  final LoadProject _self;
  final $Res Function(LoadProject) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? project = freezed,Object? path = null,}) {
  return _then(LoadProject(
project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project?,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of EditorEvent
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

/// @nodoc


class UpdateViewTransform implements EditorEvent {
  const UpdateViewTransform(this.zoom, this.offset);
  

 final  double zoom;
 final  Offset offset;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateViewTransformCopyWith<UpdateViewTransform> get copyWith => _$UpdateViewTransformCopyWithImpl<UpdateViewTransform>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateViewTransform&&(identical(other.zoom, zoom) || other.zoom == zoom)&&(identical(other.offset, offset) || other.offset == offset));
}


@override
int get hashCode => Object.hash(runtimeType,zoom,offset);

@override
String toString() {
  return 'EditorEvent.updateViewTransform(zoom: $zoom, offset: $offset)';
}


}

/// @nodoc
abstract mixin class $UpdateViewTransformCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $UpdateViewTransformCopyWith(UpdateViewTransform value, $Res Function(UpdateViewTransform) _then) = _$UpdateViewTransformCopyWithImpl;
@useResult
$Res call({
 double zoom, Offset offset
});




}
/// @nodoc
class _$UpdateViewTransformCopyWithImpl<$Res>
    implements $UpdateViewTransformCopyWith<$Res> {
  _$UpdateViewTransformCopyWithImpl(this._self, this._then);

  final UpdateViewTransform _self;
  final $Res Function(UpdateViewTransform) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? zoom = null,Object? offset = null,}) {
  return _then(UpdateViewTransform(
null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as Offset,
  ));
}


}

/// @nodoc


class UpdateViewportSize implements EditorEvent {
  const UpdateViewportSize(this.size);
  

 final  Size size;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateViewportSizeCopyWith<UpdateViewportSize> get copyWith => _$UpdateViewportSizeCopyWithImpl<UpdateViewportSize>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateViewportSize&&(identical(other.size, size) || other.size == size));
}


@override
int get hashCode => Object.hash(runtimeType,size);

@override
String toString() {
  return 'EditorEvent.updateViewportSize(size: $size)';
}


}

/// @nodoc
abstract mixin class $UpdateViewportSizeCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $UpdateViewportSizeCopyWith(UpdateViewportSize value, $Res Function(UpdateViewportSize) _then) = _$UpdateViewportSizeCopyWithImpl;
@useResult
$Res call({
 Size size
});




}
/// @nodoc
class _$UpdateViewportSizeCopyWithImpl<$Res>
    implements $UpdateViewportSizeCopyWith<$Res> {
  _$UpdateViewportSizeCopyWithImpl(this._self, this._then);

  final UpdateViewportSize _self;
  final $Res Function(UpdateViewportSize) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? size = null,}) {
  return _then(UpdateViewportSize(
null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as Size,
  ));
}


}

/// @nodoc


class CenterOnContent implements EditorEvent {
  const CenterOnContent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CenterOnContent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.centerOnContent()';
}


}




/// @nodoc


class AddComponent implements EditorEvent {
  const AddComponent(this.component);
  

 final  Component component;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddComponentCopyWith<AddComponent> get copyWith => _$AddComponentCopyWithImpl<AddComponent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddComponent&&(identical(other.component, component) || other.component == component));
}


@override
int get hashCode => Object.hash(runtimeType,component);

@override
String toString() {
  return 'EditorEvent.addComponent(component: $component)';
}


}

/// @nodoc
abstract mixin class $AddComponentCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $AddComponentCopyWith(AddComponent value, $Res Function(AddComponent) _then) = _$AddComponentCopyWithImpl;
@useResult
$Res call({
 Component component
});


$ComponentCopyWith<$Res> get component;

}
/// @nodoc
class _$AddComponentCopyWithImpl<$Res>
    implements $AddComponentCopyWith<$Res> {
  _$AddComponentCopyWithImpl(this._self, this._then);

  final AddComponent _self;
  final $Res Function(AddComponent) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? component = null,}) {
  return _then(AddComponent(
null == component ? _self.component : component // ignore: cast_nullable_to_non_nullable
as Component,
  ));
}

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComponentCopyWith<$Res> get component {
  
  return $ComponentCopyWith<$Res>(_self.component, (value) {
    return _then(_self.copyWith(component: value));
  });
}
}

/// @nodoc


class UpdateComponent implements EditorEvent {
  const UpdateComponent(this.id, this.component);
  

 final  String id;
 final  Component component;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateComponentCopyWith<UpdateComponent> get copyWith => _$UpdateComponentCopyWithImpl<UpdateComponent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateComponent&&(identical(other.id, id) || other.id == id)&&(identical(other.component, component) || other.component == component));
}


@override
int get hashCode => Object.hash(runtimeType,id,component);

@override
String toString() {
  return 'EditorEvent.updateComponent(id: $id, component: $component)';
}


}

/// @nodoc
abstract mixin class $UpdateComponentCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $UpdateComponentCopyWith(UpdateComponent value, $Res Function(UpdateComponent) _then) = _$UpdateComponentCopyWithImpl;
@useResult
$Res call({
 String id, Component component
});


$ComponentCopyWith<$Res> get component;

}
/// @nodoc
class _$UpdateComponentCopyWithImpl<$Res>
    implements $UpdateComponentCopyWith<$Res> {
  _$UpdateComponentCopyWithImpl(this._self, this._then);

  final UpdateComponent _self;
  final $Res Function(UpdateComponent) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? component = null,}) {
  return _then(UpdateComponent(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,null == component ? _self.component : component // ignore: cast_nullable_to_non_nullable
as Component,
  ));
}

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComponentCopyWith<$Res> get component {
  
  return $ComponentCopyWith<$Res>(_self.component, (value) {
    return _then(_self.copyWith(component: value));
  });
}
}

/// @nodoc


class UpdateComponents implements EditorEvent {
  const UpdateComponents(final  List<Component> components): _components = components;
  

 final  List<Component> _components;
 List<Component> get components {
  if (_components is EqualUnmodifiableListView) return _components;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_components);
}


/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateComponentsCopyWith<UpdateComponents> get copyWith => _$UpdateComponentsCopyWithImpl<UpdateComponents>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateComponents&&const DeepCollectionEquality().equals(other._components, _components));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_components));

@override
String toString() {
  return 'EditorEvent.updateComponents(components: $components)';
}


}

/// @nodoc
abstract mixin class $UpdateComponentsCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $UpdateComponentsCopyWith(UpdateComponents value, $Res Function(UpdateComponents) _then) = _$UpdateComponentsCopyWithImpl;
@useResult
$Res call({
 List<Component> components
});




}
/// @nodoc
class _$UpdateComponentsCopyWithImpl<$Res>
    implements $UpdateComponentsCopyWith<$Res> {
  _$UpdateComponentsCopyWithImpl(this._self, this._then);

  final UpdateComponents _self;
  final $Res Function(UpdateComponents) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? components = null,}) {
  return _then(UpdateComponents(
null == components ? _self._components : components // ignore: cast_nullable_to_non_nullable
as List<Component>,
  ));
}


}

/// @nodoc


class SelectComponent implements EditorEvent {
  const SelectComponent(this.id, {required this.multiSelect});
  

 final  String id;
 final  bool multiSelect;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectComponentCopyWith<SelectComponent> get copyWith => _$SelectComponentCopyWithImpl<SelectComponent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectComponent&&(identical(other.id, id) || other.id == id)&&(identical(other.multiSelect, multiSelect) || other.multiSelect == multiSelect));
}


@override
int get hashCode => Object.hash(runtimeType,id,multiSelect);

@override
String toString() {
  return 'EditorEvent.selectComponent(id: $id, multiSelect: $multiSelect)';
}


}

/// @nodoc
abstract mixin class $SelectComponentCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $SelectComponentCopyWith(SelectComponent value, $Res Function(SelectComponent) _then) = _$SelectComponentCopyWithImpl;
@useResult
$Res call({
 String id, bool multiSelect
});




}
/// @nodoc
class _$SelectComponentCopyWithImpl<$Res>
    implements $SelectComponentCopyWith<$Res> {
  _$SelectComponentCopyWithImpl(this._self, this._then);

  final SelectComponent _self;
  final $Res Function(SelectComponent) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? multiSelect = null,}) {
  return _then(SelectComponent(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,multiSelect: null == multiSelect ? _self.multiSelect : multiSelect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SelectComponents implements EditorEvent {
  const SelectComponents(final  List<String> ids, {required this.multiSelect}): _ids = ids;
  

 final  List<String> _ids;
 List<String> get ids {
  if (_ids is EqualUnmodifiableListView) return _ids;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ids);
}

 final  bool multiSelect;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectComponentsCopyWith<SelectComponents> get copyWith => _$SelectComponentsCopyWithImpl<SelectComponents>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectComponents&&const DeepCollectionEquality().equals(other._ids, _ids)&&(identical(other.multiSelect, multiSelect) || other.multiSelect == multiSelect));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_ids),multiSelect);

@override
String toString() {
  return 'EditorEvent.selectComponents(ids: $ids, multiSelect: $multiSelect)';
}


}

/// @nodoc
abstract mixin class $SelectComponentsCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $SelectComponentsCopyWith(SelectComponents value, $Res Function(SelectComponents) _then) = _$SelectComponentsCopyWithImpl;
@useResult
$Res call({
 List<String> ids, bool multiSelect
});




}
/// @nodoc
class _$SelectComponentsCopyWithImpl<$Res>
    implements $SelectComponentsCopyWith<$Res> {
  _$SelectComponentsCopyWithImpl(this._self, this._then);

  final SelectComponents _self;
  final $Res Function(SelectComponents) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ids = null,Object? multiSelect = null,}) {
  return _then(SelectComponents(
null == ids ? _self._ids : ids // ignore: cast_nullable_to_non_nullable
as List<String>,multiSelect: null == multiSelect ? _self.multiSelect : multiSelect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ReorderComponent implements EditorEvent {
  const ReorderComponent(this.oldIndex, this.newIndex);
  

 final  int oldIndex;
 final  int newIndex;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReorderComponentCopyWith<ReorderComponent> get copyWith => _$ReorderComponentCopyWithImpl<ReorderComponent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReorderComponent&&(identical(other.oldIndex, oldIndex) || other.oldIndex == oldIndex)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}


@override
int get hashCode => Object.hash(runtimeType,oldIndex,newIndex);

@override
String toString() {
  return 'EditorEvent.reorderComponent(oldIndex: $oldIndex, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class $ReorderComponentCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $ReorderComponentCopyWith(ReorderComponent value, $Res Function(ReorderComponent) _then) = _$ReorderComponentCopyWithImpl;
@useResult
$Res call({
 int oldIndex, int newIndex
});




}
/// @nodoc
class _$ReorderComponentCopyWithImpl<$Res>
    implements $ReorderComponentCopyWith<$Res> {
  _$ReorderComponentCopyWithImpl(this._self, this._then);

  final ReorderComponent _self;
  final $Res Function(ReorderComponent) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldIndex = null,Object? newIndex = null,}) {
  return _then(ReorderComponent(
null == oldIndex ? _self.oldIndex : oldIndex // ignore: cast_nullable_to_non_nullable
as int,null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class UpdateProjectSettings implements EditorEvent {
  const UpdateProjectSettings(this.project);
  

 final  Project project;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProjectSettingsCopyWith<UpdateProjectSettings> get copyWith => _$UpdateProjectSettingsCopyWithImpl<UpdateProjectSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProjectSettings&&(identical(other.project, project) || other.project == project));
}


@override
int get hashCode => Object.hash(runtimeType,project);

@override
String toString() {
  return 'EditorEvent.updateProjectSettings(project: $project)';
}


}

/// @nodoc
abstract mixin class $UpdateProjectSettingsCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $UpdateProjectSettingsCopyWith(UpdateProjectSettings value, $Res Function(UpdateProjectSettings) _then) = _$UpdateProjectSettingsCopyWithImpl;
@useResult
$Res call({
 Project project
});


$ProjectCopyWith<$Res> get project;

}
/// @nodoc
class _$UpdateProjectSettingsCopyWithImpl<$Res>
    implements $UpdateProjectSettingsCopyWith<$Res> {
  _$UpdateProjectSettingsCopyWithImpl(this._self, this._then);

  final UpdateProjectSettings _self;
  final $Res Function(UpdateProjectSettings) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? project = null,}) {
  return _then(UpdateProjectSettings(
null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project,
  ));
}

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res> get project {
  
  return $ProjectCopyWith<$Res>(_self.project, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}

/// @nodoc


class ToggleMode implements EditorEvent {
  const ToggleMode(this.mode);
  

 final  EditorMode mode;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleModeCopyWith<ToggleMode> get copyWith => _$ToggleModeCopyWithImpl<ToggleMode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleMode&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'EditorEvent.toggleMode(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $ToggleModeCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $ToggleModeCopyWith(ToggleMode value, $Res Function(ToggleMode) _then) = _$ToggleModeCopyWithImpl;
@useResult
$Res call({
 EditorMode mode
});




}
/// @nodoc
class _$ToggleModeCopyWithImpl<$Res>
    implements $ToggleModeCopyWith<$Res> {
  _$ToggleModeCopyWithImpl(this._self, this._then);

  final ToggleMode _self;
  final $Res Function(ToggleMode) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(ToggleMode(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as EditorMode,
  ));
}


}

/// @nodoc


class SetZoom implements EditorEvent {
  const SetZoom(this.zoom);
  

 final  double zoom;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetZoomCopyWith<SetZoom> get copyWith => _$SetZoomCopyWithImpl<SetZoom>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetZoom&&(identical(other.zoom, zoom) || other.zoom == zoom));
}


@override
int get hashCode => Object.hash(runtimeType,zoom);

@override
String toString() {
  return 'EditorEvent.setZoom(zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class $SetZoomCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $SetZoomCopyWith(SetZoom value, $Res Function(SetZoom) _then) = _$SetZoomCopyWithImpl;
@useResult
$Res call({
 double zoom
});




}
/// @nodoc
class _$SetZoomCopyWithImpl<$Res>
    implements $SetZoomCopyWith<$Res> {
  _$SetZoomCopyWithImpl(this._self, this._then);

  final SetZoom _self;
  final $Res Function(SetZoom) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? zoom = null,}) {
  return _then(SetZoom(
null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class ZoomIn implements EditorEvent {
  const ZoomIn();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZoomIn);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.zoomIn()';
}


}




/// @nodoc


class ZoomOut implements EditorEvent {
  const ZoomOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZoomOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.zoomOut()';
}


}




/// @nodoc


class SelectTool implements EditorEvent {
  const SelectTool(this.tool);
  

 final  EditorTool tool;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectToolCopyWith<SelectTool> get copyWith => _$SelectToolCopyWithImpl<SelectTool>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectTool&&(identical(other.tool, tool) || other.tool == tool));
}


@override
int get hashCode => Object.hash(runtimeType,tool);

@override
String toString() {
  return 'EditorEvent.selectTool(tool: $tool)';
}


}

/// @nodoc
abstract mixin class $SelectToolCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $SelectToolCopyWith(SelectTool value, $Res Function(SelectTool) _then) = _$SelectToolCopyWithImpl;
@useResult
$Res call({
 EditorTool tool
});




}
/// @nodoc
class _$SelectToolCopyWithImpl<$Res>
    implements $SelectToolCopyWith<$Res> {
  _$SelectToolCopyWithImpl(this._self, this._then);

  final SelectTool _self;
  final $Res Function(SelectTool) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tool = null,}) {
  return _then(SelectTool(
null == tool ? _self.tool : tool // ignore: cast_nullable_to_non_nullable
as EditorTool,
  ));
}


}

/// @nodoc


class AddPathPoint implements EditorEvent {
  const AddPathPoint(this.point);
  

 final  Offset point;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddPathPointCopyWith<AddPathPoint> get copyWith => _$AddPathPointCopyWithImpl<AddPathPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPathPoint&&(identical(other.point, point) || other.point == point));
}


@override
int get hashCode => Object.hash(runtimeType,point);

@override
String toString() {
  return 'EditorEvent.addPathPoint(point: $point)';
}


}

/// @nodoc
abstract mixin class $AddPathPointCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $AddPathPointCopyWith(AddPathPoint value, $Res Function(AddPathPoint) _then) = _$AddPathPointCopyWithImpl;
@useResult
$Res call({
 Offset point
});




}
/// @nodoc
class _$AddPathPointCopyWithImpl<$Res>
    implements $AddPathPointCopyWith<$Res> {
  _$AddPathPointCopyWithImpl(this._self, this._then);

  final AddPathPoint _self;
  final $Res Function(AddPathPoint) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? point = null,}) {
  return _then(AddPathPoint(
null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as Offset,
  ));
}


}

/// @nodoc


class FinishPath implements EditorEvent {
  const FinishPath();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinishPath);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.finishPath()';
}


}




/// @nodoc


class CancelPath implements EditorEvent {
  const CancelPath();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelPath);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.cancelPath()';
}


}




/// @nodoc


class RestoreProject implements EditorEvent {
  const RestoreProject(this.project);
  

 final  Project project;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestoreProjectCopyWith<RestoreProject> get copyWith => _$RestoreProjectCopyWithImpl<RestoreProject>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestoreProject&&(identical(other.project, project) || other.project == project));
}


@override
int get hashCode => Object.hash(runtimeType,project);

@override
String toString() {
  return 'EditorEvent.restoreProject(project: $project)';
}


}

/// @nodoc
abstract mixin class $RestoreProjectCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $RestoreProjectCopyWith(RestoreProject value, $Res Function(RestoreProject) _then) = _$RestoreProjectCopyWithImpl;
@useResult
$Res call({
 Project project
});


$ProjectCopyWith<$Res> get project;

}
/// @nodoc
class _$RestoreProjectCopyWithImpl<$Res>
    implements $RestoreProjectCopyWith<$Res> {
  _$RestoreProjectCopyWithImpl(this._self, this._then);

  final RestoreProject _self;
  final $Res Function(RestoreProject) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? project = null,}) {
  return _then(RestoreProject(
null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project,
  ));
}

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res> get project {
  
  return $ProjectCopyWith<$Res>(_self.project, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}

/// @nodoc


class UndoEvent implements EditorEvent {
  const UndoEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UndoEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.undo()';
}


}




/// @nodoc


class RedoEvent implements EditorEvent {
  const RedoEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RedoEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.redo()';
}


}




/// @nodoc


class ToggleGrid implements EditorEvent {
  const ToggleGrid();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleGrid);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.toggleGrid()';
}


}




/// @nodoc


class ToggleSnapToGrid implements EditorEvent {
  const ToggleSnapToGrid();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleSnapToGrid);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.toggleSnapToGrid()';
}


}




/// @nodoc


class SetGridSize implements EditorEvent {
  const SetGridSize(this.size);
  

 final  double size;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetGridSizeCopyWith<SetGridSize> get copyWith => _$SetGridSizeCopyWithImpl<SetGridSize>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetGridSize&&(identical(other.size, size) || other.size == size));
}


@override
int get hashCode => Object.hash(runtimeType,size);

@override
String toString() {
  return 'EditorEvent.setGridSize(size: $size)';
}


}

/// @nodoc
abstract mixin class $SetGridSizeCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $SetGridSizeCopyWith(SetGridSize value, $Res Function(SetGridSize) _then) = _$SetGridSizeCopyWithImpl;
@useResult
$Res call({
 double size
});




}
/// @nodoc
class _$SetGridSizeCopyWithImpl<$Res>
    implements $SetGridSizeCopyWith<$Res> {
  _$SetGridSizeCopyWithImpl(this._self, this._then);

  final SetGridSize _self;
  final $Res Function(SetGridSize) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? size = null,}) {
  return _then(SetGridSize(
null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class HandleMidiMessage implements EditorEvent {
  const HandleMidiMessage(this.packet);
  

 final  MidiPacket packet;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HandleMidiMessageCopyWith<HandleMidiMessage> get copyWith => _$HandleMidiMessageCopyWithImpl<HandleMidiMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HandleMidiMessage&&(identical(other.packet, packet) || other.packet == packet));
}


@override
int get hashCode => Object.hash(runtimeType,packet);

@override
String toString() {
  return 'EditorEvent.handleMidiMessage(packet: $packet)';
}


}

/// @nodoc
abstract mixin class $HandleMidiMessageCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $HandleMidiMessageCopyWith(HandleMidiMessage value, $Res Function(HandleMidiMessage) _then) = _$HandleMidiMessageCopyWithImpl;
@useResult
$Res call({
 MidiPacket packet
});




}
/// @nodoc
class _$HandleMidiMessageCopyWithImpl<$Res>
    implements $HandleMidiMessageCopyWith<$Res> {
  _$HandleMidiMessageCopyWithImpl(this._self, this._then);

  final HandleMidiMessage _self;
  final $Res Function(HandleMidiMessage) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? packet = null,}) {
  return _then(HandleMidiMessage(
null == packet ? _self.packet : packet // ignore: cast_nullable_to_non_nullable
as MidiPacket,
  ));
}


}

/// @nodoc


class SaveProject implements EditorEvent {
  const SaveProject();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveProject);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.saveProject()';
}


}




/// @nodoc


class ExportProject implements EditorEvent {
  const ExportProject(this.path);
  

 final  String path;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportProjectCopyWith<ExportProject> get copyWith => _$ExportProjectCopyWithImpl<ExportProject>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportProject&&(identical(other.path, path) || other.path == path));
}


@override
int get hashCode => Object.hash(runtimeType,path);

@override
String toString() {
  return 'EditorEvent.exportProject(path: $path)';
}


}

/// @nodoc
abstract mixin class $ExportProjectCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $ExportProjectCopyWith(ExportProject value, $Res Function(ExportProject) _then) = _$ExportProjectCopyWithImpl;
@useResult
$Res call({
 String path
});




}
/// @nodoc
class _$ExportProjectCopyWithImpl<$Res>
    implements $ExportProjectCopyWith<$Res> {
  _$ExportProjectCopyWithImpl(this._self, this._then);

  final ExportProject _self;
  final $Res Function(ExportProject) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? path = null,}) {
  return _then(ExportProject(
null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FillImageArea implements EditorEvent {
  const FillImageArea(this.componentId, this.position, this.color);
  

 final  String componentId;
 final  Offset position;
 final  Color color;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FillImageAreaCopyWith<FillImageArea> get copyWith => _$FillImageAreaCopyWithImpl<FillImageArea>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FillImageArea&&(identical(other.componentId, componentId) || other.componentId == componentId)&&(identical(other.position, position) || other.position == position)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,componentId,position,color);

@override
String toString() {
  return 'EditorEvent.fillImageArea(componentId: $componentId, position: $position, color: $color)';
}


}

/// @nodoc
abstract mixin class $FillImageAreaCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $FillImageAreaCopyWith(FillImageArea value, $Res Function(FillImageArea) _then) = _$FillImageAreaCopyWithImpl;
@useResult
$Res call({
 String componentId, Offset position, Color color
});




}
/// @nodoc
class _$FillImageAreaCopyWithImpl<$Res>
    implements $FillImageAreaCopyWith<$Res> {
  _$FillImageAreaCopyWithImpl(this._self, this._then);

  final FillImageArea _self;
  final $Res Function(FillImageArea) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? componentId = null,Object? position = null,Object? color = null,}) {
  return _then(FillImageArea(
null == componentId ? _self.componentId : componentId // ignore: cast_nullable_to_non_nullable
as String,null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset,null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

/// @nodoc


class SetFloodFillTolerance implements EditorEvent {
  const SetFloodFillTolerance(this.tolerance);
  

 final  int tolerance;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetFloodFillToleranceCopyWith<SetFloodFillTolerance> get copyWith => _$SetFloodFillToleranceCopyWithImpl<SetFloodFillTolerance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetFloodFillTolerance&&(identical(other.tolerance, tolerance) || other.tolerance == tolerance));
}


@override
int get hashCode => Object.hash(runtimeType,tolerance);

@override
String toString() {
  return 'EditorEvent.setFloodFillTolerance(tolerance: $tolerance)';
}


}

/// @nodoc
abstract mixin class $SetFloodFillToleranceCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $SetFloodFillToleranceCopyWith(SetFloodFillTolerance value, $Res Function(SetFloodFillTolerance) _then) = _$SetFloodFillToleranceCopyWithImpl;
@useResult
$Res call({
 int tolerance
});




}
/// @nodoc
class _$SetFloodFillToleranceCopyWithImpl<$Res>
    implements $SetFloodFillToleranceCopyWith<$Res> {
  _$SetFloodFillToleranceCopyWithImpl(this._self, this._then);

  final SetFloodFillTolerance _self;
  final $Res Function(SetFloodFillTolerance) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tolerance = null,}) {
  return _then(SetFloodFillTolerance(
null == tolerance ? _self.tolerance : tolerance // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CopyEvent implements EditorEvent {
  const CopyEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CopyEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.copy()';
}


}




/// @nodoc


class PasteEvent implements EditorEvent {
  const PasteEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasteEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.paste()';
}


}




/// @nodoc


class CutEvent implements EditorEvent {
  const CutEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.cut()';
}


}




/// @nodoc


class DeleteEvent implements EditorEvent {
  const DeleteEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.delete()';
}


}




/// @nodoc


class DuplicateEvent implements EditorEvent {
  const DuplicateEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DuplicateEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent.duplicate()';
}


}




// dart format on
