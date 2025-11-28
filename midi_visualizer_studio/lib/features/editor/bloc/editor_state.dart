import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';

part 'editor_state.freezed.dart';

enum EditorStatus { initial, loading, ready, error }

enum EditorMode { edit, play, overlay }

enum EditorTool { select, rectangle, circle, path }

@freezed
abstract class EditorState with _$EditorState {
  const factory EditorState({
    @Default(EditorStatus.initial) EditorStatus status,
    Project? project,
    @Default({}) Set<String> selectedComponentIds,
    @Default(EditorMode.edit) EditorMode mode,
    @Default(1.0) double zoomLevel,
    @Default(EditorTool.select) EditorTool currentTool,
    @Default([]) List<Offset> currentPathPoints,
    @Default(20.0) double gridSize,
    @Default(true) bool showGrid,
    @Default(true) bool snapToGrid,
    @Default({}) Set<String> activeComponentIds,
    String? errorMessage,
  }) = _EditorState;
}
