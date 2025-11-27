import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/canvas_view.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/inspector_panel.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/layer_panel.dart';
import 'package:window_manager/window_manager.dart';

class EditorScreen extends StatelessWidget {
  final String projectId;

  const EditorScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditorBloc()..add(EditorEvent.loadProject(projectId)),
      child: BlocConsumer<EditorBloc, EditorState>(
        listenWhen: (previous, current) => previous.mode != current.mode,
        listener: (context, state) async {
          if (state.mode == EditorMode.overlay) {
            await windowManager.setHasShadow(false);
            await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
            await windowManager.setBackgroundColor(Colors.transparent);
            await windowManager.setAlwaysOnTop(true);
          } else {
            await windowManager.setHasShadow(true);
            await windowManager.setTitleBarStyle(TitleBarStyle.normal);
            await windowManager.setBackgroundColor(Colors.white);
            await windowManager.setAlwaysOnTop(false);
          }
        },
        builder: (context, state) {
          if (state.status == EditorStatus.loading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state.mode == EditorMode.overlay) {
            return const Scaffold(backgroundColor: Colors.transparent, body: CanvasView());
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(state.project?.name ?? 'Editor'),
              leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/home')),
              actions: [
                IconButton(
                  icon: const Icon(Icons.layers),
                  tooltip: 'Toggle Overlay Mode',
                  onPressed: () {
                    context.read<EditorBloc>().add(const EditorEvent.toggleMode(EditorMode.overlay));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.color_lens),
                  tooltip: 'Chroma Key Settings',
                  onPressed: () => _showChromaKeyDialog(context, state.project!),
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
          );
        },
      ),
    );
  }

  void _showChromaKeyDialog(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Background Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Transparent'),
              leading: const Icon(Icons.grid_on),
              onTap: () {
                context.read<EditorBloc>().add(
                  EditorEvent.updateProjectSettings(
                    project.copyWith(backgroundColor: '#00000000'), // Transparent
                  ),
                );
                Navigator.pop(dialogContext);
              },
            ),
            ListTile(
              title: const Text('Green Screen'),
              leading: const Icon(Icons.circle, color: Colors.green),
              onTap: () {
                context.read<EditorBloc>().add(
                  EditorEvent.updateProjectSettings(project.copyWith(backgroundColor: '#00FF00')),
                );
                Navigator.pop(dialogContext);
              },
            ),
            ListTile(
              title: const Text('Blue Screen'),
              leading: const Icon(Icons.circle, color: Colors.blue),
              onTap: () {
                context.read<EditorBloc>().add(
                  EditorEvent.updateProjectSettings(project.copyWith(backgroundColor: '#0000FF')),
                );
                Navigator.pop(dialogContext);
              },
            ),
          ],
        ),
      ),
    );
  }
}
