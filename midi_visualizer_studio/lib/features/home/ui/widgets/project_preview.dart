import 'package:flutter/material.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/ui/painters/component_painter.dart';

class ProjectPreview extends StatelessWidget {
  final Project project;

  const ProjectPreview({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _parseColor(project.backgroundColor),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate content bounds
          Rect contentBounds;
          if (project.layers.isEmpty) {
            contentBounds = const Rect.fromLTWH(0, 0, 800, 600);
          } else {
            double minX = double.infinity;
            double minY = double.infinity;
            double maxX = double.negativeInfinity;
            double maxY = double.negativeInfinity;

            for (final layer in project.layers) {
              if (layer.x < minX) minX = layer.x;
              if (layer.y < minY) minY = layer.y;
              if (layer.x + layer.width > maxX) maxX = layer.x + layer.width;
              if (layer.y + layer.height > maxY) maxY = layer.y + layer.height;
            }

            // Add some padding
            const padding = 20.0;
            contentBounds = Rect.fromLTRB(minX - padding, minY - padding, maxX + padding, maxY + padding);
          }

          return FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox(
              width: contentBounds.width,
              height: contentBounds.height,
              child: Stack(
                children: [
                  // Translate content so that top-left is at (0,0) of the SizedBox
                  Transform.translate(
                    offset: Offset(-contentBounds.left, -contentBounds.top),
                    child: Stack(
                      children: project.layers.map((component) {
                        if (!component.isVisible) return const SizedBox();

                        return Positioned(
                          left: component.x,
                          top: component.y,
                          child: CustomPaint(
                            painter: ComponentPainter(
                              component: component,
                              isSelected: false,
                              isActive: false, // Preview is static
                            ),
                            size: Size(component.width, component.height),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _parseColor(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return Colors.black;
    }
  }
}
