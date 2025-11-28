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

        // Use InteractiveViewer for Zoom/Pan
        return Container(
          color: Colors.grey[900], // Dark background for canvas area
          child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(double.infinity),
            minScale: 0.1,
            maxScale: 5.0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  context.read<EditorBloc>().add(const EditorEvent.selectComponent('', multiSelect: false));
                },
                child: Container(
                  width: project.canvasWidth,
                  height: project.canvasHeight,
                  color: _parseColor(project.backgroundColor), // Actual canvas background
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Grid (only in Edit mode)
                      if (state.mode == EditorMode.edit) Positioned.fill(child: CustomPaint(painter: GridPainter())),

                      // Layers
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
          ),
        );
      },
    );
  }

  Color _parseColor(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return Colors.white;
    }
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const gridSize = 20.0;

    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ComponentWrapper extends StatefulWidget {
  final Component component;
  final bool isSelected;

  const _ComponentWrapper({required this.component, required this.isSelected});

  @override
  State<_ComponentWrapper> createState() => _ComponentWrapperState();
}

class _ComponentWrapperState extends State<_ComponentWrapper> {
  Offset _dragOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _dragOffset,
      child: GestureDetector(
        onTap: () {
          context.read<EditorBloc>().add(EditorEvent.selectComponent(widget.component.id, multiSelect: false));
        },
        onPanStart: (details) {
          if (!widget.isSelected) return;
          setState(() {
            _dragOffset = Offset.zero;
          });
        },
        onPanUpdate: (details) {
          if (!widget.isSelected) return;
          setState(() {
            _dragOffset += details.delta;
          });
        },
        onPanEnd: (details) {
          if (!widget.isSelected) return;

          final newX = widget.component.x + _dragOffset.dx;
          final newY = widget.component.y + _dragOffset.dy;

          final updatedComponent = widget.component.map(
            pad: (c) => c.copyWith(x: newX, y: newY),
            knob: (c) => c.copyWith(x: newX, y: newY),
          );

          context.read<EditorBloc>().add(EditorEvent.updateComponent(widget.component.id, updatedComponent));

          setState(() {
            _dragOffset = Offset.zero;
          });
        },
        child: Container(
          width: widget.component.width,
          height: widget.component.height,
          decoration: BoxDecoration(
            border: widget.isSelected ? Border.all(color: Colors.blue, width: 2) : null,
            color: _getColor(widget.component),
          ),
          child: Center(
            child: Text(
              widget.component.name,
              style: const TextStyle(color: Colors.white, fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
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
