// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortcut_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShortcutConfig _$ShortcutConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ShortcutConfig', json, ($checkedConvert) {
      final val = _ShortcutConfig(
        keyId: $checkedConvert('keyId', (v) => (v as num).toInt()),
        isControl: $checkedConvert('isControl', (v) => v as bool? ?? false),
        isMeta: $checkedConvert('isMeta', (v) => v as bool? ?? false),
        isAlt: $checkedConvert('isAlt', (v) => v as bool? ?? false),
        isShift: $checkedConvert('isShift', (v) => v as bool? ?? false),
      );
      return val;
    });

Map<String, dynamic> _$ShortcutConfigToJson(_ShortcutConfig instance) =>
    <String, dynamic>{
      'keyId': instance.keyId,
      'isControl': instance.isControl,
      'isMeta': instance.isMeta,
      'isAlt': instance.isAlt,
      'isShift': instance.isShift,
    };
