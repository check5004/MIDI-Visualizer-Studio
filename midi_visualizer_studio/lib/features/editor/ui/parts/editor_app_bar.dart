import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';

class EditorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditorAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        final project = state.project;
        return AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          title: Text(project?.name ?? 'Untitled Project'),
          centerTitle: false,
          actions: [
            // Toolbar (Center-ish)
            // Ideally this should be in the center of the AppBar, but AppBar layout is rigid.
            // We can put it in a Row in title or flexibleSpace, or just actions.
            // Let's put it in actions for now, or use a custom Title.

            // Tools
            IconButton(
              icon: const Icon(Icons.touch_app),
              tooltip: 'Select',
              onPressed: () {
                // Set tool mode (not implemented in Bloc yet, but we can just deselect)
                context.read<EditorBloc>().add(const EditorEvent.selectComponent('', multiSelect: false));
              },
            ),
            IconButton(
              icon: const Icon(Icons.crop_square),
              tooltip: 'Rectangle',
              onPressed: () {
                _addComponent(context, PadShape.rect);
              },
            ),
            IconButton(
              icon: const Icon(Icons.circle_outlined),
              tooltip: 'Circle',
              onPressed: () {
                _addComponent(context, PadShape.circle);
              },
            ),
            IconButton(
              icon: const Icon(Icons.gesture),
              tooltip: 'Path',
              onPressed: () {
                // TODO: Implement Path tool
              },
            ),
            IconButton(
              icon: const Icon(Icons.image),
              tooltip: 'Image',
              onPressed: () {
                // TODO: Implement Image import
              },
            ),

            const VerticalDivider(indent: 10, endIndent: 10),

            // MIDI Status (Placeholder)
            const Icon(Icons.music_note, color: Colors.grey),

            const VerticalDivider(indent: 10, endIndent: 10),

            // Undo/Redo
            IconButton(
              icon: const Icon(Icons.undo),
              onPressed: () {
                context.read<EditorBloc>().add(const EditorEvent.undo());
              },
            ),
            IconButton(
              icon: const Icon(Icons.redo),
              onPressed: () {
                context.read<EditorBloc>().add(const EditorEvent.redo());
              },
            ),

            const VerticalDivider(indent: 10, endIndent: 10),

            // Zoom
            IconButton(
              icon: const Icon(Icons.zoom_out),
              onPressed: () {
                context.read<EditorBloc>().add(const EditorEvent.zoomOut());
              },
            ),
            Center(child: Text('${(state.zoomLevel * 100).toInt()}%')),
            IconButton(
              icon: const Icon(Icons.zoom_in),
              onPressed: () {
                context.read<EditorBloc>().add(const EditorEvent.zoomIn());
              },
            ),

            const VerticalDivider(indent: 10, endIndent: 10),

            // Mode Switch
            Row(
              children: [
                const Text('Edit'),
                Switch(
                  value: state.mode == EditorMode.play,
                  onChanged: (value) {
                    context.read<EditorBloc>().add(EditorEvent.toggleMode(value ? EditorMode.play : EditorMode.edit));
                  },
                ),
                const Text('Play'),
              ],
            ),
            const SizedBox(width: 16),
          ],
        );
      },
    );
  }

  void _addComponent(BuildContext context, PadShape shape) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final component = Component.pad(id: id, name: 'Pad $id', x: 100, y: 100, width: 100, height: 100, shape: shape);
    context.read<EditorBloc>().add(EditorEvent.addComponent(component));
  }
}
