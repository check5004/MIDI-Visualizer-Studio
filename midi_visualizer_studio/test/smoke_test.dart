import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:midi_visualizer_studio/core/router/app_router.dart';
import 'package:midi_visualizer_studio/core/services/midi_service.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';
import 'package:midi_visualizer_studio/features/common/services/color_history_service.dart';
import 'package:midi_visualizer_studio/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final midiService = MockMidiService();
    SharedPreferences.setMockInitialValues({});

    // Mock window_manager
    const channel = MethodChannel('window_manager');
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getBounds') {
        return {'x': 0.0, 'y': 0.0, 'width': 800.0, 'height': 600.0};
      }
      return null;
    });

    final prefs = await SharedPreferences.getInstance();
    final colorHistoryService = ColorHistoryService(prefs);
    final projectRepository = MockProjectRepository();
    await tester.pumpWidget(
      MidiVisualizerApp(
        midiService: midiService,
        prefs: prefs,
        colorHistoryService: colorHistoryService,
        projectRepository: projectRepository,
        routerConfig: createAppRouter(),
      ),
    );

    // Wait for Splash Screen animation and timer
    for (int i = 0; i < 25; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    // Verify we are in Home Screen
    expect(find.text('Dashboard'), findsOneWidget);
  });
}

class MockMidiService implements MidiService {
  @override
  Stream<MidiPacket> get onMidiDataReceived => const Stream.empty();

  @override
  Future<List<MidiDevice>> get devices async => [];

  @override
  Future<void> connectToDevice(MidiDevice device) async {}

  @override
  Future<void> disconnectDevice(MidiDevice device) async {}

  @override
  void dispose() {}
}

class MockProjectRepository implements ProjectRepository {
  @override
  Future<List<Project>> getProjects() async => [];

  @override
  Project createEmptyProject() {
    return Project(
      id: 'test',
      name: 'Test Project',
      version: '1.0.0',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      layers: [],
    );
  }

  @override
  Future<void> saveProject(Project project) async {}

  @override
  Future<void> exportProject(Project project, String path) async {}

  @override
  Future<void> importProject(String sourcePath) async {}

  @override
  Future<Project> loadProject(String path) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProject(String id) async {}

  @override
  Project createProject({required int rows, required int cols}) {
    throw UnimplementedError();
  }
}
