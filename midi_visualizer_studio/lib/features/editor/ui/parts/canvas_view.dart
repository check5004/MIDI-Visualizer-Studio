import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/features/editor/ui/painters/component_painter.dart';
import 'package:midi_visualizer_studio/features/editor/ui/painters/grid_painter.dart';
import 'package:midi_visualizer_studio/features/editor/ui/painters/path_preview_painter.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/ruler_widget.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/selection_overlay.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';

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

  static const double kCanvasSize = 10000.0;
  static const double kCanvasOrigin = kCanvasSize / 2;

  bool _isSelecting = false;
  Offset? _selectionStart;
  Offset? _selectionEnd;

  @override
  void initState() {
    super.initState();
    // Center the view initially
    final matrix = Matrix4.identity()
      ..translate(-kCanvasOrigin + 400, -kCanvasOrigin + 300) // Approximate center of viewport
      ..scale(1.0);
    _transformationController.value = matrix;
  }

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
          // Maintain center when zooming programmatically?
          // For now just scale, but we might need to be smarter about pivot.
          final currentMatrix = _transformationController.value;
          final currentScale = currentMatrix.getMaxScaleOnAxis();
          final scaleChange = state.zoomLevel / currentScale;

          final matrix = currentMatrix.clone()..scale(scaleChange);
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
                    child: RulerWidget(
                      axis: Axis.horizontal,
                      controller: _transformationController,
                      size: 20,
                      originOffset: kCanvasOrigin,
                    ),
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
                    child: RulerWidget(
                      axis: Axis.vertical,
                      controller: _transformationController,
                      size: 20,
                      originOffset: kCanvasOrigin,
                    ),
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
                          constrained: false,
                          panEnabled: false, // Disable default pan (Left Click Drag)
                          scaleEnabled: false, // Disable default scale (Pinch/Scroll Zoom) - we handle it manually
                          onInteractionEnd: (details) {
                            context.read<EditorBloc>().add(
                              EditorEvent.setZoom(_transformationController.value.getMaxScaleOnAxis()),
                            );
                          },
                          child: GestureDetector(
                            onTapUp: (details) {
                              // Convert local position to data coordinates
                              final dataPos = details.localPosition - const Offset(kCanvasOrigin, kCanvasOrigin);

                              if (state.currentTool == EditorTool.path) {
                                context.read<EditorBloc>().add(EditorEvent.addPathPoint(dataPos));
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
                            onPanStart: (details) {
                              if (state.currentTool == EditorTool.select) {
                                setState(() {
                                  _isSelecting = true;
                                  _selectionStart = details.localPosition;
                                  _selectionEnd = details.localPosition;
                                });
                              }
                            },
                            onPanUpdate: (details) {
                              if (_isSelecting) {
                                setState(() {
                                  _selectionEnd = details.localPosition;
                                });
                              }
                            },
                            onPanEnd: (details) {
                              if (_isSelecting && _selectionStart != null && _selectionEnd != null) {
                                final selectionRect = Rect.fromPoints(_selectionStart!, _selectionEnd!);
                                final selectedIds = <String>[];

                                for (final component in project.layers) {
                                  final componentRect = Rect.fromLTWH(
                                    component.x + kCanvasOrigin,
                                    component.y + kCanvasOrigin,
                                    component.width,
                                    component.height,
                                  );

                                  if (selectionRect.overlaps(componentRect)) {
                                    selectedIds.add(component.id);
                                  }
                                }

                                final isMultiSelect =
                                    HardwareKeyboard.instance.isShiftPressed ||
                                    HardwareKeyboard.instance.isMetaPressed ||
                                    HardwareKeyboard.instance.isControlPressed;

                                context.read<EditorBloc>().add(
                                  EditorEvent.selectComponents(selectedIds, multiSelect: isMultiSelect),
                                );

                                setState(() {
                                  _isSelecting = false;
                                  _selectionStart = null;
                                  _selectionEnd = null;
                                });
                              }
                            },
                            child: BlocBuilder<SettingsBloc, SettingsState>(
                              builder: (context, settingsState) {
                                return Container(
                                  // Large virtual canvas size
                                  width: kCanvasSize,
                                  height: kCanvasSize,
                                  color: Color(settingsState.editorBackgroundColor),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      // Grid (only in Edit mode)
                                      if (state.mode == EditorMode.edit && state.showGrid)
                                        Positioned.fill(
                                          child: CustomPaint(
                                            painter: GridPainter(
                                              gridSize: state.gridSize,
                                              origin: const Offset(kCanvasOrigin, kCanvasOrigin),
                                            ),
                                          ),
                                        ),
                                      // Path Preview
                                      if (state.currentTool == EditorTool.path && state.currentPathPoints.isNotEmpty)
                                        Positioned.fill(
                                          child: CustomPaint(
                                            painter: PathPreviewPainter(
                                              points: state.currentPathPoints,
                                              origin: const Offset(kCanvasOrigin, kCanvasOrigin),
                                            ),
                                          ),
                                        ),

                                      // Layers
                                      ...project.layers.map((component) {
                                        if (!component.isVisible) return const SizedBox();

                                        final isSelected = state.selectedComponentIds.contains(component.id);
                                        final isActive = state.activeComponentIds.contains(component.id);
                                        final padding = isSelected ? CanvasView.kHandlePadding : 0.0;

                                        // Translate data coordinates to visual coordinates
                                        final visualX = component.x + kCanvasOrigin;
                                        final visualY = component.y + kCanvasOrigin;

                                        return Positioned(
                                          left: visualX - padding,
                                          top: visualY - padding,
                                          child: RepaintBoundary(
                                            child: _ComponentWrapper(
                                              key: ValueKey(component.id),
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
                                          ),
                                        );
                                      }),

                                      // Selection Rectangle
                                      if (_isSelecting && _selectionStart != null && _selectionEnd != null)
                                        Positioned.fill(
                                          child: CustomPaint(
                                            painter: SelectionRectPainter(
                                              rect: Rect.fromPoints(_selectionStart!, _selectionEnd!),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
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

class SelectionRectPainter extends CustomPainter {
  final Rect rect;

  SelectionRectPainter({required this.rect});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRect(rect, paint);
    canvas.drawRect(rect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant SelectionRectPainter oldDelegate) {
    return oldDelegate.rect != rect;
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
    super.key,
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
