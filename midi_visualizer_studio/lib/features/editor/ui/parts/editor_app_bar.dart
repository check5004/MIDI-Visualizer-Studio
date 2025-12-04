import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:midi_visualizer_studio/features/editor/ui/dialogs/create_pad_dialog.dart';
import 'package:midi_visualizer_studio/features/midi/ui/dialogs/midi_settings_dialog.dart';

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
          title: _EditableProjectTitle(
            initialName: project?.name ?? 'Untitled Project',
            onChanged: (newName) {
              if (project != null) {
                context.read<EditorBloc>().add(EditorEvent.updateProjectSettings(project.copyWith(name: newName)));
              }
            },
          ),
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
                    context.read<EditorBloc>().add(EditorEvent.loadProject(path: result.files.single.path!));
                  }
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.save),
              tooltip: 'Save Project',
              onPressed: () {
                context.read<EditorBloc>().add(const EditorEvent.saveProject());
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Project saved')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.file_upload),
              tooltip: 'Export Project',
              onPressed: () async {
                final path = await FilePicker.platform.saveFile(
                  dialogTitle: 'Export Project',
                  fileName: '${project?.name ?? "project"}.mvs',
                  type: FileType.custom,
                  allowedExtensions: ['mvs', 'zip'],
                );

                if (path != null) {
                  if (context.mounted) {
                    context.read<EditorBloc>().add(EditorEvent.exportProject(path));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Project exported')));
                  }
                }
              },
            ),
            const VerticalDivider(indent: 10, endIndent: 10),

            // MIDI Settings
            IconButton(
              icon: const Icon(Icons.piano),
              tooltip: 'MIDI Settings',
              onPressed: () {
                showDialog(context: context, builder: (context) => const MidiSettingsDialog());
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
                context.read<EditorBloc>().add(const EditorEvent.selectTool(EditorTool.rectangle));
              },
            ),
            IconButton(
              icon: const Icon(Icons.circle_outlined),
              tooltip: 'Circle',
              color: state.currentTool == EditorTool.circle ? Theme.of(context).colorScheme.primary : null,
              onPressed: () {
                context.read<EditorBloc>().add(const EditorEvent.selectTool(EditorTool.circle));
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

            const VerticalDivider(indent: 10, endIndent: 10),

            // Insert Template
            PopupMenuButton<String>(
              icon: const Icon(Icons.add_box_outlined),
              tooltip: 'Insert Template',
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'pad_grid',
                  child: Row(children: [Icon(Icons.grid_view, size: 20), SizedBox(width: 8), Text('PAD Grid')]),
                ),
              ],
              onSelected: (value) async {
                if (value == 'pad_grid') {
                  final result = await showDialog<Map<String, int>>(
                    context: context,
                    builder: (context) => const CreatePadDialog(),
                  );

                  if (result != null && context.mounted) {
                    context.read<EditorBloc>().add(EditorEvent.createPadGrid(result['rows']!, result['cols']!));
                  }
                }
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
            // Capture the bloc from the current context
            Builder(
              builder: (context) {
                final editorBloc = context.read<EditorBloc>();
                return PopupMenuButton<String>(
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
                    PopupMenuItem(
                      enabled: false,
                      child: BlocBuilder<EditorBloc, EditorState>(
                        bloc: editorBloc,
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Grid Size', style: Theme.of(context).textTheme.bodyMedium),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    iconSize: 20,
                                    splashRadius: 20,
                                    onPressed: () {
                                      if (state.gridSize > 5) {
                                        editorBloc.add(EditorEvent.setGridSize(state.gridSize - 5));
                                      }
                                    },
                                  ),
                                  Text('${state.gridSize.toInt()}', style: Theme.of(context).textTheme.bodyMedium),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    iconSize: 20,
                                    splashRadius: 20,
                                    onPressed: () {
                                      if (state.gridSize < 100) {
                                        editorBloc.add(EditorEvent.setGridSize(state.gridSize + 5));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'show_grid') {
                      editorBloc.add(const EditorEvent.toggleGrid());
                    } else if (value == 'snap_to_grid') {
                      editorBloc.add(const EditorEvent.toggleSnapToGrid());
                    }
                  },
                );
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

            // Preview Button
            FilledButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text('Preview'),
              onPressed: () async {
                if (project != null) {
                  final updatedProject = await context.push<Project>('/preview', extra: project);
                  if (updatedProject != null && context.mounted) {
                    context.read<EditorBloc>().add(EditorEvent.updateProjectSettings(updatedProject));
                  }
                }
              },
            ),
            const SizedBox(width: 16),
          ],
        );
      },
    );
  }
}

class _EditableProjectTitle extends StatefulWidget {
  final String initialName;
  final ValueChanged<String> onChanged;

  const _EditableProjectTitle({required this.initialName, required this.onChanged});

  @override
  State<_EditableProjectTitle> createState() => _EditableProjectTitleState();
}

class _EditableProjectTitleState extends State<_EditableProjectTitle> {
  late TextEditingController _controller;
  bool _isEditing = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        _submit();
      }
    });
  }

  @override
  void didUpdateWidget(covariant _EditableProjectTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialName != oldWidget.initialName && !_isEditing) {
      _controller.text = widget.initialName;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _isEditing = false;
    });
    if (_controller.text.trim().isNotEmpty) {
      widget.onChanged(_controller.text.trim());
    } else {
      _controller.text = widget.initialName;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return SizedBox(
        width: 200,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          autofocus: true,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) => _submit(),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.initialName),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.edit, size: 16),
          tooltip: 'Rename Project',
          onPressed: () {
            setState(() {
              _isEditing = true;
            });
          },
        ),
      ],
    );
  }
}
