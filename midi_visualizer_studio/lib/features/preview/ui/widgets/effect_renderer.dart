import 'package:flutter/material.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/effect_config.dart';
import 'package:midi_visualizer_studio/features/editor/ui/painters/component_painter.dart';

class EffectRenderer extends StatefulWidget {
  final Component component;
  final bool isActive;
  final EffectConfig onConfig;
  final EffectConfig offConfig;

  const EffectRenderer({
    super.key,
    required this.component,
    required this.isActive,
    required this.onConfig,
    required this.offConfig,
  });

  @override
  State<EffectRenderer> createState() => _EffectRendererState();
}

class _EffectRendererState extends State<EffectRenderer> with TickerProviderStateMixin {
  late AnimationController _onController;
  late AnimationController _offController;
  late Animation<double> _onAnimation;
  late Animation<double> _offAnimation;

  @override
  void initState() {
    super.initState();
    _onController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.onConfig.durationMs),
    );
    _onAnimation = CurvedAnimation(parent: _onController, curve: Curves.easeOut);

    _offController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.offConfig.durationMs),
    );
    _offAnimation = CurvedAnimation(parent: _offController, curve: Curves.easeOut);
  }

  @override
  void didUpdateWidget(EffectRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.onConfig.durationMs != widget.onConfig.durationMs) {
      _onController.duration = Duration(milliseconds: widget.onConfig.durationMs);
    }
    if (oldWidget.offConfig.durationMs != widget.offConfig.durationMs) {
      _offController.duration = Duration(milliseconds: widget.offConfig.durationMs);
    }

    // Trigger Note On Effect (Inactive -> Active)
    if (!oldWidget.isActive && widget.isActive) {
      _onController.forward(from: 0.0);
    }

    // Trigger Note Off Effect (Active -> Inactive)
    if (oldWidget.isActive && !widget.isActive) {
      _offController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _onController.dispose();
    _offController.dispose();
    super.dispose();
  }

  Widget _buildEffect(EffectConfig config, AnimationController controller, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        if (!controller.isAnimating && controller.value == 0.0) {
          return const SizedBox();
        }
        if (controller.value == 1.0) {
          return const SizedBox();
        }

        final value = animation.value;
        double opacity = 1.0 - value;
        double scale = 1.0;

        if (config.type == EffectType.ripple) {
          scale = 1.0 + (config.scale - 1.0) * value;
        }

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: CustomPaint(
              painter: ComponentPainter(
                component: widget.component,
                isSelected: false,
                isActive: true, // Force ON state for the ghost
              ),
              size: Size(widget.component.width, widget.component.height),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base Layer
        CustomPaint(
          painter: ComponentPainter(component: widget.component, isSelected: false, isActive: widget.isActive),
          size: Size(widget.component.width, widget.component.height),
        ),

        // Note On Effect Layer
        if (widget.onConfig.type != EffectType.none) _buildEffect(widget.onConfig, _onController, _onAnimation),

        // Note Off Effect Layer
        if (widget.offConfig.type != EffectType.none) _buildEffect(widget.offConfig, _offController, _offAnimation),
      ],
    );
  }
}
