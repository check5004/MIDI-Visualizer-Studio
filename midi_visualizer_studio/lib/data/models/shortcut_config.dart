import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shortcut_config.freezed.dart';
part 'shortcut_config.g.dart';

@freezed
abstract class ShortcutConfig with _$ShortcutConfig {
  const ShortcutConfig._();

  const factory ShortcutConfig({
    required int keyId,
    @Default(false) bool isControl,
    @Default(false) bool isMeta,
    @Default(false) bool isAlt,
    @Default(false) bool isShift,
  }) = _ShortcutConfig;

  factory ShortcutConfig.fromJson(Map<String, dynamic> json) => _$ShortcutConfigFromJson(json);

  SingleActivator toActivator() {
    return SingleActivator(
      LogicalKeyboardKey.findKeyByKeyId(keyId) ?? LogicalKeyboardKey.keyA, // Fallback if not found, though unlikely
      control: isControl,
      meta: isMeta,
      alt: isAlt,
      shift: isShift,
    );
  }

  static ShortcutConfig fromActivator(SingleActivator activator) {
    // SingleActivator stores trigger as LogicalKeyboardKey
    return ShortcutConfig(
      keyId: activator.trigger.keyId,
      isControl: activator.control,
      isMeta: activator.meta,
      isAlt: activator.alt,
      isShift: activator.shift,
    );
  }

  String get label {
    final parts = <String>[];
    if (isMeta) parts.add('Cmd');
    if (isControl) parts.add('Ctrl');
    if (isAlt) parts.add('Alt');
    if (isShift) parts.add('Shift');

    final keyLabel = LogicalKeyboardKey.findKeyByKeyId(keyId)?.keyLabel ?? 'Unknown';
    parts.add(keyLabel.toUpperCase());

    return parts.join('+');
  }
}
