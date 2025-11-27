import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

part 'editor_event.freezed.dart';

@freezed
abstract class EditorEvent with _$EditorEvent {
  const factory EditorEvent.loadProject(String path) = LoadProject;
  const factory EditorEvent.addComponent(Component component) = AddComponent;
  const factory EditorEvent.updateComponent(String id, Component component) = UpdateComponent;
  const factory EditorEvent.selectComponent(String id, {required bool multiSelect}) = SelectComponent;
  const factory EditorEvent.reorderComponent(int oldIndex, int newIndex) = ReorderComponent;
  const factory EditorEvent.updateProjectSettings(Project project) = UpdateProjectSettings;
  const factory EditorEvent.toggleMode(EditorMode mode) = ToggleMode;
}
