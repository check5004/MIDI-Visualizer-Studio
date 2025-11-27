import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

class CanvasView extends StatelessWidget {
  const CanvasView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        final project = state.project;
        if (project == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return GestureDetector(
          onTap: () {
            context.read<EditorBloc>().add(const EditorEvent.selectComponent('', multiSelect: false));
          },
          child: Container(
            color: Colors.grey[900], // Dark background for canvas area
            child: Center(
              child: Container(
                width: project.canvasWidth,
                height: project.canvasHeight,
                color: Colors.black, // Actual canvas background
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ...project.layers.map((component) {
                      return Positioned(
                        left: component.x,
                        top: component.y,
                        child: _ComponentWrapper(
                          component: component,
                          isSelected: state.selectedComponentIds.contains(component.id),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ComponentWrapper extends StatelessWidget {
  final Component component;
  final bool isSelected;

  const _ComponentWrapper({required this.component, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<EditorBloc>().add(EditorEvent.selectComponent(component.id, multiSelect: false));
      },
      onPanUpdate: (details) {
        if (!isSelected) return;
        // Simple drag implementation
        // In a real app, we should probably handle this in the Bloc or a specialized controller
        // to avoid too many events, but for now let's send updates.
        // Note: This might be spammy for the Bloc.

        // Calculate new position
        final newX = component.x + details.delta.dx;
        final newY = component.y + details.delta.dy;

        // Update component
        // We need to handle different component types
        final updatedComponent = component.map(
          pad: (c) => c.copyWith(x: newX, y: newY),
          knob: (c) => c.copyWith(x: newX, y: newY),
        );

        context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updatedComponent));
      },
      child: Container(
        width: component.width,
        height: component.height,
        decoration: BoxDecoration(
          border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
          color: _getColor(component),
        ),
        child: Center(
          child: Text(
            component.name,
            style: const TextStyle(color: Colors.white, fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Color _getColor(Component component) {
    // Helper to parse hex color or return default
    return component.map(
      pad: (c) => Colors.green, // Placeholder
      knob: (c) => Colors.orange, // Placeholder
    );
  }
}
