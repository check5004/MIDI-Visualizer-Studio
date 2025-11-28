import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:midi_visualizer_studio/core/services/midi_service.dart';

part 'midi_event.dart';
part 'midi_state.dart';
part 'midi_bloc.freezed.dart';

class MidiBloc extends Bloc<MidiEvent, MidiState> {
  final MidiService _midiService;
  StreamSubscription<MidiPacket>? _midiSubscription;

  MidiBloc(this._midiService) : super(const MidiState()) {
    on<ScanDevices>(_onScanDevices);
    on<ConnectDevice>(_onConnectDevice);
    on<DisconnectDevice>(_onDisconnectDevice);
    on<MidiMessageReceived>(_onMidiMessageReceived);

    // Initial scan
    add(const MidiEvent.scanDevices());

    // Listen to MIDI stream
    _midiSubscription = _midiService.onMidiDataReceived.listen((packet) {
      add(MidiEvent.midiMessageReceived(packet));
    });
  }

  Future<void> _onScanDevices(ScanDevices event, Emitter<MidiState> emit) async {
    emit(state.copyWith(status: MidiStatus.scanning));
    try {
      final devices = await _midiService.devices;
      emit(state.copyWith(status: MidiStatus.ready, devices: devices));
    } catch (e) {
      emit(state.copyWith(status: MidiStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onConnectDevice(ConnectDevice event, Emitter<MidiState> emit) async {
    try {
      await _midiService.connectToDevice(event.device);
      emit(state.copyWith(connectedDevice: event.device));
    } catch (e) {
      emit(state.copyWith(status: MidiStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onDisconnectDevice(DisconnectDevice event, Emitter<MidiState> emit) async {
    try {
      await _midiService.disconnectDevice(event.device);
      emit(state.copyWith(connectedDevice: null));
    } catch (e) {
      emit(state.copyWith(status: MidiStatus.error, errorMessage: e.toString()));
    }
  }

  void _onMidiMessageReceived(MidiMessageReceived event, Emitter<MidiState> emit) {
    emit(state.copyWith(lastPacket: event.packet));
  }

  @override
  Future<void> close() {
    _midiSubscription?.cancel();
    return super.close();
  }
}
