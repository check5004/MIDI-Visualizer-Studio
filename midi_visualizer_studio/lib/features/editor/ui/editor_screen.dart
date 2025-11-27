import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/canvas_view.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/inspector_panel.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/layer_panel.dart';

class EditorScreen extends StatelessWidget {
  final String projectId;
  const EditorScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditorBloc()..add(EditorEvent.loadProject(projectId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editor: $projectId'),
          actions: [
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {
                // Toggle play mode
              },
            ),
          ],
        ),
        body: const Row(
          children: [
            LayerPanel(),
            Expanded(child: CanvasView()),
            InspectorPanel(),
          ],
        ),
      ),
    );
  }
}
