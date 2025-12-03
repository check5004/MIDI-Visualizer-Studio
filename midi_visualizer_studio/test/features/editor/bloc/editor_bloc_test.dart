import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/history_bloc.dart';

class FakeHistoryCubit extends HistoryCubit {
  @override
  void record(Project project) {}
  @override
  Project? undo(Project currentProject) => null;
  @override
  Project? redo(Project currentProject) => null;
}

class FakeProjectRepository extends ProjectRepository {
  @override
  Future<void> saveProjectInternal(Project project) async {}
  @override
  Future<Project> loadProject(String path) async {
    return Project(id: 'test', name: 'Test Project', version: '1.0.0', layers: []);
  }
}

void main() {
  group('EditorBloc MIDI Feedback', () {
    late HistoryCubit historyCubit;
    late ProjectRepository projectRepository;
    late EditorBloc editorBloc;

    final testProject = Project(
      id: 'test',
      name: 'Test Project',
      version: '1.0.0',
      layers: [
        const Component.pad(
          id: 'pad1',
          name: 'Pad 1',
          x: 0,
          y: 0,
          width: 100,
          height: 100,
          midiChannel: 0,
          midiNote: 60, // C4
        ),
      ],
    );

    setUp(() {
      historyCubit = FakeHistoryCubit();
      projectRepository = FakeProjectRepository();
      editorBloc = EditorBloc(historyCubit: historyCubit, projectRepository: projectRepository);
      // Initialize with test project
      editorBloc.emit(EditorState(project: testProject, status: EditorStatus.ready));
    });

    tearDown(() {
      editorBloc.close();
    });

    test('activates component on Note On', () async {
      final packet = MidiPacket(
        Uint8List.fromList([0x90, 60, 100]), // Note On Ch 0, Note 60, Vel 100
        0,
        MidiDevice('test', 'test', 'input', false),
      );

      editorBloc.add(EditorEvent.handleMidiMessage(packet));

      await expectLater(
        editorBloc.stream,
        emitsThrough(isA<EditorState>().having((s) => s.activeComponentIds, 'activeComponentIds', {'pad1'})),
      );
    });

    test('deactivates component on Note Off', () async {
      // Set initial state with active component
      editorBloc.emit(EditorState(project: testProject, status: EditorStatus.ready, activeComponentIds: {'pad1'}));

      final packet = MidiPacket(
        Uint8List.fromList([0x80, 60, 0]), // Note Off Ch 0, Note 60, Vel 0
        0,
        MidiDevice('test', 'test', 'input', false),
      );

      editorBloc.add(EditorEvent.handleMidiMessage(packet));

      await expectLater(
        editorBloc.stream,
        emitsThrough(isA<EditorState>().having((s) => s.activeComponentIds, 'activeComponentIds', isEmpty)),
      );
    });

    test('deactivates component on Note On with velocity 0', () async {
      // Set initial state with active component
      editorBloc.emit(EditorState(project: testProject, status: EditorStatus.ready, activeComponentIds: {'pad1'}));

      final packet = MidiPacket(
        Uint8List.fromList([0x90, 60, 0]), // Note On Ch 0, Note 60, Vel 0
        0,
        MidiDevice('test', 'test', 'input', false),
      );

      editorBloc.add(EditorEvent.handleMidiMessage(packet));

      await expectLater(
        editorBloc.stream,
        emitsThrough(isA<EditorState>().having((s) => s.activeComponentIds, 'activeComponentIds', isEmpty)),
      );
    });

    test('ignores unmatched MIDI messages', () async {
      final packet = MidiPacket(
        Uint8List.fromList([0x90, 61, 100]), // Note On Ch 0, Note 61 (Mismatch)
        0,
        MidiDevice('test', 'test', 'input', false),
      );

      editorBloc.add(EditorEvent.handleMidiMessage(packet));

      // Expect no state change related to activeComponentIds
      // Since we can't easily check "no emit" with emitsThrough without timeout,
      // we check that if it emits, it doesn't have 'pad1'.
      // But actually, if it doesn't emit, expectLater might hang.
      // So we can use a shorter timeout or just skip this test if we are confident.
      // Or we can check that the state remains empty.

      // For simplicity, let's just check that it doesn't crash and if it emits, it's not active.
      // But EditorBloc logic says "if (changed) emit(...)". So it shouldn't emit.
      // Checking "does not emit" is hard.
      // We can verify that after a small delay, state is still empty.

      await Future.delayed(const Duration(milliseconds: 50));
      expect(editorBloc.state.activeComponentIds, isEmpty);
    });
  });

  group('EditorBloc Clipboard & Editing', () {
    late HistoryCubit historyCubit;
    late ProjectRepository projectRepository;
    late EditorBloc editorBloc;

    final testProject = Project(
      id: 'test',
      name: 'Test Project',
      version: '1.0.0',
      layers: [const Component.pad(id: 'pad1', name: 'Pad 1', x: 0, y: 0, width: 100, height: 100)],
    );

    setUp(() {
      historyCubit = FakeHistoryCubit();
      projectRepository = FakeProjectRepository();
      editorBloc = EditorBloc(historyCubit: historyCubit, projectRepository: projectRepository);
      editorBloc.emit(EditorState(project: testProject, status: EditorStatus.ready));
    });

    tearDown(() {
      editorBloc.close();
    });

    test('deletes selected component', () async {
      // Select component
      editorBloc.add(const EditorEvent.selectComponent('pad1', multiSelect: false));
      await Future.delayed(Duration.zero); // Wait for event processing if needed, or just rely on stream

      // Delete
      editorBloc.add(const EditorEvent.delete());

      await expectLater(
        editorBloc.stream,
        emitsThrough(isA<EditorState>().having((s) => s.project!.layers.length, 'layers length', 0)),
      );
    });

    test('duplicates selected component', () async {
      // Select component
      editorBloc.add(const EditorEvent.selectComponent('pad1', multiSelect: false));

      // Duplicate
      editorBloc.add(const EditorEvent.duplicate());

      await expectLater(
        editorBloc.stream,
        emitsThrough(isA<EditorState>().having((s) => s.project!.layers.length, 'layers length', 2)),
      );

      final state = editorBloc.state;
      expect(state.project!.layers.length, 2);
      final newComponent = state.project!.layers.last;
      expect(newComponent.id, isNot('pad1'));
      expect(newComponent.x, 20.0); // Offset by 20
      expect(newComponent.y, 20.0);
      expect(state.selectedComponentIds, {newComponent.id});
    });
  });
  group('EditorBloc Selection', () {
    late HistoryCubit historyCubit;
    late ProjectRepository projectRepository;
    late EditorBloc editorBloc;

    final testProject = Project(
      id: 'test',
      name: 'Test Project',
      version: '1.0.0',
      layers: [
        const Component.pad(id: 'pad1', name: 'Pad 1', x: 0, y: 0, width: 100, height: 100),
        const Component.pad(id: 'pad2', name: 'Pad 2', x: 100, y: 0, width: 100, height: 100),
        const Component.pad(id: 'pad3', name: 'Pad 3', x: 200, y: 0, width: 100, height: 100),
      ],
    );

    setUp(() {
      historyCubit = FakeHistoryCubit();
      projectRepository = FakeProjectRepository();
      editorBloc = EditorBloc(historyCubit: historyCubit, projectRepository: projectRepository);
      editorBloc.emit(EditorState(project: testProject, status: EditorStatus.ready));
    });

    tearDown(() {
      editorBloc.close();
    });

    test('updates lastSelectedId on single selection', () async {
      editorBloc.add(const EditorEvent.selectComponent('pad1', multiSelect: false));

      await expectLater(
        editorBloc.stream,
        emitsThrough(
          isA<EditorState>()
              .having((s) => s.selectedComponentIds, 'selected', {'pad1'})
              .having((s) => s.lastSelectedId, 'lastSelectedId', 'pad1'),
        ),
      );
    });

    test('SelectComponents replaces selection when multiSelect is false', () async {
      // Initial selection
      editorBloc.add(const EditorEvent.selectComponent('pad1', multiSelect: false));
      await Future.delayed(Duration.zero);

      // Select multiple (replace)
      editorBloc.add(const EditorEvent.selectComponents(['pad2', 'pad3'], multiSelect: false));

      await expectLater(
        editorBloc.stream,
        emitsThrough(
          isA<EditorState>()
              .having((s) => s.selectedComponentIds, 'selected', {'pad2', 'pad3'})
              .having((s) => s.lastSelectedId, 'lastSelectedId', 'pad3'),
        ),
      );
    });

    test('SelectComponents adds to selection when multiSelect is true', () async {
      // Initial selection
      editorBloc.add(const EditorEvent.selectComponent('pad1', multiSelect: false));
      await Future.delayed(Duration.zero);

      // Add to selection
      editorBloc.add(const EditorEvent.selectComponents(['pad2'], multiSelect: true));

      await expectLater(
        editorBloc.stream,
        emitsThrough(
          isA<EditorState>()
              .having((s) => s.selectedComponentIds, 'selected', {'pad1', 'pad2'})
              .having((s) => s.lastSelectedId, 'lastSelectedId', 'pad2'),
        ),
      );
    });
  });

  group('EditorBloc Shape Drawing', () {
    late HistoryCubit historyCubit;
    late ProjectRepository projectRepository;
    late EditorBloc editorBloc;

    final testProject = Project(id: 'test', name: 'Test Project', version: '1.0.0', layers: []);

    setUp(() {
      historyCubit = FakeHistoryCubit();
      projectRepository = FakeProjectRepository();
      editorBloc = EditorBloc(historyCubit: historyCubit, projectRepository: projectRepository);
      editorBloc.emit(EditorState(project: testProject, status: EditorStatus.ready));
    });

    tearDown(() {
      editorBloc.close();
    });

    test('StartDrawing sets initial state', () async {
      const startPoint = Offset(100, 100);
      editorBloc.add(const EditorEvent.startDrawing(startPoint));

      await expectLater(
        editorBloc.stream,
        emitsThrough(
          isA<EditorState>()
              .having((s) => s.drawingStartPoint, 'drawingStartPoint', startPoint)
              .having((s) => s.currentDrawingRect, 'currentDrawingRect', Rect.fromPoints(startPoint, startPoint)),
        ),
      );
    });

    test('UpdateDrawing updates rect', () async {
      const startPoint = Offset(100, 100);
      editorBloc.add(const EditorEvent.startDrawing(startPoint));
      await Future.delayed(Duration.zero);

      const endPoint = Offset(200, 200);
      editorBloc.add(const EditorEvent.updateDrawing(endPoint));

      await expectLater(
        editorBloc.stream,
        emitsThrough(
          isA<EditorState>().having(
            (s) => s.currentDrawingRect,
            'currentDrawingRect',
            Rect.fromPoints(startPoint, endPoint),
          ),
        ),
      );
    });

    test('FinishDrawing creates component', () async {
      const startPoint = Offset(100, 100);
      editorBloc.add(const EditorEvent.startDrawing(startPoint));
      await Future.delayed(Duration.zero);

      const endPoint = Offset(200, 200);
      editorBloc.add(const EditorEvent.updateDrawing(endPoint));
      await Future.delayed(Duration.zero);

      editorBloc.add(const EditorEvent.finishDrawing());

      await expectLater(
        editorBloc.stream,
        emitsThrough(
          isA<EditorState>()
              .having((s) => s.project!.layers.length, 'layers length', 1)
              .having((s) => s.drawingStartPoint, 'drawingStartPoint', isNull)
              .having((s) => s.currentDrawingRect, 'currentDrawingRect', isNull),
        ),
      );
    });
  });
}
