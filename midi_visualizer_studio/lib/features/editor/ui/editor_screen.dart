import 'package:flutter/material.dart';

class EditorScreen extends StatelessWidget {
  final String projectId;
  const EditorScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Editor Screen: $projectId')));
  }
}
