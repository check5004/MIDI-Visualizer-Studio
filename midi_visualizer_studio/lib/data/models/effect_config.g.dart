// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'effect_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EffectConfig _$EffectConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EffectConfig', json, ($checkedConvert) {
      final val = _EffectConfig(
        type: $checkedConvert(
          'type',
          (v) => $enumDecodeNullable(_$EffectTypeEnumMap, v) ?? EffectType.none,
        ),
        durationMs: $checkedConvert(
          'durationMs',
          (v) => (v as num?)?.toInt() ?? 300,
        ),
        scale: $checkedConvert('scale', (v) => (v as num?)?.toDouble() ?? 1.5),
      );
      return val;
    });

Map<String, dynamic> _$EffectConfigToJson(_EffectConfig instance) =>
    <String, dynamic>{
      'type': _$EffectTypeEnumMap[instance.type]!,
      'durationMs': instance.durationMs,
      'scale': instance.scale,
    };

const _$EffectTypeEnumMap = {
  EffectType.none: 'none',
  EffectType.fade: 'fade',
  EffectType.ripple: 'ripple',
};
