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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Layers', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1),
          Expanded(
            child: BlocBuilder<EditorBloc, EditorState>(
              builder: (context, state) {
                final project = state.project;
                if (project == null) return const SizedBox();

                // Reverse layers to show top-most at top of list
                // Note: ReorderableListView needs a unique key for each item
                final layers = project.layers.reversed.toList();

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
                    final component = layers[index];
                    final isSelected = state.selectedComponentIds.contains(component.id);

                    return ListTile(
                      key: ValueKey(component.id),
                      selected: isSelected,
                      selectedTileColor: Colors.blue.withValues(alpha: 0.1),
                      leading: Icon(_getIcon(component), size: 16),
                      title: Text(component.name),
                      trailing: const Icon(Icons.drag_handle),
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

  IconData _getIcon(Component component) {
    return component.map(pad: (_) => Icons.crop_square, knob: (_) => Icons.radio_button_checked);
  }
}
