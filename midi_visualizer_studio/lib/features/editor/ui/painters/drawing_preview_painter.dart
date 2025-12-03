import 'package:flutter/material.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

class DrawingPreviewPainter extends CustomPainter {
  final Rect rect;
  final EditorTool tool;
  final Offset origin;

  DrawingPreviewPainter({required this.rect, required this.tool, required this.origin});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final handlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final handleBorderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Adjust rect by origin
    final visualRect = rect.shift(origin);

    if (tool == EditorTool.circle) {
      canvas.drawOval(visualRect, paint);
      canvas.drawOval(visualRect, borderPaint);

      // Draw bounding box for circle to show handles
      canvas.drawRect(
        visualRect,
        borderPaint
          ..color = Colors.blue.withOpacity(0.5)
          ..style = PaintingStyle.stroke,
      );
    } else {
      canvas.drawRect(visualRect, paint);
      canvas.drawRect(visualRect, borderPaint);
    }

    // Draw handles
    final handleSize = 8.0;
    final points = [
      visualRect.topLeft,
      visualRect.topRight,
      visualRect.bottomLeft,
      visualRect.bottomRight,
      visualRect.centerLeft,
      visualRect.centerRight,
      visualRect.topCenter,
      visualRect.bottomCenter,
    ];

    for (final point in points) {
      final handleRect = Rect.fromCenter(center: point, width: handleSize, height: handleSize);
      canvas.drawRect(handleRect, handlePaint);
      canvas.drawRect(handleRect, handleBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPreviewPainter oldDelegate) {
    return oldDelegate.rect != rect || oldDelegate.tool != tool || oldDelegate.origin != origin;
  }
}
