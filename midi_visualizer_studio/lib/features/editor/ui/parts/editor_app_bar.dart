import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:go_router/go_router.dart';

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
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
          ),
          title: Text(project?.name ?? 'Untitled Project'),
          centerTitle: false,
          actions: [
            // File Operations
            IconButton(
              icon: const Icon(Icons.folder_open),
              tooltip: 'Open Project',
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['mvs', 'zip'],
                );

                if (result != null && result.files.single.path != null) {
                  if (context.mounted) {
                    context.read<EditorBloc>().add(EditorEvent.loadProject(result.files.single.path!));
                  }
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.save),
              tooltip: 'Save Project',
              onPressed: () async {
                final path = await FilePicker.platform.saveFile(
                  dialogTitle: 'Save Project',
                  fileName: '${project?.name ?? "project"}.mvs',
                  type: FileType.custom,
                  allowedExtensions: ['mvs', 'zip'],
                );

                if (path != null) {
                  if (context.mounted) {
                    context.read<EditorBloc>().add(EditorEvent.saveProject(path));
                  }
                }
              },
            ),
            const VerticalDivider(indent: 10, endIndent: 10),

            // Tools
            IconButton(
              icon: const Icon(Icons.touch_app),
              tooltip: 'Select',
              color: state.currentTool == EditorTool.select ? Theme.of(context).colorScheme.primary : null,
              onPressed: () {
                context.read<EditorBloc>().add(const EditorEvent.selectTool(EditorTool.select));
              },
            ),
            IconButton(
              icon: const Icon(Icons.crop_square),
              tooltip: 'Rectangle',
              color: state.currentTool == EditorTool.rectangle ? Theme.of(context).colorScheme.primary : null,
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
              color: state.currentTool == EditorTool.path ? Theme.of(context).colorScheme.primary : null,
              onPressed: () {
                context.read<EditorBloc>().add(const EditorEvent.selectTool(EditorTool.path));
              },
            ),
            IconButton(
              icon: const Icon(Icons.format_color_fill),
              tooltip: 'Bucket Fill',
              color: state.currentTool == EditorTool.bucketFill ? Theme.of(context).colorScheme.primary : null,
              onPressed: () {
                context.read<EditorBloc>().add(const EditorEvent.selectTool(EditorTool.bucketFill));
              },
            ),

            // Tolerance Slider
            if (state.currentTool == EditorTool.bucketFill) ...[
              const VerticalDivider(),
              const Center(child: Text('Tolerance:')),
              SizedBox(
                width: 150,
                child: Slider(
                  value: state.floodFillTolerance.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: state.floodFillTolerance.toString(),
                  onChanged: (value) {
                    context.read<EditorBloc>().add(EditorEvent.setFloodFillTolerance(value.toInt()));
                  },
                ),
              ),
              Center(child: Text('${state.floodFillTolerance}')),
            ],

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

            // Grid Settings
            PopupMenuButton<String>(
              icon: const Icon(Icons.grid_on),
              tooltip: 'Grid Settings',
              itemBuilder: (context) => [
                CheckedPopupMenuItem(checked: state.showGrid, value: 'show_grid', child: const Text('Show Grid')),
                CheckedPopupMenuItem(
                  checked: state.snapToGrid,
                  value: 'snap_to_grid',
                  child: const Text('Snap to Grid'),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(value: 'grid_size', child: Text('Grid Size: ${state.gridSize.toInt()}')),
              ],
              onSelected: (value) {
                if (value == 'show_grid') {
                  context.read<EditorBloc>().add(const EditorEvent.toggleGrid());
                } else if (value == 'snap_to_grid') {
                  context.read<EditorBloc>().add(const EditorEvent.toggleSnapToGrid());
                } else if (value == 'grid_size') {
                  // Cycle grid size
                  final sizes = [10.0, 20.0, 50.0, 100.0];
                  final currentIndex = sizes.indexOf(state.gridSize);
                  final nextIndex = (currentIndex + 1) % sizes.length;
                  context.read<EditorBloc>().add(EditorEvent.setGridSize(sizes[nextIndex]));
                }
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
