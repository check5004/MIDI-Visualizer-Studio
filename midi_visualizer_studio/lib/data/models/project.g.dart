// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Project _$ProjectFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Project', json, ($checkedConvert) {
      final val = _Project(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        version: $checkedConvert('version', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String? ?? ''),
        author: $checkedConvert('author', (v) => v as String? ?? ''),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        canvasWidth: $checkedConvert(
          'canvasWidth',
          (v) => (v as num?)?.toDouble() ?? 800,
        ),
        canvasHeight: $checkedConvert(
          'canvasHeight',
          (v) => (v as num?)?.toDouble() ?? 600,
        ),
        backgroundColor: $checkedConvert(
          'backgroundColor',
          (v) => v as String? ?? '#000000',
        ),
        chromaKeyColor: $checkedConvert(
          'chromaKeyColor',
          (v) => v as String? ?? '#00FF00',
        ),
        layers: $checkedConvert(
          'layers',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => Component.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
        ),
      );
      return val;
    });

Map<String, dynamic> _$ProjectToJson(_Project instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'version': instance.version,
  'description': instance.description,
  'author': instance.author,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'canvasWidth': instance.canvasWidth,
  'canvasHeight': instance.canvasHeight,
  'backgroundColor': instance.backgroundColor,
  'chromaKeyColor': instance.chromaKeyColor,
  'layers': instance.layers.map((e) => e.toJson()).toList(),
};
