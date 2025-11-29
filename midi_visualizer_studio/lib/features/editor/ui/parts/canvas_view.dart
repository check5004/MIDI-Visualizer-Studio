import 'dart:io';
import 'dart:math';
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
  Offset _selectionDragDelta = Offset.zero;

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
                              onSecondaryTapUp: (details) {
                                _showContextMenu(context, details.globalPosition);
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
                                      final isActive = state.activeComponentIds.contains(component.id);
                                      final padding = isSelected ? CanvasView.kHandlePadding : 0.0;

                                      return Positioned(
                                        left: component.x - padding,
                                        top: component.y - padding,
                                        child: _ComponentWrapper(
                                          component: component,
                                          isSelected: isSelected,
                                          isActive: isActive,
                                          gridSize: state.gridSize,
                                          snapToGrid: state.snapToGrid,
                                          padding: padding,
                                          dragDelta: isSelected ? _selectionDragDelta : Offset.zero,
                                          onDragStart: (details) {
                                            if (!isSelected) return;
                                            setState(() {
                                              _selectionDragDelta = Offset.zero;
                                            });
                                          },
                                          onDragUpdate: (details) {
                                            if (!isSelected) return;
                                            setState(() {
                                              _selectionDragDelta += details.delta;
                                            });
                                          },
                                          onSecondaryTapUp: (details) {
                                            if (!isSelected) {
                                              context.read<EditorBloc>().add(
                                                EditorEvent.selectComponent(component.id, multiSelect: false),
                                              );
                                            }
                                            _showContextMenu(context, details.globalPosition);
                                          },
                                          onDragEnd: (details) {
                                            if (!isSelected) return;

                                            final selectedIds = state.selectedComponentIds;
                                            final project = state.project;
                                            if (project == null) return;

                                            final updates = <Component>[];

                                            for (final id in selectedIds) {
                                              final comp = project.layers.firstWhere(
                                                (c) => c.id == id,
                                                orElse: () => throw Exception('Component not found'),
                                              );

                                              double newX = comp.x + _selectionDragDelta.dx;
                                              double newY = comp.y + _selectionDragDelta.dy;

                                              if (state.snapToGrid) {
                                                newX = (newX / state.gridSize).round() * state.gridSize;
                                                newY = (newY / state.gridSize).round() * state.gridSize;
                                              }

                                              final updated = comp.map(
                                                pad: (c) => c.copyWith(x: newX, y: newY),
                                                knob: (c) => c.copyWith(x: newX, y: newY),
                                                staticImage: (c) => c.copyWith(x: newX, y: newY),
                                              );
                                              updates.add(updated);
                                            }

                                            context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));

                                            setState(() {
                                              _selectionDragDelta = Offset.zero;
                                            });
                                          },
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

  void _showContextMenu(BuildContext context, Offset position) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(position & const Size(1, 1), Offset.zero & overlay.size),
      items: [
        const PopupMenuItem(
          value: 'cut',
          child: Row(children: [Icon(Icons.content_cut, size: 18), SizedBox(width: 8), Text('Cut')]),
        ),
        const PopupMenuItem(
          value: 'copy',
          child: Row(children: [Icon(Icons.content_copy, size: 18), SizedBox(width: 8), Text('Copy')]),
        ),
        const PopupMenuItem(
          value: 'paste',
          child: Row(children: [Icon(Icons.content_paste, size: 18), SizedBox(width: 8), Text('Paste')]),
        ),
        const PopupMenuItem(
          value: 'duplicate',
          child: Row(children: [Icon(Icons.copy_all, size: 18), SizedBox(width: 8), Text('Duplicate')]),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(children: [Icon(Icons.delete, size: 18), SizedBox(width: 8), Text('Delete')]),
        ),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case 'cut':
            context.read<EditorBloc>().add(const EditorEvent.cut());
            break;
          case 'copy':
            context.read<EditorBloc>().add(const EditorEvent.copy());
            break;
          case 'paste':
            context.read<EditorBloc>().add(const EditorEvent.paste());
            break;
          case 'duplicate':
            context.read<EditorBloc>().add(const EditorEvent.duplicate());
            break;
          case 'delete':
            context.read<EditorBloc>().add(const EditorEvent.delete());
            break;
        }
      }
    });
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
  final bool isActive;
  final double gridSize;
  final bool snapToGrid;
  final double padding;
  final Offset dragDelta;
  final ValueChanged<DragStartDetails>? onDragStart;
  final ValueChanged<DragUpdateDetails>? onDragUpdate;
  final ValueChanged<DragEndDetails>? onDragEnd;
  final ValueChanged<TapUpDetails>? onSecondaryTapUp;

  const _ComponentWrapper({
    required this.component,
    required this.isSelected,
    required this.isActive,
    required this.gridSize,
    required this.snapToGrid,
    this.padding = 0,
    this.dragDelta = Offset.zero,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
    this.onSecondaryTapUp,
  });

  @override
  State<_ComponentWrapper> createState() => _ComponentWrapperState();
}

class _ComponentWrapperState extends State<_ComponentWrapper> {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: widget.dragDelta,
      child: GestureDetector(
        onSecondaryTapUp: widget.onSecondaryTapUp,
        onTapUp: (details) {
          final state = context.read<EditorBloc>().state;
          if (state.currentTool == EditorTool.bucketFill) {
            context.read<EditorBloc>().add(
              EditorEvent.fillImageArea(
                widget.component.id,
                details.localPosition,
                Colors.green, // Default fill color
              ),
            );
          } else {
            final isMultiSelect =
                HardwareKeyboard.instance.isShiftPressed ||
                HardwareKeyboard.instance.isMetaPressed ||
                HardwareKeyboard.instance.isControlPressed;
            context.read<EditorBloc>().add(
              EditorEvent.selectComponent(widget.component.id, multiSelect: isMultiSelect),
            );
          }
        },
        onPanStart: (details) {
          if (!widget.isSelected || widget.component.isLocked) return;
          widget.onDragStart?.call(details);
        },
        onPanUpdate: (details) {
          if (!widget.isSelected || widget.component.isLocked) return;
          widget.onDragUpdate?.call(details);
        },
        onPanEnd: (details) {
          if (!widget.isSelected || widget.component.isLocked) return;
          widget.onDragEnd?.call(details);
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
      painter: ComponentPainter(
        component: widget.component,
        isSelected: false,
        isActive: widget.isActive,
      ), // Overlay handles selection visuals
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
  final bool isActive;

  ComponentPainter({required this.component, required this.isSelected, required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    if (component is ComponentPad) {
      final pad = component as ComponentPad;
      paint.color = _parseColor(isActive ? pad.onColor : pad.offColor);

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
      // unless we want a background or something.
    } else if (component is ComponentKnob) {
      _drawKnob(canvas, size, component as ComponentKnob, paint);
    } else {
      paint.color = Colors.orange;
      canvas.drawRect(Offset.zero & size, paint);
    }
  }

  void _drawKnob(Canvas canvas, Size size, ComponentKnob knob, Paint paint) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    // Tint Effect
    Color knobColor = Colors.grey[800]!;
    if (knob.isRelative && knob.relativeEffect == KnobRelativeEffect.tint && isActive) {
      knobColor = Colors.redAccent;
    }

    paint.color = knobColor;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);

    // Draw Vector Arc (Background)
    if (knob.style == KnobStyle.vectorArc) {
      final arcPaint = Paint()
        ..color = Colors.grey[600]!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      // Draw full circle background for arc
      canvas.drawCircle(center, radius - 4, arcPaint);
    }

    // Draw Pointer / Marker
    final pointerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Rotation
    // For absolute knobs, rotation should map value to angle.
    // For relative knobs (spin), rotation is updated by state.
    // Currently ComponentKnob has 'rotation' property which is usually for the component itself (orientation).
    // But for Spin effect, we are using it as the current angle.
    // For normal knobs, we might need a 'value' property which maps to angle.
    // But `ComponentKnob` doesn't have a 'value' property in the model yet (it's stateless mostly).
    // However, for visualization, we might want to show the last received value?
    // The spec says "Visual feedback".
    // For now, let's use `rotation` as the indicator angle.

    final angle = knob.rotation; // This is in radians

    final pointerEnd = Offset(center.dx + (radius * 0.7) * cos(angle), center.dy + (radius * 0.7) * sin(angle));

    canvas.drawLine(center, pointerEnd, pointerPaint);

    // Draw a dot at the end
    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(pointerEnd, 4, dotPaint);
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
    return oldDelegate.component != component ||
        oldDelegate.isSelected != isSelected ||
        oldDelegate.isActive != isActive;
  }
}
