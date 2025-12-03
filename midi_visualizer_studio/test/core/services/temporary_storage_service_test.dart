import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/core/services/temporary_storage_service.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPathProviderPlatform extends Fake with MockPlatformInterfaceMixin implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return '.';
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PathProviderPlatform.instance = MockPathProviderPlatform();

  group('TemporaryStorageService', () {
    late TemporaryStorageService service;
    late Project testProject;

    setUp(() {
      service = TemporaryStorageService();
      testProject = const Project(id: 'test_project', name: 'Test Project', version: '1.0.0');
    });

    test('saveProject saves project to file', () async {
      await service.saveProject(testProject);
      final hasTemp = await service.hasTemporaryProject(testProject.id);
      expect(hasTemp, true);
    });

    test('loadProject loads saved project', () async {
      await service.saveProject(testProject);
      final loadedProject = await service.loadProject(testProject.id);
      expect(loadedProject, isNotNull);
      expect(loadedProject?.id, testProject.id);
    });

    test('clearProject removes temporary file', () async {
      await service.saveProject(testProject);
      await service.clearProject(testProject.id);
      final hasTemp = await service.hasTemporaryProject(testProject.id);
      expect(hasTemp, false);
    });
  });
}
