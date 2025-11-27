// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComponentPad _$ComponentPadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ComponentPad', json, ($checkedConvert) {
  final val = ComponentPad(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    x: $checkedConvert('x', (v) => (v as num).toDouble()),
    y: $checkedConvert('y', (v) => (v as num).toDouble()),
    width: $checkedConvert('width', (v) => (v as num).toDouble()),
    height: $checkedConvert('height', (v) => (v as num).toDouble()),
    rotation: $checkedConvert('rotation', (v) => (v as num?)?.toDouble() ?? 0),
    zIndex: $checkedConvert('zIndex', (v) => (v as num?)?.toInt() ?? 0),
    isLocked: $checkedConvert('isLocked', (v) => v as bool? ?? false),
    shape: $checkedConvert(
      'shape',
      (v) => $enumDecodeNullable(_$PadShapeEnumMap, v) ?? PadShape.rect,
    ),
    pathData: $checkedConvert('pathData', (v) => v as String?),
    onColor: $checkedConvert('onColor', (v) => v as String? ?? '#00FF00'),
    offColor: $checkedConvert('offColor', (v) => v as String? ?? '#333333'),
    midiChannel: $checkedConvert('midiChannel', (v) => (v as num?)?.toInt()),
    midiNote: $checkedConvert('midiNote', (v) => (v as num?)?.toInt()),
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$ComponentPadToJson(ComponentPad instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'rotation': instance.rotation,
      'zIndex': instance.zIndex,
      'isLocked': instance.isLocked,
      'shape': _$PadShapeEnumMap[instance.shape]!,
      'pathData': instance.pathData,
      'onColor': instance.onColor,
      'offColor': instance.offColor,
      'midiChannel': instance.midiChannel,
      'midiNote': instance.midiNote,
      'type': instance.$type,
    };

const _$PadShapeEnumMap = {
  PadShape.rect: 'rect',
  PadShape.circle: 'circle',
  PadShape.path: 'path',
};

ComponentKnob _$ComponentKnobFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ComponentKnob', json, ($checkedConvert) {
  final val = ComponentKnob(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    x: $checkedConvert('x', (v) => (v as num).toDouble()),
    y: $checkedConvert('y', (v) => (v as num).toDouble()),
    width: $checkedConvert('width', (v) => (v as num).toDouble()),
    height: $checkedConvert('height', (v) => (v as num).toDouble()),
    rotation: $checkedConvert('rotation', (v) => (v as num?)?.toDouble() ?? 0),
    zIndex: $checkedConvert('zIndex', (v) => (v as num?)?.toInt() ?? 0),
    isLocked: $checkedConvert('isLocked', (v) => v as bool? ?? false),
    style: $checkedConvert(
      'style',
      (v) => $enumDecodeNullable(_$KnobStyleEnumMap, v) ?? KnobStyle.vectorArc,
    ),
    minAngle: $checkedConvert(
      'minAngle',
      (v) => (v as num?)?.toDouble() ?? -135.0,
    ),
    maxAngle: $checkedConvert(
      'maxAngle',
      (v) => (v as num?)?.toDouble() ?? 135.0,
    ),
    isRelative: $checkedConvert('isRelative', (v) => v as bool? ?? false),
    relativeEffect: $checkedConvert(
      'relativeEffect',
      (v) =>
          $enumDecodeNullable(_$KnobRelativeEffectEnumMap, v) ??
          KnobRelativeEffect.tint,
    ),
    midiChannel: $checkedConvert('midiChannel', (v) => (v as num?)?.toInt()),
    midiCc: $checkedConvert('midiCc', (v) => (v as num?)?.toInt()),
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$ComponentKnobToJson(ComponentKnob instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'rotation': instance.rotation,
      'zIndex': instance.zIndex,
      'isLocked': instance.isLocked,
      'style': _$KnobStyleEnumMap[instance.style]!,
      'minAngle': instance.minAngle,
      'maxAngle': instance.maxAngle,
      'isRelative': instance.isRelative,
      'relativeEffect': _$KnobRelativeEffectEnumMap[instance.relativeEffect]!,
      'midiChannel': instance.midiChannel,
      'midiCc': instance.midiCc,
      'type': instance.$type,
    };

const _$KnobStyleEnumMap = {
  KnobStyle.imageRotate: 'imageRotate',
  KnobStyle.vectorArc: 'vectorArc',
  KnobStyle.hybrid: 'hybrid',
};

const _$KnobRelativeEffectEnumMap = {
  KnobRelativeEffect.tint: 'tint',
  KnobRelativeEffect.pop: 'pop',
  KnobRelativeEffect.spin: 'spin',
};
