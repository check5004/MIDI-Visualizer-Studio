import 'package:freezed_annotation/freezed_annotation.dart';

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
    @Default(PadShape.rect) PadShape shape,
    String? pathData,
    @Default('#00FF00') String onColor,
    @Default('#333333') String offColor,
    int? midiChannel,
    int? midiNote,
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
    @Default(KnobStyle.vectorArc) KnobStyle style,
    @Default(-135.0) double minAngle,
    @Default(135.0) double maxAngle,
    @Default(false) bool isRelative,
    @Default(KnobRelativeEffect.tint) KnobRelativeEffect relativeEffect,
    int? midiChannel,
    int? midiCc,
  }) = ComponentKnob;

  factory Component.fromJson(Map<String, dynamic> json) => _$ComponentFromJson(json);
}
