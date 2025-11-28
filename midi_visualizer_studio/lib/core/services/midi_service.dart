import 'dart:async';
import 'package:flutter_midi_command/flutter_midi_command.dart';

class MidiService {
  final MidiCommand _midiCommand = MidiCommand();

  Stream<MidiPacket> get onMidiDataReceived => _midiCommand.onMidiDataReceived ?? const Stream.empty();

  Future<List<MidiDevice>> get devices async => await _midiCommand.devices ?? [];

  Future<void> connectToDevice(MidiDevice device) async {
    await _midiCommand.connectToDevice(device);
  }

  Future<void> disconnectDevice(MidiDevice device) async {
    _midiCommand.disconnectDevice(device);
  }

  void dispose() {
    // Cleanup if needed
  }
}
