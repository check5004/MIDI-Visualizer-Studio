import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
abstract class Project with _$Project {
  const factory Project({
    required String id,
    required String name,
    required String version,
    @Default('') String description,
    @Default('') String author,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(800) double canvasWidth,
    @Default(600) double canvasHeight,
    @Default('#000000') String backgroundColor,
    @Default('#00FF00') String chromaKeyColor,
    double? previewWindowWidth,
    double? previewWindowHeight,
    @Default([]) List<Component> layers,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}
