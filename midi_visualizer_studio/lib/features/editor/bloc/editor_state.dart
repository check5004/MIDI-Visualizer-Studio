import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';

part 'editor_state.freezed.dart';

enum EditorStatus { initial, loading, ready, error }

enum EditorMode { edit, play, overlay }

enum EditorTool { select, path, bucketFill, rectangle }

@freezed
abstract class EditorState with _$EditorState {
  const factory EditorState({
    @Default(EditorStatus.initial) EditorStatus status,
    Project? project,
    @Default(EditorMode.edit) EditorMode mode,
    @Default(EditorTool.select) EditorTool currentTool,
    @Default(1.0) double zoomLevel,
    @Default(Offset.zero) Offset viewOffset,
    @Default(Size.zero) Size viewportSize,
    @Default([]) List<Offset> currentPathPoints,
    @Default(true) bool showGrid,
    @Default(true) bool snapToGrid,
    @Default(10.0) double gridSize,
    @Default(10) int floodFillTolerance,
    @Default({}) Set<String> selectedComponentIds,
    @Default({}) Set<String> activeComponentIds,
    String? lastSelectedId,
    String? errorMessage,
  }) = _EditorState;
}
