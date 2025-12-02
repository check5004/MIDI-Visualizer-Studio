import 'package:flutter/material.dart';

class PathPreviewPainter extends CustomPainter {
  final List<Offset> points;
  final Offset origin;

  PathPreviewPainter({required this.points, this.origin = Offset.zero});

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

    // Translate points by origin
    final visualPoints = points.map((p) => p + origin).toList();

    for (int i = 0; i < visualPoints.length; i++) {
      canvas.drawCircle(visualPoints[i], 4, pointPaint);
      if (i > 0) {
        canvas.drawLine(visualPoints[i - 1], visualPoints[i], paint);
      }
    }

    // Close the loop preview if more than 2 points
    if (visualPoints.length > 2) {
      final closePaint = Paint()
        ..color = Colors.blue.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      canvas.drawLine(visualPoints.last, visualPoints.first, closePaint);
    }
  }

  @override
  bool shouldRepaint(covariant PathPreviewPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.origin != origin;
  }
}
