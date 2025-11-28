import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/ruler_widget.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/selection_overlay.dart';

class CanvasView extends StatefulWidget {
  const CanvasView({super.key});

  static const double kHandlePadding = 30.0;

  @override
  State<CanvasView> createState() => _CanvasViewState();
}

class _CanvasViewState extends State<CanvasView> {
  final TransformationController _transformationController = TransformationController();
  bool _isMiddleClicking = false;
  Offset? _lastMousePos;

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
        return Column(
          children: [
            // Top Ruler
            SizedBox(
              height: 20,
              child: Row(
                children: [
                  const SizedBox(width: 20, child: Placeholder(color: Colors.black)), // Corner
                  Expanded(
                    child: RulerWidget(axis: Axis.horizontal, controller: _transformationController, size: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Left Ruler
                  SizedBox(
                    width: 20,
                    child: RulerWidget(axis: Axis.vertical, controller: _transformationController, size: 20),
                  ),
                  // Canvas
                  Expanded(
                    child: Container(
                      color: Colors.grey[900], // Dark background for canvas area
                      child: Listener(
                        onPointerDown: (event) {
                          if (event.buttons == kMiddleMouseButton) {
                            _isMiddleClicking = true;
                            _lastMousePos = event.position;
                          }
                        },
                        onPointerMove: (event) {
                          if (_isMiddleClicking && _lastMousePos != null) {
                            final delta = event.position - _lastMousePos!;
                            _lastMousePos = event.position;

                            final matrix = _transformationController.value.clone();
                            // Pan is inverted relative to drag for "moving the viewport", but standard for "moving the canvas"
                            // InteractiveViewer moves content with drag.
                            // We want to move content with drag.
                            // Translation should be scaled by zoom level?
                            // InteractiveViewer's matrix translation is in viewport pixels?
                            // Let's try direct translation first.
                            final scale = matrix.getMaxScaleOnAxis();
                            matrix.translate(delta.dx / scale, delta.dy / scale);
                            _transformationController.value = matrix;
                          }
                        },
                        onPointerUp: (event) {
                          if (_isMiddleClicking) {
                            _isMiddleClicking = false;
                            _lastMousePos = null;
                          }
                        },
                        onPointerSignal: (event) {
                          if (event is PointerScrollEvent) {
                            final matrix = _transformationController.value.clone();
                            final scale = matrix.getMaxScaleOnAxis();

                            if (event.scrollDelta.dy != 0) {
                              if (HardwareKeyboard.instance.isControlPressed ||
                                  HardwareKeyboard.instance.isMetaPressed) {
                                // Zoom
                                final zoomFactor = event.scrollDelta.dy > 0 ? 0.9 : 1.1;
                                final newScale = (scale * zoomFactor).clamp(0.1, 5.0);
                                context.read<EditorBloc>().add(EditorEvent.setZoom(newScale));
                              } else if (HardwareKeyboard.instance.isShiftPressed) {
                                // Pan X
                                matrix.translate(-event.scrollDelta.dy / scale, 0.0);
                                _transformationController.value = matrix;
                              } else {
                                // Pan Y
                                matrix.translate(0.0, -event.scrollDelta.dy / scale);
                                _transformationController.value = matrix;
                              }
                            }
                          }
                        },
                        child: InteractiveViewer(
                          transformationController: _transformationController,
                          boundaryMargin: const EdgeInsets.all(double.infinity),
                          minScale: 0.1,
                          maxScale: 5.0,
                          panEnabled: false, // Disable default pan (Left Click Drag)
                          scaleEnabled: false, // Disable default scale (Pinch/Scroll Zoom) - we handle it manually
                          onInteractionEnd: (details) {
                            context.read<EditorBloc>().add(
                              EditorEvent.setZoom(_transformationController.value.getMaxScaleOnAxis()),
                            );
                          },
                          child: Center(
                            child: GestureDetector(
                              onTapUp: (details) {
                                if (state.currentTool == EditorTool.path) {
                                  context.read<EditorBloc>().add(EditorEvent.addPathPoint(details.localPosition));
                                } else {
                                  context.read<EditorBloc>().add(
                                    const EditorEvent.selectComponent('', multiSelect: false),
                                  );
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
                                    if (state.mode == EditorMode.edit && state.showGrid)
                                      Positioned.fill(
                                        child: CustomPaint(painter: GridPainter(gridSize: state.gridSize)),
                                      ),
                                    // Path Preview
                                    if (state.currentTool == EditorTool.path && state.currentPathPoints.isNotEmpty)
                                      Positioned.fill(
                                        child: CustomPaint(
                                          painter: PathPreviewPainter(points: state.currentPathPoints),
                                        ),
                                      ),

                                    // Layers
                                    ...project.layers.map((component) {
                                      if (!component.isVisible) return const SizedBox();

                                      final isSelected = state.selectedComponentIds.contains(component.id);
                                      final padding = isSelected ? CanvasView.kHandlePadding : 0.0;

                                      return Positioned(
                                        left: component.x - padding,
                                        top: component.y - padding,
                                        child: _ComponentWrapper(
                                          component: component,
                                          isSelected: isSelected,
                                          gridSize: state.gridSize,
                                          snapToGrid: state.snapToGrid,
                                          padding: padding,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
  final double gridSize;

  GridPainter({required this.gridSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) => oldDelegate.gridSize != gridSize;
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
        ..color = Colors.blue.withValues(alpha: 0.5)
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
  final double gridSize;
  final bool snapToGrid;
  final double padding;

  const _ComponentWrapper({
    required this.component,
    required this.isSelected,
    required this.gridSize,
    required this.snapToGrid,
    this.padding = 0,
  });

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
          if (!widget.isSelected || widget.component.isLocked) return;
          setState(() {
            _dragOffset = Offset.zero;
          });
        },
        onPanUpdate: (details) {
          if (!widget.isSelected || widget.component.isLocked) return;
          setState(() {
            _dragOffset += details.delta;
          });
        },
        onPanEnd: (details) {
          if (!widget.isSelected || widget.component.isLocked) return;

          double newX = widget.component.x + _dragOffset.dx;
          double newY = widget.component.y + _dragOffset.dy;

          if (widget.snapToGrid) {
            newX = (newX / widget.gridSize).round() * widget.gridSize;
            newY = (newY / widget.gridSize).round() * widget.gridSize;
          }

          final updatedComponent = widget.component.map(
            pad: (c) => c.copyWith(x: newX, y: newY),
            knob: (c) => c.copyWith(x: newX, y: newY),
            staticImage: (c) => c.copyWith(x: newX, y: newY),
          );

          context.read<EditorBloc>().add(EditorEvent.updateComponent(widget.component.id, updatedComponent));

          setState(() {
            _dragOffset = Offset.zero;
          });
        },
        child: Transform.rotate(
          angle: widget.component.rotation,
          child: widget.isSelected
              ? ComponentSelectionOverlay(
                  component: widget.component,
                  gridSize: widget.gridSize,
                  snapToGrid: widget.snapToGrid,
                  padding: widget.padding,
                  child: _buildComponentContent(),
                )
              : Padding(padding: EdgeInsets.all(widget.padding), child: _buildComponentContent()),
        ),
      ),
    );
  }

  Widget _buildComponentContent() {
    return CustomPaint(
      painter: ComponentPainter(component: widget.component, isSelected: false), // Overlay handles selection visuals
      child: SizedBox(
        width: widget.component.width,
        height: widget.component.height,
        child: widget.component.map(
          pad: (c) => Center(
            child: Text(
              c.name,
              style: const TextStyle(color: Colors.white, fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          knob: (c) => Center(
            child: Text(
              c.name,
              style: const TextStyle(color: Colors.white, fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          staticImage: (c) => Image.file(
            File(c.imagePath),
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.broken_image, color: Colors.red));
            },
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
    } else if (component is ComponentStaticImage) {
      // Image is rendered by the child widget, so we don't need to paint anything here
      // unless we want a background or something.
    } else {
      paint.color = Colors.orange;
      canvas.drawRect(Offset.zero & size, paint);
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
