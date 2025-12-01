import 'dart:math' as math;
import 'package:flutter/material.dart';

class RulerWidget extends StatefulWidget {
  final Axis axis;
  final TransformationController controller;
  final double size;
  final Color backgroundColor;
  final Color tickColor;
  final TextStyle textStyle;

  final double originOffset;

  const RulerWidget({
    super.key,
    required this.axis,
    required this.controller,
    this.size = 20.0,
    this.backgroundColor = const Color(0xFF2D2D2D),
    this.tickColor = const Color(0xFF808080),
    this.textStyle = const TextStyle(color: Color(0xFF808080), fontSize: 10),
    this.originOffset = 0.0,
  });

  @override
  State<RulerWidget> createState() => _RulerWidgetState();
}

class _RulerWidgetState extends State<RulerWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTransformChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTransformChanged);
    super.dispose();
  }

  void _onTransformChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.axis == Axis.vertical ? widget.size : null,
      height: widget.axis == Axis.horizontal ? widget.size : null,
      color: widget.backgroundColor,
      child: ClipRect(
        child: CustomPaint(
          painter: _RulerPainter(
            axis: widget.axis,
            transform: widget.controller.value,
            tickColor: widget.tickColor,
            textStyle: widget.textStyle,
            originOffset: widget.originOffset,
          ),
        ),
      ),
    );
  }
}

class _RulerPainter extends CustomPainter {
  final Axis axis;
  final Matrix4 transform;
  final Color tickColor;
  final TextStyle textStyle;
  final double originOffset;

  _RulerPainter({
    required this.axis,
    required this.transform,
    required this.tickColor,
    required this.textStyle,
    required this.originOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final scale = transform.getMaxScaleOnAxis();
    final translation = transform.getTranslation();
    final offset = axis == Axis.horizontal ? translation.x : translation.y;

    final paint = Paint()
      ..color = tickColor
      ..strokeWidth = 1;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Determine step size based on scale
    double step = 100.0;
    if (scale > 2.0) step = 50.0;
    if (scale > 4.0) step = 10.0;
    if (scale < 0.5) step = 200.0;
    if (scale < 0.25) step = 500.0;

    // Visible range
    final visibleStart = -offset / scale;
    final visibleEnd = visibleStart + (axis == Axis.horizontal ? size.width : size.height) / scale;

    // Align start to step
    final start = (visibleStart / step).floor() * step;

    for (double i = start; i <= visibleEnd; i += step) {
      final pos = (i * scale) + offset;

      if (axis == Axis.horizontal) {
        // Major tick
        canvas.drawLine(Offset(pos, 0), Offset(pos, size.height), paint);

        // Label
        textPainter.text = TextSpan(text: (i - originOffset).toInt().toString(), style: textStyle);
        textPainter.layout();
        textPainter.paint(canvas, Offset(pos + 2, 0));
      } else {
        // Major tick
        canvas.drawLine(Offset(0, pos), Offset(size.width, pos), paint);

        // Label
        textPainter.text = TextSpan(text: (i - originOffset).toInt().toString(), style: textStyle);
        textPainter.layout();
        // Rotate text for vertical ruler? Or just draw it horizontally
        // Drawing horizontally is easier to read
        canvas.save();
        canvas.translate(0, pos + 2);
        canvas.rotate(-math.pi / 2);
        textPainter.paint(canvas, Offset(-textPainter.width, 0)); // Adjust position
        canvas.restore();

        // Alternative: just draw it normally
        // textPainter.paint(canvas, Offset(2, pos + 2));
      }

      // Minor ticks
      final minorStep = step / 5; // 5 subdivisions
      for (int j = 1; j < 5; j++) {
        final minorPos = ((i + minorStep * j) * scale) + offset;
        if (minorPos > (axis == Axis.horizontal ? size.width : size.height)) break;

        if (axis == Axis.horizontal) {
          canvas.drawLine(Offset(minorPos, size.height * 0.7), Offset(minorPos, size.height), paint);
        } else {
          canvas.drawLine(Offset(size.width * 0.7, minorPos), Offset(size.width, minorPos), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RulerPainter oldDelegate) {
    return oldDelegate.transform != transform ||
        oldDelegate.axis != axis ||
        oldDelegate.tickColor != tickColor ||
        oldDelegate.textStyle != textStyle ||
        oldDelegate.originOffset != originOffset;
  }
}
