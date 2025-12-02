import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:ui';

import 'package:image/image.dart' as img;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/history_bloc.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  final HistoryCubit? _historyCubit;
  final ProjectRepository? _projectRepository;

  EditorBloc({HistoryCubit? historyCubit, ProjectRepository? projectRepository})
    : _historyCubit = historyCubit,
      _projectRepository = projectRepository,
      super(const EditorState()) {
    on<LoadProject>(_onLoadProject);
    on<AddComponent>(_onAddComponent);
    on<UpdateComponent>(_onUpdateComponent);
    on<UpdateComponents>(_onUpdateComponents);
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
    on<ToggleGrid>(_onToggleGrid);
    on<ToggleSnapToGrid>(_onToggleSnapToGrid);
    on<SetGridSize>(_onSetGridSize);
    on<HandleMidiMessage>(_onHandleMidiMessage);
    on<SaveProject>(_onSaveProject);
    on<FillImageArea>(_onFillImageArea);
    on<SetFloodFillTolerance>(_onSetFloodFillTolerance);
    on<CopyEvent>(_onCopy);
    on<PasteEvent>(_onPaste);
    on<CutEvent>(_onCut);
    on<DeleteEvent>(_onDelete);
    on<DuplicateEvent>(_onDuplicate);
    on<ExportProject>(_onExportProject);
  }

  Future<void> _onLoadProject(LoadProject event, Emitter<EditorState> emit) async {
    emit(state.copyWith(status: EditorStatus.loading));

    try {
      Project? project;
      if (event.project != null) {
        project = event.project;
      } else if (event.path.isNotEmpty) {
        project = await _projectRepository?.loadProject(event.path);
      }

      if (project != null) {
        emit(state.copyWith(status: EditorStatus.ready, project: project, errorMessage: null));
        _recordHistory();
      } else {
        emit(state.copyWith(status: EditorStatus.error, errorMessage: 'Failed to load project: Project not found'));
      }
    } catch (e) {
      emit(state.copyWith(status: EditorStatus.error, errorMessage: 'Failed to load project: $e'));
    }
  }

  // ... (previous handlers)

  Future<void> _onSaveProject(SaveProject event, Emitter<EditorState> emit) async {
    final project = state.project;
    if (project == null) return;

    try {
      // Calculate canvas size based on components
      double maxX = 800;
      double maxY = 600;

      for (final layer in project.layers) {
        final right = layer.x + layer.width;
        final bottom = layer.y + layer.height;
        if (right > maxX) maxX = right;
        if (bottom > maxY) maxY = bottom;
      }

      // Add some padding
      maxX += 100;
      maxY += 100;

      final projectToSave = project.copyWith(canvasWidth: maxX, canvasHeight: maxY, updatedAt: DateTime.now());

      await _projectRepository?.saveProjectInternal(projectToSave);
      emit(state.copyWith(project: projectToSave, errorMessage: null)); // Update state with new timestamp
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to save project: $e'));
    }
  }

  Future<void> _onExportProject(ExportProject event, Emitter<EditorState> emit) async {
    final project = state.project;
    if (project == null) return;

    try {
      await _projectRepository?.exportProject(project, event.path);
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to export project: $e'));
    }
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

  void _onUpdateComponents(UpdateComponents event, Emitter<EditorState> emit) {
    final project = state.project;
    if (project == null) return;

    _recordHistory();

    // Create a map for faster lookup
    final updates = {for (var c in event.components) c.id: c};

    final updatedLayers = project.layers.map((c) {
      return updates.containsKey(c.id) ? updates[c.id]! : c;
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

    final previousProject = _historyCubit?.undo(project);
    if (previousProject != null) {
      final validSelection = state.selectedComponentIds
          .where((id) => previousProject.layers.any((l) => l.id == id))
          .toSet();
      emit(state.copyWith(project: previousProject, selectedComponentIds: validSelection));
    }
  }

  void _onRedo(RedoEvent event, Emitter<EditorState> emit) {
    final project = state.project;
    if (project == null) return;

    final nextProject = _historyCubit?.redo(project);
    if (nextProject != null) {
      final validSelection = state.selectedComponentIds
          .where((id) => nextProject.layers.any((l) => l.id == id))
          .toSet();
      emit(state.copyWith(project: nextProject, selectedComponentIds: validSelection));
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

  void _onToggleGrid(ToggleGrid event, Emitter<EditorState> emit) {
    emit(state.copyWith(showGrid: !state.showGrid));
  }

  void _onToggleSnapToGrid(ToggleSnapToGrid event, Emitter<EditorState> emit) {
    emit(state.copyWith(snapToGrid: !state.snapToGrid));
  }

  void _onSetGridSize(SetGridSize event, Emitter<EditorState> emit) {
    emit(state.copyWith(gridSize: event.size.clamp(5.0, 100.0)));
  }

  void _onHandleMidiMessage(HandleMidiMessage event, Emitter<EditorState> emit) {
    final project = state.project;
    if (project == null) return;

    final packet = event.packet;
    if (packet.data.isEmpty) return;

    final status = packet.data[0] & 0xF0;
    final channel = packet.data[0] & 0x0F;
    final data1 = packet.data.length > 1 ? packet.data[1] : 0;
    final data2 = packet.data.length > 2 ? packet.data[2] : 0;

    final isNoteOn = status == 0x90 && data2 > 0;
    final isNoteOff = status == 0x80 || (status == 0x90 && data2 == 0);

    if (!isNoteOn && !isNoteOff) return;

    final activeIds = Set<String>.from(state.activeComponentIds);
    bool changed = false;
    final updates = <String, Component>{};

    for (final component in project.layers) {
      component.map(
        pad: (pad) {
          if (pad.midiChannel == channel && pad.midiNote == data1) {
            if (isNoteOn) {
              if (activeIds.add(pad.id)) changed = true;
            } else if (isNoteOff) {
              if (activeIds.remove(pad.id)) changed = true;
            }
          }
        },
        knob: (knob) {
          if (knob.midiChannel == channel && knob.midiCc == data1) {
            if (activeIds.add(knob.id)) changed = true;

            if (knob.isRelative && knob.relativeEffect == KnobRelativeEffect.spin) {
              final newRotation = (knob.rotation + 0.2) % (2 * 3.14159);
              updates[knob.id] = knob.copyWith(rotation: newRotation);
            }
          }
        },
        staticImage: (_) {},
      );
    }

    if (changed || updates.isNotEmpty) {
      var newProject = project;
      if (updates.isNotEmpty) {
        final newLayers = project.layers.map((c) => updates[c.id] ?? c).toList();
        newProject = project.copyWith(layers: newLayers);
      }
      emit(state.copyWith(activeComponentIds: activeIds, project: newProject));
    }
  }

  Future<void> _onFillImageArea(FillImageArea event, Emitter<EditorState> emit) async {
    final project = state.project;
    if (project == null) return;

    final component = project.layers.firstWhere(
      (c) => c.id == event.componentId,
      orElse: () => throw Exception('Component not found'),
    );
    if (component is! ComponentStaticImage) return;

    final file = File(component.imagePath);
    if (!file.existsSync()) return;

    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return;

    // Convert tap position (relative to component) to image coordinates
    // Component size: component.width, component.height
    // Image size: image.width, image.height
    // Tap position: event.position (relative to component top-left)

    final scaleX = image.width / component.width;
    final scaleY = image.height / component.height;

    final startX = (event.position.dx * scaleX).toInt();
    final startY = (event.position.dy * scaleY).toInt();

    if (startX < 0 || startX >= image.width || startY < 0 || startY >= image.height) return;

    // Perform Flood Fill to get mask
    final mask = _performFloodFill(image, startX, startY, tolerance: state.floodFillTolerance);
    if (mask.isEmpty) return;

    // Trace boundary
    final boundary = _traceBoundary(mask, image.width, image.height);
    if (boundary.isEmpty) return;

    // Simplify path (simple Douglas-Peucker or just taking every Nth point)
    final simplified = _simplifyPath(boundary);

    // Convert back to component coordinates
    final componentPoints = simplified.map((p) {
      return Offset(p.dx / scaleX, p.dy / scaleY);
    }).toList();

    if (componentPoints.length < 3) return;

    _recordHistory();

    // Generate SVG path data
    // Find bounding box to normalize path
    double minX = componentPoints[0].dx;
    double minY = componentPoints[0].dy;
    double maxX = componentPoints[0].dx;
    double maxY = componentPoints[0].dy;

    for (final p in componentPoints) {
      if (p.dx < minX) minX = p.dx;
      if (p.dy < minY) minY = p.dy;
      if (p.dx > maxX) maxX = p.dx;
      if (p.dy > maxY) maxY = p.dy;
    }

    final width = maxX - minX;
    final height = maxY - minY;

    final buffer = StringBuffer();
    buffer.write('M ${componentPoints[0].dx - minX} ${componentPoints[0].dy - minY}');
    for (int i = 1; i < componentPoints.length; i++) {
      buffer.write(' L ${componentPoints[i].dx - minX} ${componentPoints[i].dy - minY}');
    }
    buffer.write(' Z');

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final newComponent = Component.pad(
      id: id,
      name: 'Mask $id',
      x: component.x + minX,
      y: component.y + minY,
      width: width,
      height: height,
      shape: PadShape.path,
      pathData: buffer.toString(),
      onColor: '#${event.color.value.toRadixString(16).padLeft(8, '0').substring(2)}',
      offColor: '#${event.color.value.toRadixString(16).padLeft(8, '0').substring(2)}33', // Semi-transparent off
    );

    final updatedLayers = [...project.layers, newComponent];
    emit(
      state.copyWith(
        project: project.copyWith(layers: updatedLayers),
        currentTool: EditorTool.select,
      ),
    );
  }

  void _onSetFloodFillTolerance(SetFloodFillTolerance event, Emitter<EditorState> emit) {
    emit(state.copyWith(floodFillTolerance: event.tolerance.clamp(0, 100)));
  }

  Set<img.Point> _performFloodFill(img.Image image, int startX, int startY, {int tolerance = 10}) {
    final width = image.width;
    final height = image.height;
    final visited = <img.Point>{};
    final queue = Queue<img.Point>();

    final startPoint = img.Point(startX, startY);
    queue.add(startPoint);
    visited.add(startPoint);

    final targetPixel = image.getPixel(startX, startY);
    final targetR = targetPixel.r;
    final targetG = targetPixel.g;
    final targetB = targetPixel.b;
    final targetA = targetPixel.a;

    bool colorsMatch(img.Pixel p) {
      if (p.a == 0 && targetA == 0) return true;
      final diff = (p.r - targetR).abs() + (p.g - targetG).abs() + (p.b - targetB).abs() + (p.a - targetA).abs();
      return diff <= (1020 * tolerance / 100);
    }

    while (queue.isNotEmpty) {
      final point = queue.removeFirst();
      final x = point.x.toInt();
      final y = point.y.toInt();

      final neighbors = [img.Point(x + 1, y), img.Point(x - 1, y), img.Point(x, y + 1), img.Point(x, y - 1)];

      for (final n in neighbors) {
        if (n.x >= 0 && n.x < width && n.y >= 0 && n.y < height) {
          if (!visited.contains(n)) {
            final pixel = image.getPixel(n.x.toInt(), n.y.toInt());
            if (colorsMatch(pixel)) {
              visited.add(n);
              queue.add(n);
            }
          }
        }
      }
    }
    return visited;
  }

  List<Offset> _traceBoundary(Set<img.Point> mask, int width, int height) {
    if (mask.isEmpty) return [];

    // Find top-left most point
    img.Point? startPoint;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final p = img.Point(x, y);
        if (mask.contains(p)) {
          startPoint = p;
          break;
        }
      }
      if (startPoint != null) break;
    }

    if (startPoint == null) return [];

    final boundary = <Offset>[];
    // Moore-Neighbor Tracing
    // Directions: N, NE, E, SE, S, SW, W, NW
    // 0: (0, -1), 1: (1, -1), 2: (1, 0), 3: (1, 1), 4: (0, 1), 5: (-1, 1), 6: (-1, 0), 7: (-1, -1)
    final dx = [0, 1, 1, 1, 0, -1, -1, -1];
    final dy = [-1, -1, 0, 1, 1, 1, 0, -1];

    var current = startPoint;
    // Start coming from South (relative to start point which is top-left, so we entered from outside)
    // Actually for top-left pixel, we enter from West (6) or North (0)?
    // Let's use standard Moore algorithm:
    // Start with pixel P. Backtrack direction B.
    // Scan neighbors in clockwise order starting from B.

    // Correct initialization:
    // Since we scanned row by row, startPoint is the first pixel.
    // The pixel above it (0, -1) is definitely NOT in mask.
    // So we can say we entered from North. Backtrack = 0 (North).
    // Wait, backtrack is where we came FROM. If we are at P, and came from North, neighbor 0 is previous.
    // Let's assume standard: P is current boundary pixel. B is pixel in background.
    // Initial P = startPoint. B = (x, y-1) which is outside.

    var bDir = 0; // North
    var cX = current.x.toInt();
    var cY = current.y.toInt();

    // Safety check loop
    int maxSteps = mask.length * 4;
    int steps = 0;

    boundary.add(Offset(cX.toDouble(), cY.toDouble()));

    var startX = cX;
    var startY = cY;

    // Find first neighbor
    // We start searching CLOCKWISE from B.
    // B is direction 0 (North).
    // Neighbors: 0, 1, 2, 3...

    // Actually, Moore tracing usually starts with B being the previous pixel on the boundary.
    // But for the first pixel, we need a B that is NOT in the mask.
    // (x, y-1) is not in mask.

    // Algorithm:
    // 1. Set B = N (0).
    // 2. Scan neighbors of P starting from B in clockwise direction.
    // 3. First neighbor found in mask is new P. The previous neighbor checked (which was not in mask) is new B.

    do {
      bool found = false;
      for (int i = 0; i < 8; i++) {
        // Check direction (bDir + i) % 8
        int dir = (bDir + i) % 8;
        int nX = cX + dx[dir];
        int nY = cY + dy[dir];

        if (mask.contains(img.Point(nX, nY))) {
          // Found next boundary pixel
          cX = nX;
          cY = nY;
          boundary.add(Offset(cX.toDouble(), cY.toDouble()));
          // New backtrack direction is the one opposite to where we came from?
          // No, in Moore, new B is the direction we just came from MINUS 1 (or something like that).
          // Actually, the rule is: enter P from B. Scan from B clockwise. First pixel is new P.
          // The pixel BEFORE new P in the scan order is the new B.
          // So if we found new P at 'dir', then 'dir - 1' (counter-clockwise) was empty and is new B.
          // In our direction array, index is clockwise.
          // So new B direction (relative to new P) is... complex.

          // Let's simplify:
          // We found neighbor at 'dir'.
          // We want to start scanning neighbors of new P.
          // We should start scanning from the neighbor that is "outside".
          // That neighbor is roughly "where we came from".
          // If we moved East (dir 2), we came from West (dir 6).
          // We should start scanning from roughly (dir + 4 + 1) or something?
          // Standard Moore: backtrack = (dir + 4) % 8. Then start scan from (backtrack + 1) % 8?
          // Let's try: start scan from (dir + 4 + 1) % 8? No, usually (dir + 5) % 8 or similar.
          // Jacob's stopping criterion: return to start AND next pixel is same as first next pixel.

          // Let's use a simpler approach:
          // Start scan from (dir + 4 + 1) % 8?
          // Actually, if we moved to 'dir', we entered new pixel from 'dir + 4'.
          // We want to start scanning from the "left" of where we entered to walk clockwise?
          // If we want to walk clockwise around the shape (keeping shape on right), we scan counter-clockwise?
          // Let's stick to: Scan Clockwise. Keep shape on right? No, usually keep shape on left?
          // If we scan clockwise for a neighbor, we are keeping "empty space" on our left?

          // Correct Moore Neighbor Tracing:
          // 1. Let B = backtrack direction (initially 0/North).
          // 2. Scan neighbors k = 0..7 starting from B.
          // 3. If neighbor (B+k)%8 is in mask:
          //    New P = neighbor.
          //    New B = (B+k-1)%8 (The empty neighbor just before the found one).
          //    Wait, B is a direction relative to P? Or absolute?
          //    Let's use absolute direction index for B.
          //    Start scanning from B.
          //    If found at 'dir', new scan start should be (dir + 5) % 8? Or (dir + 6)?
          //    Let's try: New start direction = (dir + 5) % 8.

          bDir = (dir + 5) % 8;
          found = true;
          break;
        }
      }

      if (!found) break; // Isolated pixel

      steps++;
      if (steps > maxSteps) break; // Loop protection
    } while (cX != startX || cY != startY);

    return boundary;
  }

  List<Offset> _simplifyPath(List<Offset> points) {
    if (points.length < 3) return points;
    // Simple simplification: take every Nth point or distance based
    final simplified = <Offset>[points.first];
    for (int i = 1; i < points.length - 1; i++) {
      if ((points[i] - simplified.last).distance > 2.0) {
        simplified.add(points[i]);
      }
    }
    simplified.add(points.last);
    return simplified;
  }

  Future<void> _onCopy(CopyEvent event, Emitter<EditorState> emit) async {
    final project = state.project;
    if (project == null || state.selectedComponentIds.isEmpty) return;

    final selectedComponents = project.layers.where((c) => state.selectedComponentIds.contains(c.id)).toList();
    if (selectedComponents.isEmpty) return;

    final jsonList = selectedComponents.map((c) => c.toJson()).toList();
    final jsonString = jsonEncode(jsonList);

    await Clipboard.setData(ClipboardData(text: jsonString));
  }

  Future<void> _onPaste(PasteEvent event, Emitter<EditorState> emit) async {
    final project = state.project;
    if (project == null) return;

    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text == null) return;

    try {
      final jsonList = jsonDecode(data!.text!) as List;
      final newComponents = <Component>[];
      final newIds = <String>{};

      for (final item in jsonList) {
        final component = Component.fromJson(item as Map<String, dynamic>);
        final newId = DateTime.now().millisecondsSinceEpoch.toString() + newComponents.length.toString();

        // Offset position slightly to make it visible
        final newComponent = component.copyWith(
          id: newId,
          x: component.x + 20,
          y: component.y + 20,
          name: '${component.name} (Copy)',
        );

        newComponents.add(newComponent);
        newIds.add(newId);
      }

      if (newComponents.isEmpty) return;

      _recordHistory();
      final updatedLayers = [...project.layers, ...newComponents];

      emit(
        state.copyWith(
          project: project.copyWith(layers: updatedLayers),
          selectedComponentIds: newIds,
        ),
      );
    } catch (e) {
      // Ignore invalid JSON or clipboard data not matching our format
      debugPrint('Paste failed: $e');
    }
  }

  Future<void> _onCut(CutEvent event, Emitter<EditorState> emit) async {
    await _onCopy(const CopyEvent(), emit);
    _onDelete(const DeleteEvent(), emit);
  }

  void _onDelete(DeleteEvent event, Emitter<EditorState> emit) {
    final project = state.project;
    if (project == null || state.selectedComponentIds.isEmpty) return;

    _recordHistory();
    final updatedLayers = project.layers.where((c) => !state.selectedComponentIds.contains(c.id)).toList();

    emit(
      state.copyWith(
        project: project.copyWith(layers: updatedLayers),
        selectedComponentIds: {},
      ),
    );
  }

  void _onDuplicate(DuplicateEvent event, Emitter<EditorState> emit) {
    final project = state.project;
    if (project == null || state.selectedComponentIds.isEmpty) return;

    final selectedComponents = project.layers.where((c) => state.selectedComponentIds.contains(c.id)).toList();
    if (selectedComponents.isEmpty) return;

    _recordHistory();
    final newComponents = <Component>[];
    final newIds = <String>{};

    for (final component in selectedComponents) {
      final newId = DateTime.now().millisecondsSinceEpoch.toString() + newComponents.length.toString();
      final newComponent = component.copyWith(
        id: newId,
        x: component.x + 20,
        y: component.y + 20,
        name: '${component.name} (Copy)',
      );
      newComponents.add(newComponent);
      newIds.add(newId);
    }

    final updatedLayers = [...project.layers, ...newComponents];

    emit(
      state.copyWith(
        project: project.copyWith(layers: updatedLayers),
        selectedComponentIds: newIds,
      ),
    );
  }

  // Helper to record history before mutation
  void _recordHistory() {
    final project = state.project;
    if (project != null) {
      _historyCubit?.record(project);
    }
  }
}
