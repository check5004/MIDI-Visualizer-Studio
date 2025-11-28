import 'dart:convert';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:uuid/uuid.dart';

class ProjectRepository {
  Future<void> saveProject(Project project, String path) async {
    final encoder = ZipFileEncoder();
    encoder.create(path);

    // Convert project to JSON
    final jsonStr = jsonEncode(project.toJson());

    // Add project.json to archive
    encoder.addArchiveFile(ArchiveFile('project.json', jsonStr.length, utf8.encode(jsonStr)));

    // TODO: Add image assets if any

    encoder.close();
  }

  Future<Project> loadProject(String path) async {
    final bytes = await File(path).readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    final projectFile = archive.findFile('project.json');
    if (projectFile == null) {
      throw Exception('Invalid project file: project.json not found');
    }

    final jsonStr = utf8.decode(projectFile.content as List<int>);
    final jsonMap = jsonDecode(jsonStr) as Map<String, dynamic>;

    return Project.fromJson(jsonMap);
  }

  Project createProject({required int rows, required int cols}) {
    final uuid = Uuid();
    final projectId = uuid.v4();
    final layers = <Component>[];

    // Default canvas size
    const canvasWidth = 800.0;
    const canvasHeight = 600.0;

    // Calculate cell size with some padding
    const padding = 20.0;
    final availableWidth = canvasWidth - (padding * 2);
    final availableHeight = canvasHeight - (padding * 2);

    final cellWidth = availableWidth / cols;
    final cellHeight = availableHeight / rows;

    // Use a slightly smaller size for the actual pad to leave gaps
    final padWidth = cellWidth * 0.9;
    final padHeight = cellHeight * 0.9;
    final gapX = (cellWidth - padWidth) / 2;
    final gapY = (cellHeight - padHeight) / 2;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final x = padding + (c * cellWidth) + gapX;
        final y = padding + (r * cellHeight) + gapY;

        layers.add(
          Component.pad(
            id: uuid.v4(),
            name: 'Pad ${r * cols + c + 1}',
            x: x,
            y: y,
            width: padWidth,
            height: padHeight,
            midiChannel: 0,
            midiNote: 0, // Default note, user can change later
          ),
        );
      }
    }

    return Project(
      id: projectId,
      name: 'New Project',
      version: '1.0.0',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      layers: layers,
    );
  }

  Project createEmptyProject() {
    final uuid = Uuid();
    return Project(
      id: uuid.v4(),
      name: 'New Project',
      version: '1.0.0',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      layers: [],
    );
  }
}
