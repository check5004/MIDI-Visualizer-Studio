import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc() : super(const EditorState()) {
    on<LoadProject>(_onLoadProject);
    on<AddComponent>(_onAddComponent);
    on<UpdateComponent>(_onUpdateComponent);
    on<SelectComponent>(_onSelectComponent);
    on<ReorderComponent>(_onReorderComponent);
    on<UpdateProjectSettings>(_onUpdateProjectSettings);
    on<ToggleMode>(_onToggleMode);
  }

  Future<void> _onLoadProject(LoadProject event, Emitter<EditorState> emit) async {
    emit(state.copyWith(status: EditorStatus.loading));
    // Simulate loading a project with some dummy data
    await Future.delayed(const Duration(milliseconds: 500));

    final dummyProject = Project(
      id: event.path,
      name: 'New Project',
      version: '1.0.0',
      layers: [
        const Component.pad(id: '1', name: 'Pad 1', x: 100, y: 100, width: 100, height: 100),
        const Component.knob(id: '2', name: 'Knob 1', x: 300, y: 100, width: 80, height: 80),
      ],
    );

    emit(state.copyWith(status: EditorStatus.ready, project: dummyProject));
  }

  void _onAddComponent(AddComponent event, Emitter<EditorState> emit) {
    final project = state.project;
    if (project == null) return;

    final updatedLayers = [...project.layers, event.component];
    emit(state.copyWith(project: project.copyWith(layers: updatedLayers)));
  }

  void _onUpdateComponent(UpdateComponent event, Emitter<EditorState> emit) {
    final project = state.project;
    if (project == null) return;

    final updatedLayers = project.layers.map((c) {
      return c.id == event.id ? event.component : c;
    }).toList();

    emit(state.copyWith(project: project.copyWith(layers: updatedLayers)));
  }

  void _onSelectComponent(SelectComponent event, Emitter<EditorState> emit) {
    if (event.id.isEmpty) {
      emit(state.copyWith(selectedComponentIds: {}));
      return;
    }

    final currentSelected = Set<String>.from(state.selectedComponentIds);
    if (event.multiSelect) {
      if (currentSelected.contains(event.id)) {
        currentSelected.remove(event.id);
      } else {
        currentSelected.add(event.id);
      }
    } else {
      currentSelected.clear();
      currentSelected.add(event.id);
    }

    emit(state.copyWith(selectedComponentIds: currentSelected));
  }

  void _onReorderComponent(ReorderComponent event, Emitter<EditorState> emit) {
    final project = state.project;
    if (project == null) return;

    final layers = List<Component>.from(project.layers);
    if (event.oldIndex < event.newIndex) {
      // Adjust for the item being removed
      layers.insert(event.newIndex, layers.removeAt(event.oldIndex));
    } else {
      layers.insert(event.newIndex, layers.removeAt(event.oldIndex));
    }

    emit(state.copyWith(project: project.copyWith(layers: layers)));
  }

  void _onUpdateProjectSettings(UpdateProjectSettings event, Emitter<EditorState> emit) {
    emit(state.copyWith(project: event.project));
  }

  void _onToggleMode(ToggleMode event, Emitter<EditorState> emit) {
    emit(state.copyWith(mode: event.mode));
  }
}
