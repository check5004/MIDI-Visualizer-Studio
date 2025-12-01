import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';

enum _DragHandle {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
  rotate,
  none,
}

class ComponentSelectionOverlay extends StatefulWidget {
  final Component component;
  final double gridSize;
  final bool snapToGrid;
  final double padding;
  final Widget child;

  const ComponentSelectionOverlay({
    super.key,
    required this.component,
    required this.gridSize,
    required this.snapToGrid,
    this.padding = 0,
    required this.child,
  });

  @override
  State<ComponentSelectionOverlay> createState() => _ComponentSelectionOverlayState();
}

class _ComponentSelectionOverlayState extends State<ComponentSelectionOverlay> {
  _DragHandle _currentHandle = _DragHandle.none;
  Offset _startDragPos = Offset.zero;

  // Initial values at start of drag
  double _startX = 0;
  double _startY = 0;
  double _startWidth = 0;
  double _startHeight = 0;
  double _startRotation = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.component.width + widget.padding * 2,
      height: widget.component.height + widget.padding * 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // The component content
          Positioned(left: widget.padding, top: widget.padding, child: widget.child),

          // The selection border
          Positioned(
            left: widget.padding,
            top: widget.padding,
            width: widget.component.width,
            height: widget.component.height,
            child: CustomPaint(painter: _SelectionPainter(color: Colors.blue)),
          ),

          // Hit test targets for handles
          // Corners
          _buildHandle(_DragHandle.topLeft, widget.padding - 5, widget.padding - 5),
          _buildHandle(_DragHandle.topCenter, widget.padding + widget.component.width / 2 - 5, widget.padding - 5),
          _buildHandle(_DragHandle.topRight, widget.padding + widget.component.width - 5, widget.padding - 5),

          _buildHandle(_DragHandle.centerLeft, widget.padding - 5, widget.padding + widget.component.height / 2 - 5),
          _buildHandle(
            _DragHandle.centerRight,
            widget.padding + widget.component.width - 5,
            widget.padding + widget.component.height / 2 - 5,
          ),

          _buildHandle(_DragHandle.bottomLeft, widget.padding - 5, widget.padding + widget.component.height - 5),
          _buildHandle(
            _DragHandle.bottomCenter,
            widget.padding + widget.component.width / 2 - 5,
            widget.padding + widget.component.height - 5,
          ),
          _buildHandle(
            _DragHandle.bottomRight,
            widget.padding + widget.component.width - 5,
            widget.padding + widget.component.height - 5,
          ),

          // Rotation handle (top center, slightly above)
          _buildHandle(
            _DragHandle.rotate,
            widget.padding + widget.component.width / 2 - 5,
            widget.padding - 25,
            isRotation: true,
          ),
        ],
      ),
    );
  }

  Widget _buildHandle(_DragHandle handle, double left, double top, {bool isRotation = false}) {
    MouseCursor cursor = SystemMouseCursors.basic;
    if (handle == _DragHandle.topLeft || handle == _DragHandle.bottomRight) {
      cursor = SystemMouseCursors.resizeUpLeftDownRight;
    } else if (handle == _DragHandle.topRight || handle == _DragHandle.bottomLeft) {
      cursor = SystemMouseCursors.resizeUpRightDownLeft;
    } else if (handle == _DragHandle.topCenter || handle == _DragHandle.bottomCenter) {
      cursor = SystemMouseCursors.resizeUpDown;
    } else if (handle == _DragHandle.centerLeft || handle == _DragHandle.centerRight) {
      cursor = SystemMouseCursors.resizeLeftRight;
    } else if (handle == _DragHandle.rotate) {
      cursor = SystemMouseCursors.grab;
    }

    return Positioned(
      left: left,
      top: top,
      child: MouseRegion(
        cursor: cursor,
        child: GestureDetector(
          onPanStart: (details) {
            _currentHandle = handle;
            _startDragPos = details.globalPosition;
            _startX = widget.component.x;
            _startY = widget.component.y;
            _startWidth = widget.component.width;
            _startHeight = widget.component.height;
            _startRotation = widget.component.rotation;
          },
          onPanUpdate: (details) {
            _handleDrag(details);
          },
          onPanEnd: (details) {
            _currentHandle = _DragHandle.none;
          },
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: isRotation ? Colors.green : Colors.white,
              border: Border.all(color: Colors.blue),
              shape: isRotation ? BoxShape.circle : BoxShape.rectangle,
            ),
          ),
        ),
      ),
    );
  }

  void _handleDrag(DragUpdateDetails details) {
    if (_currentHandle == _DragHandle.none) return;

    // We need to account for zoom level
    final scale = context.read<EditorBloc>().state.zoomLevel;

    if (_currentHandle == _DragHandle.rotate) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final centerLocal = renderBox.size.center(Offset.zero);
      final centerGlobal = renderBox.localToGlobal(centerLocal);

      final startAngle = (_startDragPos - centerGlobal).direction;
      final currentAngle = (details.globalPosition - centerGlobal).direction;

      final angleDelta = currentAngle - startAngle;

      final newRotation = _startRotation + angleDelta;

      final updatedComponent = widget.component.map(
        pad: (c) => c.copyWith(rotation: newRotation),
        knob: (c) => c.copyWith(rotation: newRotation),
        staticImage: (c) => c.copyWith(rotation: newRotation),
      );

      context.read<EditorBloc>().add(EditorEvent.updateComponent(widget.component.id, updatedComponent));
      return;
    }

    final delta = details.globalPosition - _startDragPos;
    final dxGlobal = delta.dx / scale;
    final dyGlobal = delta.dy / scale;

    // Project global delta onto local axes (rotated)
    // We rotate the delta vector by -rotation to align it with the component's local coordinate system
    final double rot = widget.component.rotation;
    final double cosT = math.cos(-rot);
    final double sinT = math.sin(-rot);

    final double dx = (dxGlobal * cosT - dyGlobal * sinT);
    final double dy = (dxGlobal * sinT + dyGlobal * cosT);

    double newX = _startX;
    double newY = _startY;
    double newWidth = _startWidth;
    double newHeight = _startHeight;
    double newRotation = _startRotation;

    // Resizing
    double dW = 0;
    double dH = 0;

    if (_currentHandle == _DragHandle.topLeft) {
      dW = -dx;
      dH = -dy;
    } else if (_currentHandle == _DragHandle.topCenter) {
      dH = -dy;
    } else if (_currentHandle == _DragHandle.topRight) {
      dW = dx;
      dH = -dy;
    } else if (_currentHandle == _DragHandle.centerLeft) {
      dW = -dx;
    } else if (_currentHandle == _DragHandle.centerRight) {
      dW = dx;
    } else if (_currentHandle == _DragHandle.bottomLeft) {
      dW = -dx;
      dH = dy;
    } else if (_currentHandle == _DragHandle.bottomCenter) {
      dH = dy;
    } else if (_currentHandle == _DragHandle.bottomRight) {
      dW = dx;
      dH = dy;
    }

    // Aspect Ratio Logic
    final keys = HardwareKeyboard.instance.logicalKeysPressed;
    final isShift = keys.contains(LogicalKeyboardKey.shiftLeft) || keys.contains(LogicalKeyboardKey.shiftRight);
    final isCtrl =
        keys.contains(LogicalKeyboardKey.controlLeft) ||
        keys.contains(LogicalKeyboardKey.controlRight) ||
        keys.contains(LogicalKeyboardKey.metaLeft) ||
        keys.contains(LogicalKeyboardKey.metaRight); // Command on Mac
    final isAlt = keys.contains(LogicalKeyboardKey.altLeft) || keys.contains(LogicalKeyboardKey.altRight);

    if (isAlt) {
      dW *= 2;
      dH *= 2;
    }

    double candidateWidth = _startWidth + dW;
    double candidateHeight = _startHeight + dH;

    final shouldMaintainRatio = widget.component.maintainAspectRatio || isShift;
    final forceSquare = isCtrl;

    if (forceSquare) {
      // Force 1:1
      if (_currentHandle == _DragHandle.topCenter || _currentHandle == _DragHandle.bottomCenter) {
        candidateWidth = candidateHeight;
      } else if (_currentHandle == _DragHandle.centerLeft || _currentHandle == _DragHandle.centerRight) {
        candidateHeight = candidateWidth;
      } else {
        // Corner: take the larger dimension or average? Let's take width.
        candidateHeight = candidateWidth;
      }
    } else if (shouldMaintainRatio && _startWidth > 0 && _startHeight > 0) {
      final ratio = _startWidth / _startHeight;
      if (_currentHandle == _DragHandle.topCenter || _currentHandle == _DragHandle.bottomCenter) {
        candidateWidth = candidateHeight * ratio;
      } else if (_currentHandle == _DragHandle.centerLeft || _currentHandle == _DragHandle.centerRight) {
        candidateHeight = candidateWidth / ratio;
      } else {
        // Corner: Use the dimension with larger change relative to size?
        // Simple approach: Use width to drive height
        candidateHeight = candidateWidth / ratio;
      }
    }

    // Recalculate deltas
    dW = candidateWidth - _startWidth;
    dH = candidateHeight - _startHeight;

    newWidth = _startWidth + dW;
    newHeight = _startHeight + dH;

    // Minimum size
    if (newWidth < 10) {
      newWidth = 10;
      dW = newWidth - _startWidth;
      // Re-adjust height if locked?
      if (forceSquare) {
        newHeight = 10;
        dH = newHeight - _startHeight;
      } else if (shouldMaintainRatio && _startWidth > 0) {
        newHeight = newWidth / (_startWidth / _startHeight);
        dH = newHeight - _startHeight;
      }
    }
    if (newHeight < 10) {
      newHeight = 10;
      dH = newHeight - _startHeight;
      // Re-adjust width if locked?
      if (forceSquare) {
        newWidth = 10;
        dW = newWidth - _startWidth;
      } else if (shouldMaintainRatio && _startHeight > 0) {
        newWidth = newHeight * (_startWidth / _startHeight);
        dW = newWidth - _startWidth;
      }
    }

    // Calculate center shift based on final dW/dH and handle
    double dCenterX = 0;
    double dCenterY = 0;

    if (!isAlt) {
      if (_currentHandle == _DragHandle.topLeft) {
        dCenterX = -dW / 2;
        dCenterY = -dH / 2;
      } else if (_currentHandle == _DragHandle.topCenter) {
        dCenterY = -dH / 2;
      } else if (_currentHandle == _DragHandle.topRight) {
        dCenterX = dW / 2;
        dCenterY = -dH / 2;
      } else if (_currentHandle == _DragHandle.centerLeft) {
        dCenterX = -dW / 2;
      } else if (_currentHandle == _DragHandle.centerRight) {
        dCenterX = dW / 2;
      } else if (_currentHandle == _DragHandle.bottomLeft) {
        dCenterX = -dW / 2;
        dCenterY = dH / 2;
      } else if (_currentHandle == _DragHandle.bottomCenter) {
        dCenterY = dH / 2;
      } else if (_currentHandle == _DragHandle.bottomRight) {
        dCenterX = dW / 2;
        dCenterY = dH / 2;
      }
    }

    // Calculate global center shift
    // Rotate (dCenterX, dCenterY) by rotation
    final double rad = widget.component.rotation;
    final double globalDCenterX = dCenterX * math.cos(rad) - dCenterY * math.sin(rad);
    final double globalDCenterY = dCenterX * math.sin(rad) + dCenterY * math.cos(rad);

    // New Center = Old Center + Global Shift
    // New TopLeft = New Center - NewSize / 2

    final double oldCenterX = _startX + _startWidth / 2;
    final double oldCenterY = _startY + _startHeight / 2;

    final double newCenterX = oldCenterX + globalDCenterX;
    final double newCenterY = oldCenterY + globalDCenterY;

    newX = newCenterX - newWidth / 2;
    newY = newCenterY - newHeight / 2;

    final updatedComponent = widget.component.map(
      pad: (c) => c.copyWith(x: newX, y: newY, width: newWidth, height: newHeight, rotation: newRotation),
      knob: (c) => c.copyWith(x: newX, y: newY, width: newWidth, height: newHeight, rotation: newRotation),
      staticImage: (c) => c.copyWith(x: newX, y: newY, width: newWidth, height: newHeight, rotation: newRotation),
    );

    context.read<EditorBloc>().add(EditorEvent.updateComponent(widget.component.id, updatedComponent));
  }
}

class _SelectionPainter extends CustomPainter {
  final Color color;

  _SelectionPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRect(Offset.zero & size, paint);

    // Draw line to rotation handle
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, -20), paint);
  }

  @override
  bool shouldRepaint(covariant _SelectionPainter oldDelegate) => oldDelegate.color != color;
}
