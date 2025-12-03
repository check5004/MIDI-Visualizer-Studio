import 'dart:ui';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

part 'editor_event.freezed.dart';

@freezed
class EditorEvent with _$EditorEvent {
  const factory EditorEvent.loadProject({Project? project, @Default('') String path}) = LoadProject;
  const factory EditorEvent.updateViewTransform(double zoom, Offset offset) = UpdateViewTransform;
  const factory EditorEvent.updateViewportSize(Size size) = UpdateViewportSize;
  const factory EditorEvent.centerOnContent() = CenterOnContent;
  const factory EditorEvent.addComponent(Component component) = AddComponent;
  const factory EditorEvent.updateComponent(String id, Component component) = UpdateComponent;
  const factory EditorEvent.updateComponents(List<Component> components) = UpdateComponents;
  const factory EditorEvent.selectComponent(String id, {required bool multiSelect}) = SelectComponent;
  const factory EditorEvent.selectComponents(List<String> ids, {required bool multiSelect}) = SelectComponents;
  const factory EditorEvent.reorderComponent(int oldIndex, int newIndex) = ReorderComponent;
  const factory EditorEvent.updateProjectSettings(Project project) = UpdateProjectSettings;
  const factory EditorEvent.toggleMode(EditorMode mode) = ToggleMode;
  const factory EditorEvent.setZoom(double zoom) = SetZoom;
  const factory EditorEvent.zoomIn() = ZoomIn;
  const factory EditorEvent.zoomOut() = ZoomOut;
  const factory EditorEvent.selectTool(EditorTool tool) = SelectTool;
  const factory EditorEvent.addPathPoint(Offset point) = AddPathPoint;
  const factory EditorEvent.finishPath() = FinishPath;
  const factory EditorEvent.cancelPath() = CancelPath;
  const factory EditorEvent.restoreProject(Project project) = RestoreProject;
  const factory EditorEvent.undo() = UndoEvent;
  const factory EditorEvent.redo() = RedoEvent;
  const factory EditorEvent.toggleGrid() = ToggleGrid;
  const factory EditorEvent.toggleSnapToGrid() = ToggleSnapToGrid;
  const factory EditorEvent.setGridSize(double size) = SetGridSize;
  const factory EditorEvent.handleMidiMessage(MidiPacket packet) = HandleMidiMessage;
  const factory EditorEvent.saveProject() = SaveProject;
  const factory EditorEvent.exportProject(String path) = ExportProject;
  const factory EditorEvent.fillImageArea(String componentId, Offset position, Color color) = FillImageArea;
  const factory EditorEvent.setFloodFillTolerance(int tolerance) = SetFloodFillTolerance;
  const factory EditorEvent.copy() = CopyEvent;
  const factory EditorEvent.paste() = PasteEvent;
  const factory EditorEvent.cut() = CutEvent;
  const factory EditorEvent.delete() = DeleteEvent;
  const factory EditorEvent.duplicate() = DuplicateEvent;
  const factory EditorEvent.interactionStart() = InteractionStart;
  const factory EditorEvent.interactionEnd() = InteractionEnd;
  const factory EditorEvent.startDrawing(Offset point) = StartDrawing;
  const factory EditorEvent.updateDrawing(Offset point, {@Default(false) bool isShift, @Default(false) bool isAlt}) =
      UpdateDrawing;
  const factory EditorEvent.finishDrawing() = FinishDrawing;
  const factory EditorEvent.createPadGrid(int rows, int columns) = CreatePadGrid;
}
