import 'dart:typed_data';

import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

import 'package:midi_visualizer_studio/core/services/temporary_storage_service.dart';

class MockTemporaryStorageService extends TemporaryStorageService {
  @override
  Future<void> saveProject(Project project) async {
    // Do nothing
  }

  @override
  Future<bool> hasTemporaryProject(String originalId) async {
    return false;
  }

  @override
  Future<void> clearProject(String originalId) async {
    // Do nothing
  }
}

void main() {
  group('EditorBloc MIDI Handling', () {
    late EditorBloc editorBloc;

    setUp(() {
      editorBloc = EditorBloc(temporaryStorageService: MockTemporaryStorageService());
    });

    tearDown(() {
      editorBloc.close();
    });

    final padId = 'pad-1';
    final pad = Component.pad(
      id: padId,
      name: 'Test Pad',
      x: 0,
      y: 0,
      width: 100,
      height: 100,
      midiChannel: 0,
      midiNote: 60,
      velocityThreshold: 10,
    );
    final project = Project(
      id: 'test-project',
      name: 'Test Project',
      version: '1.0.0',
      layers: [pad],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Create a dummy MidiDevice
    final device = MidiDevice('device-1', 'Device 1', 'USB', true);

    test('handles multiple MIDI messages in a single packet (Note On + Note Off)', () async {
      editorBloc.add(EditorEvent.loadProject(path: '', project: project));

      // Wait for project to load
      await expectLater(
        editorBloc.stream,
        emitsThrough(isA<EditorState>().having((s) => s.status, 'status', EditorStatus.ready)),
      );

      // Packet containing Note On (Vel 100) AND Note Off (Vel 0) for the same note
      final data = Uint8List.fromList([0x90, 60, 100, 0x80, 60, 0]);
      final packet = MidiPacket(data, 0, device);
      editorBloc.add(EditorEvent.handleMidiMessage(packet));

      // Since the state starts OFF and ends OFF, EditorBloc might not emit a new state.
      // We wait a bit to ensure processing is done.
      await Future.delayed(const Duration(milliseconds: 50));

      // Verify that the pad is NOT active (i.e. not stuck ON)
      expect(editorBloc.state.activeComponentIds.contains(padId), false);
    });

    test('handles split messages (Note On then Note Off in separate packets)', () async {
      editorBloc.add(EditorEvent.loadProject(path: '', project: project));

      await expectLater(
        editorBloc.stream,
        emitsThrough(isA<EditorState>().having((s) => s.status, 'status', EditorStatus.ready)),
      );

      final onData = Uint8List.fromList([0x90, 60, 100]);
      editorBloc.add(EditorEvent.handleMidiMessage(MidiPacket(onData, 0, device)));

      await expectLater(
        editorBloc.stream,
        emits(isA<EditorState>().having((s) => s.activeComponentIds.contains(padId), 'activeIds contains padId', true)),
      );

      final offData = Uint8List.fromList([0x80, 60, 0]);
      editorBloc.add(EditorEvent.handleMidiMessage(MidiPacket(offData, 0, device)));

      await expectLater(
        editorBloc.stream,
        emits(
          isA<EditorState>().having((s) => s.activeComponentIds.contains(padId), 'activeIds contains padId', false),
        ),
      );
    });
  });
}
