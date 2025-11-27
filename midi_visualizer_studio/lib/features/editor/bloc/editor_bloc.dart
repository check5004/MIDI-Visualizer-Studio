import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc() : super(const EditorState()) {
    on<LoadProject>(_onLoadProject);
    on<AddComponent>(_onAddComponent);
    on<UpdateComponent>(_onUpdateComponent);
    on<SelectComponent>(_onSelectComponent);
    on<ToggleMode>(_onToggleMode);
  }

  Future<void> _onLoadProject(LoadProject event, Emitter<EditorState> emit) async {
    // TODO: Implement load project logic
  }

  void _onAddComponent(AddComponent event, Emitter<EditorState> emit) {
    // TODO: Implement add component logic
  }

  void _onUpdateComponent(UpdateComponent event, Emitter<EditorState> emit) {
    // TODO: Implement update component logic
  }

  void _onSelectComponent(SelectComponent event, Emitter<EditorState> emit) {
    // TODO: Implement select component logic
  }

  void _onToggleMode(ToggleMode event, Emitter<EditorState> emit) {
    emit(state.copyWith(mode: event.mode));
  }
}
