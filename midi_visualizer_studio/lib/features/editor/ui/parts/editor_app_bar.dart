import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

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
              color: state.currentTool == EditorTool.select ? Theme.of(context).primaryColor : null,
              onPressed: () {
                context.read<EditorBloc>().add(const EditorEvent.selectTool(EditorTool.select));
              },
            ),
            IconButton(
              icon: const Icon(Icons.crop_square),
              tooltip: 'Rectangle',
              color: state.currentTool == EditorTool.rectangle ? Theme.of(context).primaryColor : null,
              onPressed: () {
                // For now, rectangle/circle just add immediately, but ideally they should be tools too.
                // Keeping original behavior for now but switching tool state for visual consistency if needed.
                // Actually, let's make them tools later. For now, just keep add behavior but maybe reset tool to select?
                // Or better: The plan said "Update tool buttons to use selectTool event".
                // But existing code adds component immediately.
                // Let's stick to the plan for Path tool specifically, and maybe Select.
                // For Rectangle/Circle, let's keep them as "Add" actions for now, or switch to tool if we want drag-to-create.
                // The prompt implies "Path Tool" is the focus.
                // Let's update Select and Path.
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
              color: state.currentTool == EditorTool.path ? Theme.of(context).primaryColor : null,
              onPressed: () {
                context.read<EditorBloc>().add(const EditorEvent.selectTool(EditorTool.path));
              },
            ),
            IconButton(
              icon: const Icon(Icons.image),
              tooltip: 'Image',
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(type: FileType.image);

                if (result != null && result.files.single.path != null) {
                  final path = result.files.single.path!;
                  final id = DateTime.now().millisecondsSinceEpoch.toString();

                  final decodedImage = await ui.instantiateImageCodec(File(path).readAsBytesSync());
                  final frameInfo = await decodedImage.getNextFrame();
                  final width = frameInfo.image.width.toDouble();
                  final height = frameInfo.image.height.toDouble();

                  // Scale down if too big (e.g. > 300px)
                  double finalWidth = width;
                  double finalHeight = height;
                  if (width > 300) {
                    final scale = 300 / width;
                    finalWidth = 300;
                    finalHeight = height * scale;
                  }

                  final component = Component.staticImage(
                    id: id,
                    name: 'Image $id',
                    x: 100,
                    y: 100,
                    width: finalWidth,
                    height: finalHeight,
                    imagePath: path,
                  );

                  if (context.mounted) {
                    context.read<EditorBloc>().add(EditorEvent.addComponent(component));
                  }
                }
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
