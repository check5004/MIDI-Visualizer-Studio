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
  'canvasWidth': instance.canvasWidth,
  'canvasHeight': instance.canvasHeight,
  'backgroundColor': instance.backgroundColor,
  'chromaKeyColor': instance.chromaKeyColor,
  'layers': instance.layers.map((e) => e.toJson()).toList(),
};
