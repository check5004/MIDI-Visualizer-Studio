import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

import 'package:midi_visualizer_studio/features/editor/bloc/history_bloc.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  final HistoryCubit historyCubit;

  EditorBloc({HistoryCubit? historyCubit}) : historyCubit = historyCubit ?? HistoryCubit(), super(const EditorState()) {
    on<LoadProject>(_onLoadProject);
    on<AddComponent>(_onAddComponent);
    on<UpdateComponent>(_onUpdateComponent);
    on<SelectComponent>(_onSelectComponent);
    on<ReorderComponent>(_onReorderComponent);
    on<UpdateProjectSettings>(_onUpdateProjectSettings);
    on<ToggleMode>(_onToggleMode);
    on<RestoreProject>(_onRestoreProject);
    on<UndoEvent>(_onUndo);
    on<RedoEvent>(_onRedo);
    on<SetZoom>(_onSetZoom);
    on<ZoomIn>(_onZoomIn);
    on<ZoomOut>(_onZoomOut);
    on<SelectTool>(_onSelectTool);
    on<AddPathPoint>(_onAddPathPoint);
    on<FinishPath>(_onFinishPath);
    on<CancelPath>(_onCancelPath);
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

    _recordHistory();
    final updatedLayers = [...project.layers, event.component];
    emit(state.copyWith(project: project.copyWith(layers: updatedLayers)));
  }

  void _onUpdateComponent(UpdateComponent event, Emitter<EditorState> emit) {
    final project = state.project;
    if (project == null) return;

    _recordHistory();
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

    _recordHistory();
    final layers = List<Component>.from(project.layers);
    if (event.oldIndex < event.newIndex) {
      layers.insert(event.newIndex, layers.removeAt(event.oldIndex));
    } else {
      layers.insert(event.newIndex, layers.removeAt(event.oldIndex));
    }

    emit(state.copyWith(project: project.copyWith(layers: layers)));
  }

  void _onUpdateProjectSettings(UpdateProjectSettings event, Emitter<EditorState> emit) {
    _recordHistory();
    emit(state.copyWith(project: event.project));
  }

  void _onToggleMode(ToggleMode event, Emitter<EditorState> emit) {
    emit(state.copyWith(mode: event.mode));
  }

  void _onRestoreProject(RestoreProject event, Emitter<EditorState> emit) {
    emit(state.copyWith(project: event.project));
  }

  void _onUndo(UndoEvent event, Emitter<EditorState> emit) {
    final project = state.project;
    if (project == null) return;

    final previousProject = historyCubit.undo(project);
    if (previousProject != null) {
      emit(state.copyWith(project: previousProject));
    }
  }

  void _onRedo(RedoEvent event, Emitter<EditorState> emit) {
    final project = state.project;
    if (project == null) return;

    final nextProject = historyCubit.redo(project);
    if (nextProject != null) {
      emit(state.copyWith(project: nextProject));
    }
  }

  void _onSetZoom(SetZoom event, Emitter<EditorState> emit) {
    emit(state.copyWith(zoomLevel: event.zoom.clamp(0.1, 5.0)));
  }

  void _onZoomIn(ZoomIn event, Emitter<EditorState> emit) {
    final newZoom = (state.zoomLevel + 0.1).clamp(0.1, 5.0);
    emit(state.copyWith(zoomLevel: newZoom));
  }

  void _onZoomOut(ZoomOut event, Emitter<EditorState> emit) {
    final newZoom = (state.zoomLevel - 0.1).clamp(0.1, 5.0);
    emit(state.copyWith(zoomLevel: newZoom));
  }

  void _onSelectTool(SelectTool event, Emitter<EditorState> emit) {
    emit(state.copyWith(currentTool: event.tool, currentPathPoints: []));
  }

  void _onAddPathPoint(AddPathPoint event, Emitter<EditorState> emit) {
    final updatedPoints = [...state.currentPathPoints, event.point];
    emit(state.copyWith(currentPathPoints: updatedPoints));
  }

  void _onFinishPath(FinishPath event, Emitter<EditorState> emit) {
    final points = state.currentPathPoints;
    if (points.length < 3) return; // Need at least 3 points for a polygon

    final project = state.project;
    if (project == null) return;

    _recordHistory();

    // Generate SVG path data
    final buffer = StringBuffer();
    buffer.write('M ${points[0].dx} ${points[0].dy}');
    for (int i = 1; i < points.length; i++) {
      buffer.write(' L ${points[i].dx} ${points[i].dy}');
    }
    buffer.write(' Z');

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    // Calculate bounding box
    double minX = points[0].dx;
    double minY = points[0].dy;
    double maxX = points[0].dx;
    double maxY = points[0].dy;

    for (final point in points) {
      if (point.dx < minX) minX = point.dx;
      if (point.dy < minY) minY = point.dy;
      if (point.dx > maxX) maxX = point.dx;
      if (point.dy > maxY) maxY = point.dy;
    }

    final width = maxX - minX;
    final height = maxY - minY;

    // Create component
    // Note: We might want to normalize points relative to x,y, but for now absolute path is fine or we can adjust.
    // Ideally, x,y is top-left, and path is relative to it.
    // Let's stick to absolute path for simplicity first, or adjust if needed.
    // If we want x,y to be meaningful, we should subtract minX, minY from points.

    // Adjust points to be relative to minX, minY
    final relativeBuffer = StringBuffer();
    relativeBuffer.write('M ${points[0].dx - minX} ${points[0].dy - minY}');
    for (int i = 1; i < points.length; i++) {
      relativeBuffer.write(' L ${points[i].dx - minX} ${points[i].dy - minY}');
    }
    relativeBuffer.write(' Z');

    final component = Component.pad(
      id: id,
      name: 'Path $id',
      x: minX,
      y: minY,
      width: width,
      height: height,
      shape: PadShape.path,
      pathData: relativeBuffer.toString(),
    );

    final updatedLayers = [...project.layers, component];
    emit(
      state.copyWith(
        project: project.copyWith(layers: updatedLayers),
        currentPathPoints: [],
        currentTool: EditorTool.select, // Reset tool after finishing
      ),
    );
  }

  void _onCancelPath(CancelPath event, Emitter<EditorState> emit) {
    emit(state.copyWith(currentPathPoints: [], currentTool: EditorTool.select));
  }

  // Helper to record history before mutation
  void _recordHistory() {
    final project = state.project;
    if (project != null) {
      historyCubit.record(project);
    }
  }
}
