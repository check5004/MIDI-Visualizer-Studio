part of 'midi_bloc.dart';

@freezed
class MidiEvent with _$MidiEvent {
  const factory MidiEvent.scanDevices() = ScanDevices;
  const factory MidiEvent.connectDevice(MidiDevice device) = ConnectDevice;
  const factory MidiEvent.disconnectDevice(MidiDevice device) = DisconnectDevice;
  const factory MidiEvent.midiMessageReceived(MidiPacket packet) = MidiMessageReceived;
}
