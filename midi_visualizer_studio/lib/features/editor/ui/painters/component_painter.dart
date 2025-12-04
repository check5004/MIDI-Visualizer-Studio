import 'dart:math';
import 'package:flutter/material.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';

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
        if (pad.cornerRadius > 0) {
          canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(pad.cornerRadius)), paint);
        } else {
          canvas.drawRect(Offset.zero & size, paint);
        }
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
