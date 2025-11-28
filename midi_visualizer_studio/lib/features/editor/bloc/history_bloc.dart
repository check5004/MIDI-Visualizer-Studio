import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';

class HistoryState {
  final List<Project> undoStack;
  final List<Project> redoStack;

  bool get canUndo => undoStack.isNotEmpty;
  bool get canRedo => redoStack.isNotEmpty;

  const HistoryState({this.undoStack = const [], this.redoStack = const []});

  HistoryState copyWith({List<Project>? undoStack, List<Project>? redoStack}) {
    return HistoryState(undoStack: undoStack ?? this.undoStack, redoStack: redoStack ?? this.redoStack);
  }
}

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(const HistoryState());

  void record(Project project) {
    final newUndoStack = List<Project>.from(state.undoStack)..add(project);
    if (newUndoStack.length > 50) newUndoStack.removeAt(0);

    emit(state.copyWith(undoStack: newUndoStack, redoStack: []));
  }

  Project? undo(Project currentProject) {
    if (!state.canUndo) return null;

    final newUndoStack = List<Project>.from(state.undoStack);
    final previousProject = newUndoStack.removeLast();

    final newRedoStack = List<Project>.from(state.redoStack)..add(currentProject);

    emit(state.copyWith(undoStack: newUndoStack, redoStack: newRedoStack));

    return previousProject;
  }

  Project? redo(Project currentProject) {
    if (!state.canRedo) return null;

    final newRedoStack = List<Project>.from(state.redoStack);
    final nextProject = newRedoStack.removeLast();

    final newUndoStack = List<Project>.from(state.undoStack)..add(currentProject);

    emit(state.copyWith(undoStack: newUndoStack, redoStack: newRedoStack));

    return nextProject;
  }

  void clear() {
    emit(const HistoryState());
  }
}
