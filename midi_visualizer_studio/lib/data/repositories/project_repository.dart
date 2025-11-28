import 'dart:convert';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';

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
}
