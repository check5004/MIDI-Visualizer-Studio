import 'package:freezed_annotation/freezed_annotation.dart';

part 'effect_config.freezed.dart';
part 'effect_config.g.dart';

enum EffectType { none, fade, ripple }

@freezed
abstract class EffectConfig with _$EffectConfig {
  const factory EffectConfig({
    @Default(EffectType.none) EffectType type,
    @Default(300) int durationMs,
    @Default(1.5) double scale,
  }) = _EffectConfig;

  factory EffectConfig.fromJson(Map<String, dynamic> json) => _$EffectConfigFromJson(json);
}
