import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';

class TemporaryStorageService {
  Future<String> _getTempFilePath(String projectId) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/temp_project_$projectId.json';
  }

  Future<void> saveProject(Project project) async {
    try {
      final path = await _getTempFilePath(project.id);
      final file = File(path);
      final jsonString = jsonEncode(project.toJson());
      await file.writeAsString(jsonString);
    } catch (e) {
      // Ignore errors for temp save, or log them
      print('Error saving temp project: $e');
    }
  }

  Future<Project?> loadProject(String projectId) async {
    try {
      final path = await _getTempFilePath(projectId);
      final file = File(path);
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonMap = jsonDecode(jsonString);
        return Project.fromJson(jsonMap);
      }
    } catch (e) {
      print('Error loading temp project: $e');
    }
    return null;
  }

  Future<void> clearProject(String projectId) async {
    try {
      final path = await _getTempFilePath(projectId);
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error clearing temp project: $e');
    }
  }

  Future<bool> hasTemporaryProject(String projectId) async {
    try {
      final path = await _getTempFilePath(projectId);
      return await File(path).exists();
    } catch (e) {
      return false;
    }
  }
}
