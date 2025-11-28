import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

class LayerPanel extends StatelessWidget {
  const LayerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[200],
      child: Column(
        children: [
          // Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.grey[300],
            child: Row(
              children: [
                const Text('Layers', style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.folder_open, size: 20),
                  tooltip: 'Group',
                  onPressed: () {
                    // TODO: Implement Grouping
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.lock_open, size: 20),
                  tooltip: 'Lock',
                  onPressed: () {
                    final selectedIds = context.read<EditorBloc>().state.selectedComponentIds;
                    if (selectedIds.isEmpty) return;

                    final project = context.read<EditorBloc>().state.project;
                    if (project == null) return;

                    final id = selectedIds.first;
                    final component = project.layers.firstWhere((c) => c.id == id);

                    final updated = component.map(
                      pad: (c) => c.copyWith(isLocked: !c.isLocked),
                      knob: (c) => c.copyWith(isLocked: !c.isLocked),
                      staticImage: (c) => c.copyWith(isLocked: !c.isLocked),
                    );

                    context.read<EditorBloc>().add(EditorEvent.updateComponent(id, updated));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.visibility, size: 20),
                  tooltip: 'Visibility',
                  onPressed: () {
                    final selectedIds = context.read<EditorBloc>().state.selectedComponentIds;
                    if (selectedIds.isEmpty) return;

                    final project = context.read<EditorBloc>().state.project;
                    if (project == null) return;

                    final id = selectedIds.first;
                    final component = project.layers.firstWhere((c) => c.id == id);

                    final updated = component.map(
                      pad: (c) => c.copyWith(isVisible: !c.isVisible),
                      knob: (c) => c.copyWith(isVisible: !c.isVisible),
                      staticImage: (c) => c.copyWith(isVisible: !c.isVisible),
                    );

                    context.read<EditorBloc>().add(EditorEvent.updateComponent(id, updated));
                  },
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: BlocBuilder<EditorBloc, EditorState>(
              builder: (context, state) {
                final project = state.project;
                if (project == null) return const SizedBox();

                final layers = project.layers;

                return ReorderableListView.builder(
                  itemCount: layers.length,
                  onReorder: (oldIndex, newIndex) {
                    // Adjust index logic for reversed list
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final int length = layers.length;
                    final int from = length - 1 - oldIndex;
                    final int to = length - 1 - newIndex;

                    context.read<EditorBloc>().add(EditorEvent.reorderComponent(from, to));
                  },
                  itemBuilder: (context, index) {
                    // Reverse index to show top layer at top of list
                    final reversedIndex = layers.length - 1 - index;
                    final component = layers[reversedIndex];
                    final isSelected = state.selectedComponentIds.contains(component.id);

                    return ListTile(
                      key: ValueKey(component.id),
                      selected: isSelected,
                      selectedTileColor: Colors.blue.withValues(alpha: 0.1),
                      leading: Icon(
                        component.map(
                          pad: (_) => Icons.crop_square,
                          knob: (_) => Icons.radio_button_checked,
                          staticImage: (_) => Icons.image,
                        ),
                        size: 16,
                        color: component.isVisible ? null : Colors.grey,
                      ),
                      title: Text(
                        component.name,
                        style: TextStyle(
                          color: component.isVisible ? null : Colors.grey,
                          decoration: component.isVisible ? null : TextDecoration.lineThrough,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!component.isVisible) const Icon(Icons.visibility_off, size: 14, color: Colors.grey),
                          if (component.isLocked) const Icon(Icons.lock, size: 14),
                          const SizedBox(width: 4),
                          const Icon(Icons.drag_handle, size: 16),
                        ],
                      ),
                      onTap: () {
                        context.read<EditorBloc>().add(EditorEvent.selectComponent(component.id, multiSelect: false));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
