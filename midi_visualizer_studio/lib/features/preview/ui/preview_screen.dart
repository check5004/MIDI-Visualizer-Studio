import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/ui/painters/component_painter.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

class PreviewScreen extends StatefulWidget {
  final Project project;

  const PreviewScreen({super.key, required this.project});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool _isHovering = false;
  Rect _contentBounds = Rect.zero;

  @override
  void initState() {
    super.initState();
    _calculateContentBounds();
    _enterPreviewMode();
  }

  @override
  void dispose() {
    _exitPreviewMode();
    super.dispose();
  }

  void _calculateContentBounds() {
    if (widget.project.layers.isEmpty) {
      _contentBounds = const Rect.fromLTWH(0, 0, 800, 600);
      return;
    }

    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;

    for (final layer in widget.project.layers) {
      if (layer.x < minX) minX = layer.x;
      if (layer.y < minY) minY = layer.y;
      if (layer.x + layer.width > maxX) maxX = layer.x + layer.width;
      if (layer.y + layer.height > maxY) maxY = layer.y + layer.height;
    }

    // Add some padding
    const padding = 20.0;
    _contentBounds = Rect.fromLTRB(minX - padding, minY - padding, maxX + padding, maxY + padding);
  }

  Future<void> _enterPreviewMode() async {
    if (kIsWeb) return;
    await windowManager.setHasShadow(false);
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.setAlwaysOnTop(true);

    if (!kIsWeb && Platform.isWindows) {
      await Window.setEffect(effect: WindowEffect.transparent);
    }

    // Auto-resize
    // We need to ensure the window is at least a certain size and fits the content
    // Note: This sets the window size, not the content scale.
    // The content will be scaled to fit this window size by FittedBox.
    // But ideally, we want the window to match the content size 1:1 initially if possible.
    // Let's try to set the window size to the content size.
    // Wait for transition to complete
    await Future.delayed(const Duration(milliseconds: 100));

    if (widget.project.previewWindowWidth != null && widget.project.previewWindowHeight != null) {
      await windowManager.setSize(
        Size(widget.project.previewWindowWidth!, widget.project.previewWindowHeight!),
        animate: false,
      );
    } else {
      await windowManager.setSize(Size(_contentBounds.width, _contentBounds.height), animate: false);
    }
    await windowManager.setAspectRatio(_contentBounds.width / _contentBounds.height);

    // Re-apply shadow removal after resize as it might have been reset
    await windowManager.setHasShadow(false);

    // Optionally center? Or keep position?
    // User didn't specify, but centering is safe.
    // await windowManager.center();

    if (mounted) setState(() {});
  }

  Future<void> _exitPreviewMode() async {
    if (kIsWeb) return;
    await windowManager.setHasShadow(true);
    await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    await windowManager.setAlwaysOnTop(false);
    await windowManager.setAspectRatio(0);
  }

  Future<void> _handleClose() async {
    if (!kIsWeb) {
      // Save current window size
      final size = await windowManager.getSize();
      final updatedProject = widget.project.copyWith(previewWindowWidth: size.width, previewWindowHeight: size.height);

      // Restore default size first
      await windowManager.setSize(const Size(1280, 720), animate: false);
      await windowManager.center();
      // Wait for resize to complete before navigating
      await Future.delayed(const Duration(milliseconds: 100));

      if (mounted) {
        if (context.canPop()) {
          context.pop(updatedProject);
        } else {
          context.go('/home');
        }
      }
    } else {
      if (mounted) {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go('/home');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditorBloc(historyCubit: null, projectRepository: null)
            ..add(EditorEvent.loadProject(path: widget.project.id, project: widget.project)),
      child: BlocListener<MidiBloc, MidiState>(
        listener: (context, midiState) {
          if (midiState.lastPacket != null) {
            context.read<EditorBloc>().add(EditorEvent.handleMidiMessage(midiState.lastPacket!));
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: MouseRegion(
            onEnter: (_) => setState(() => _isHovering = true),
            onExit: (_) => setState(() => _isHovering = false),
            child: Stack(
              children: [
                // Content
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: _contentBounds.width,
                      height: _contentBounds.height,
                      child: BlocBuilder<EditorBloc, EditorState>(
                        builder: (context, state) {
                          final project = state.project;
                          if (project == null) return const SizedBox();

                          return Stack(
                            children: [
                              Stack(
                                children: project.layers.map((component) {
                                  if (!component.isVisible) return const SizedBox();

                                  final isActive = state.activeComponentIds.contains(component.id);

                                  return Positioned(
                                    left: component.x - _contentBounds.left,
                                    top: component.y - _contentBounds.top,
                                    child: CustomPaint(
                                      painter: ComponentPainter(
                                        component: component,
                                        isSelected: false,
                                        isActive: isActive,
                                      ),
                                      size: Size(component.width, component.height),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Hover Controls
                AnimatedOpacity(
                  opacity: _isHovering ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SafeArea(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Drag Handle (Window Mover)
                              GestureDetector(
                                onPanStart: (details) => windowManager.startDragging(),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.drag_handle, color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 8),
                              FloatingActionButton(
                                mini: true,
                                backgroundColor: Colors.red,
                                child: const Icon(Icons.close, color: Colors.white),
                                onPressed: () {
                                  _handleClose();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
