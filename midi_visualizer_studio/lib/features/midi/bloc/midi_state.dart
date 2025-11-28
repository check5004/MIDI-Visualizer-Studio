part of 'midi_bloc.dart';

enum MidiStatus { initial, scanning, ready, error }

@freezed
abstract class MidiState with _$MidiState {
  const factory MidiState({
    @Default(MidiStatus.initial) MidiStatus status,
    @Default([]) List<MidiDevice> devices,
    MidiDevice? connectedDevice,
    MidiPacket? lastPacket,
    String? errorMessage,
  }) = _MidiState;
}
