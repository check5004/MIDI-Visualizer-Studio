import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:midi_visualizer_studio/data/models/effect_config.dart';

part 'component.freezed.dart';
part 'component.g.dart';

enum ComponentType { pad, knob, fader, staticImage }

enum PadShape { rect, circle, path }

enum KnobStyle { imageRotate, vectorArc, hybrid }

enum KnobRelativeEffect { tint, pop, spin }

@freezed
abstract class Component with _$Component {
  const factory Component.pad({
    required String id,
    required String name,
    required double x,
    required double y,
    required double width,
    required double height,
    @Default(0) double rotation,
    @Default(0) int zIndex,
    @Default(false) bool isLocked,
    @Default(true) bool isVisible,
    @Default(PadShape.rect) PadShape shape,
    String? pathData,
    String? originalPathData,
    @Default(0.0) double smoothingAmount,
    @Default(0.0) double cornerRadius,
    @Default(0.0) double borderWidth,
    @Default('#FFFFFF') String borderColor,
    @Default('#00FF00') String onColor,
    @Default('#333333') String offColor,
    int? midiChannel,
    int? midiNote,
    @Default(0) int velocityThreshold,
    @Default(false) bool maintainAspectRatio,
    EffectConfig? onEffectConfig,
    EffectConfig? offEffectConfig,
  }) = ComponentPad;

  const factory Component.knob({
    required String id,
    required String name,
    required double x,
    required double y,
    required double width,
    required double height,
    @Default(0) double rotation,
    @Default(0) int zIndex,
    @Default(false) bool isLocked,
    @Default(true) bool isVisible,
    @Default(KnobStyle.vectorArc) KnobStyle style,
    @Default(-135.0) double minAngle,
    @Default(135.0) double maxAngle,
    @Default(false) bool isRelative,
    @Default(KnobRelativeEffect.tint) KnobRelativeEffect relativeEffect,
    String? knobImage,
    String? pointerImage,
    int? midiChannel,
    int? midiCc,
    @Default(0) int velocityThreshold,
    @Default(false) bool maintainAspectRatio,
    EffectConfig? onEffectConfig,
    EffectConfig? offEffectConfig,
  }) = ComponentKnob;

  const factory Component.staticImage({
    required String id,
    required String name,
    required double x,
    required double y,
    required double width,
    required double height,
    @Default(0) double rotation,
    @Default(0) int zIndex,
    @Default(false) bool isLocked,
    @Default(true) bool isVisible,
    required String imagePath,
    @Default(true) bool maintainAspectRatio,
  }) = ComponentStaticImage;

  factory Component.fromJson(Map<String, dynamic> json) => _$ComponentFromJson(json);
}
