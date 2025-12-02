import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double gridSize;
  final Offset origin;

  GridPainter({required this.gridSize, this.origin = Offset.zero});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Adjust start point to align with origin
    final startX = origin.dx % gridSize;
    final startY = origin.dy % gridSize;

    for (double x = startX; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = startY; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw axes
    final axisPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    if (origin.dx >= 0 && origin.dx <= size.width) {
      canvas.drawLine(Offset(origin.dx, 0), Offset(origin.dx, size.height), axisPaint);
    }
    if (origin.dy >= 0 && origin.dy <= size.height) {
      canvas.drawLine(Offset(0, origin.dy), Offset(size.width, origin.dy), axisPaint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) =>
      oldDelegate.gridSize != gridSize || oldDelegate.origin != origin;
}
