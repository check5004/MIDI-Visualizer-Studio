import 'dart:convert';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class ProjectRepository {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    final projectsDir = Directory(p.join(directory.path, 'projects'));
    if (!await projectsDir.exists()) {
      await projectsDir.create(recursive: true);
    }
    return projectsDir.path;
  }

  Future<void> saveProjectInternal(Project project) async {
    final projectsPath = await _localPath;
    final projectPath = p.join(projectsPath, '${project.id}.mvs');

    // Create a temporary directory to zip
    final tempDir = await getTemporaryDirectory();
    final tempProjectDir = Directory(p.join(tempDir.path, project.id));
    if (await tempProjectDir.exists()) {
      await tempProjectDir.delete(recursive: true);
    }
    await tempProjectDir.create();

    // Convert project to JSON
    // Convert project to JSON
    final jsonStr = jsonEncode(project.toJson());
    final jsonFile = File(p.join(tempProjectDir.path, 'project.json'));
    await jsonFile.writeAsString(jsonStr);

    // TODO: Copy image assets to tempProjectDir if any

    // Zip the directory
    final encoder = ZipFileEncoder();
    encoder.create(projectPath);
    await encoder.addDirectory(tempProjectDir, includeDirName: false);
    encoder.close();

    // Cleanup
    await tempProjectDir.delete(recursive: true);
  }

  Future<void> exportProject(Project project, String path) async {
    // Ensure path ends with .mvs or .zip (and not double extension if user provided one)
    // FilePicker usually handles the extension, but we should be safe.
    // The user requirement says "fix double extension".
    // If path ends with .mvs.mvs, fix it.

    String finalPath = path;
    if (finalPath.endsWith('.mvs.mvs')) {
      finalPath = finalPath.substring(0, finalPath.length - 4);
    } else if (finalPath.endsWith('.zip.zip')) {
      finalPath = finalPath.substring(0, finalPath.length - 4);
    }

    // Create a temporary directory to zip
    final tempDir = await getTemporaryDirectory();
    final tempProjectDir = Directory(p.join(tempDir.path, '${project.id}_export'));
    if (await tempProjectDir.exists()) {
      await tempProjectDir.delete(recursive: true);
    }
    await tempProjectDir.create();

    // Convert project to JSON
    // Convert project to JSON
    final jsonStr = jsonEncode(project.toJson());
    final jsonFile = File(p.join(tempProjectDir.path, 'project.json'));
    await jsonFile.writeAsString(jsonStr);

    // TODO: Copy image assets to tempProjectDir if any

    // Zip the directory
    final encoder = ZipFileEncoder();
    encoder.create(finalPath);
    await encoder.addDirectory(tempProjectDir, includeDirName: false);
    encoder.close();

    // Cleanup
    await tempProjectDir.delete(recursive: true);
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

  Future<List<Project>> getProjects() async {
    final projectsPath = await _localPath;
    final dir = Directory(projectsPath);
    final List<Project> projects = [];

    if (await dir.exists()) {
      await for (final entity in dir.list()) {
        if (entity is File && (entity.path.endsWith('.mvs') || entity.path.endsWith('.zip'))) {
          try {
            final project = await loadProject(entity.path);
            projects.add(project);
          } catch (e) {
            print('Error loading project ${entity.path}: $e');
            // Delete corrupted file
            try {
              await entity.delete();
              print('Deleted corrupted project file: ${entity.path}');
            } catch (deleteError) {
              print('Failed to delete corrupted file: $deleteError');
            }
          }
        }
      }
    }

    // Sort by updated at descending
    projects.sort((a, b) {
      final aTime = a.updatedAt ?? a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.updatedAt ?? b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bTime.compareTo(aTime);
    });
    return projects;
  }

  Future<void> deleteProject(String id) async {
    final projectsPath = await _localPath;
    final file = File(p.join(projectsPath, '$id.mvs'));
    if (await file.exists()) {
      await file.delete();
    }
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
