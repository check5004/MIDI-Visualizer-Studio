import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

class CanvasView extends StatefulWidget {
  const CanvasView({super.key});

  @override
  State<CanvasView> createState() => _CanvasViewState();
}

class _CanvasViewState extends State<CanvasView> {
  final TransformationController _transformationController = TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditorBloc, EditorState>(
      listenWhen: (previous, current) => previous.zoomLevel != current.zoomLevel,
      listener: (context, state) {
        if (_transformationController.value.getMaxScaleOnAxis() != state.zoomLevel) {
          final matrix = Matrix4.identity()..scale(state.zoomLevel);
          _transformationController.value = matrix;
        }
      },
      builder: (context, state) {
        final project = state.project;
        if (project == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Use InteractiveViewer for Zoom/Pan
        return Container(
          color: Colors.grey[900], // Dark background for canvas area
          child: InteractiveViewer(
            transformationController: _transformationController,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            minScale: 0.1,
            maxScale: 5.0,
            onInteractionEnd: (details) {
              context.read<EditorBloc>().add(EditorEvent.setZoom(_transformationController.value.getMaxScaleOnAxis()));
            },
            child: Center(
              child: GestureDetector(
                onTapUp: (details) {
                  if (state.currentTool == EditorTool.path) {
                    // Add point relative to canvas
                    // We need to convert global position to local position relative to the canvas container
                    // But GestureDetector is inside Center inside InteractiveViewer.
                    // details.localPosition should be relative to the child of GestureDetector, which is the Container.
                    context.read<EditorBloc>().add(EditorEvent.addPathPoint(details.localPosition));
                  } else {
                    context.read<EditorBloc>().add(const EditorEvent.selectComponent('', multiSelect: false));
                  }
                },
                onDoubleTap: () {
                  if (state.currentTool == EditorTool.path) {
                    context.read<EditorBloc>().add(const EditorEvent.finishPath());
                  }
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

                      // Path Preview
                      if (state.currentTool == EditorTool.path && state.currentPathPoints.isNotEmpty)
                        Positioned.fill(
                          child: CustomPaint(painter: PathPreviewPainter(points: state.currentPathPoints)),
                        ),
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

class PathPreviewPainter extends CustomPainter {
  final List<Offset> points;

  PathPreviewPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final pointPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 4, pointPaint);
      if (i > 0) {
        canvas.drawLine(points[i - 1], points[i], paint);
      }
    }

    // Close the loop preview if more than 2 points
    if (points.length > 2) {
      final closePaint = Paint()
        ..color = Colors.blue.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      canvas.drawLine(points.last, points.first, closePaint);
    }
  }

  @override
  bool shouldRepaint(covariant PathPreviewPainter oldDelegate) {
    return oldDelegate.points != points;
  }
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
        child: CustomPaint(
          painter: ComponentPainter(component: widget.component, isSelected: widget.isSelected),
          child: SizedBox(
            width: widget.component.width,
            height: widget.component.height,
            child: Center(
              child: Text(
                widget.component.name,
                style: const TextStyle(color: Colors.white, fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ComponentPainter extends CustomPainter {
  final Component component;
  final bool isSelected;

  ComponentPainter({required this.component, required this.isSelected});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    if (component is ComponentPad) {
      final pad = component as ComponentPad;
      paint.color = _parseColor(pad.onColor); // Using onColor for now

      if (pad.shape == PadShape.rect) {
        canvas.drawRect(Offset.zero & size, paint);
      } else if (pad.shape == PadShape.circle) {
        canvas.drawOval(Offset.zero & size, paint);
      } else if (pad.shape == PadShape.path && pad.pathData != null) {
        final path = _parseSvgPath(pad.pathData!);
        // Scale path to fit size if needed, but pathData is absolute/relative to 0,0 of component
        // Since we created path relative to minX, minY, it should fit in width/height (size)
        canvas.drawPath(path, paint);
      }
    } else {
      paint.color = Colors.orange;
      canvas.drawRect(Offset.zero & size, paint);
    }

    if (isSelected) {
      final borderPaint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRect(Offset.zero & size, borderPaint);
    }
  }

  Path _parseSvgPath(String pathData) {
    // Simple parser for M and L commands
    final path = Path();
    final parts = pathData.split(' ');

    if (parts.isEmpty) return path;

    for (int i = 0; i < parts.length; i++) {
      final cmd = parts[i];
      if (cmd == 'M') {
        final x = double.parse(parts[++i]);
        final y = double.parse(parts[++i]);
        path.moveTo(x, y);
      } else if (cmd == 'L') {
        final x = double.parse(parts[++i]);
        final y = double.parse(parts[++i]);
        path.lineTo(x, y);
      } else if (cmd == 'Z') {
        path.close();
      }
    }
    return path;
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

  @override
  bool shouldRepaint(covariant ComponentPainter oldDelegate) {
    return oldDelegate.component != component || oldDelegate.isSelected != isSelected;
  }
}
