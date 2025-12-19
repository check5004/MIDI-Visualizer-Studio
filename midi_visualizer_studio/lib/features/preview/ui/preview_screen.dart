import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';

import 'package:midi_visualizer_studio/l10n/app_localizations.dart';

import 'package:midi_visualizer_studio/features/preview/ui/widgets/effect_renderer.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:midi_visualizer_studio/features/midi/ui/dialogs/midi_settings_dialog.dart';

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

    if (!kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_in_preview_mode', true);
      await prefs.setString('last_project_id', widget.project.id);
    }

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

    if (!kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_in_preview_mode', false);
    }
  }

  Future<void> _handleExitFullscreen() async {
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

  Future<void> _showMidiSettings() async {
    // Current window size
    final currentSize = await windowManager.getSize();
    // Required size for dialog (with some padding)
    const minWidth = 650.0;
    const minHeight = 600.0;

    bool needsResize = false;
    if (currentSize.width < minWidth || currentSize.height < minHeight) {
      needsResize = true;
      await windowManager.setSize(
        Size(
          currentSize.width < minWidth ? minWidth : currentSize.width,
          currentSize.height < minHeight ? minHeight : currentSize.height,
        ),
        animate: true,
      );
      // Wait for resize animation to complete (OS dependent, safer to wait plenty)
      await Future.delayed(const Duration(milliseconds: 500));
    }

    if (!mounted) return;

    await showDialog(context: context, builder: (context) => const MidiSettingsDialog());

    if (needsResize) {
      // Wait for dialog exit animation to complete before shrinking
      await Future.delayed(const Duration(milliseconds: 500));
      await windowManager.setSize(currentSize, animate: true);
    }
  }

  Future<void> _handleCloseApp() async {
    await windowManager.close();
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
                                    child: EffectRenderer(
                                      component: component,
                                      isActive: isActive,
                                      onConfig: component.map(
                                        pad: (c) => c.onEffectConfig ?? project.defaultOnEffectConfig,
                                        knob: (c) => c.onEffectConfig ?? project.defaultOnEffectConfig,
                                        staticImage: (_) => project.defaultOnEffectConfig,
                                      ),
                                      offConfig: component.map(
                                        pad: (c) => c.offEffectConfig ?? project.defaultOffEffectConfig,
                                        knob: (c) => c.offEffectConfig ?? project.defaultOffEffectConfig,
                                        staticImage: (_) => project.defaultOffEffectConfig,
                                      ),
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
                // Window Drag Layer
                Positioned.fill(
                  child: GestureDetector(
                    onPanStart: (details) => windowManager.startDragging(),
                    behavior: HitTestBehavior.translucent,
                    child: const SizedBox.expand(),
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
                              FloatingActionButton(
                                mini: true,
                                heroTag: 'midi_settings',
                                backgroundColor: Colors.white,
                                tooltip: AppLocalizations.of(context)!.midiSettings,
                                onPressed: () {
                                  _showMidiSettings();
                                },
                                child: const Icon(Icons.settings_input_component, color: Colors.black),
                              ),
                              const SizedBox(width: 8),
                              FloatingActionButton(
                                mini: true,
                                heroTag: 'exit_fullscreen',
                                backgroundColor: Colors.lightBlue,
                                tooltip: AppLocalizations.of(context)!.exitFullscreen,
                                child: const Icon(Icons.fullscreen_exit, color: Colors.white),
                                onPressed: () {
                                  _handleExitFullscreen();
                                },
                              ),
                              const SizedBox(width: 8),
                              FloatingActionButton(
                                mini: true,
                                heroTag: 'close_app',
                                backgroundColor: Colors.red,
                                tooltip: AppLocalizations.of(context)!.closeApp,
                                child: const Icon(Icons.close, color: Colors.white),
                                onPressed: () {
                                  _handleCloseApp();
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
