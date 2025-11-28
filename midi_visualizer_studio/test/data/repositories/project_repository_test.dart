import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';

void main() {
  group('ProjectRepository', () {
    late ProjectRepository repository;

    setUp(() {
      repository = ProjectRepository();
    });

    test('createProject creates a project with correct grid of pads', () {
      const rows = 3;
      const cols = 4;
      final project = repository.createProject(rows: rows, cols: cols);

      expect(project.name, 'New Project');
      expect(project.layers.length, rows * cols);

      // Check if layers are pads and have correct positions
      // We can check the first and last pad to verify grid logic

      // Check first pad
      final firstPad = project.layers.first;
      if (firstPad is ComponentPad) {
        expect(firstPad.name, 'Pad 1');
        expect(firstPad.x, greaterThan(0));
        expect(firstPad.y, greaterThan(0));
      } else {
        fail('First component should be a pad');
      }

      // Check last pad
      final lastPad = project.layers.last;
      if (lastPad is ComponentPad) {
        expect(lastPad.name, 'Pad ${rows * cols}');
        expect(lastPad.x, greaterThan(firstPad.x));
        expect(lastPad.y, greaterThan(firstPad.y));
      } else {
        fail('Last component should be a pad');
      }
    });

    test('createEmptyProject creates a project with no layers', () {
      final project = repository.createEmptyProject();

      expect(project.name, 'New Project');
      expect(project.layers, isEmpty);
    });
  });
}
