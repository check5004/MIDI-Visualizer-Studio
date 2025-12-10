import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';

import 'package:midi_visualizer_studio/data/models/effect_config.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/features/common/ui/advanced_color_picker_dialog.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/number_input.dart';
import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';
import 'package:midi_visualizer_studio/core/utils/midi_parser.dart';
import 'package:midi_visualizer_studio/l10n/app_localizations.dart';

class InspectorPanel extends StatefulWidget {
  const InspectorPanel({super.key});

  @override
  State<InspectorPanel> createState() => _InspectorPanelState();
}

class _InspectorPanelState extends State<InspectorPanel> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_lastBoundTime != null && DateTime.now().difference(_lastBoundTime!) < const Duration(seconds: 3)) {
        if (mounted) setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  bool _isLearning = false;
  String? _learningComponentId;
  DateTime? _lastBoundTime;
  int _currentVelocity = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MidiBloc, MidiState>(
      listenWhen: (previous, current) => current.lastPacket != null && current.lastPacket != previous.lastPacket,
      listener: (context, midiState) {
        final packet = midiState.lastPacket!;
        if (packet.data.isEmpty) return;

        final messages = MidiParser.parse(packet.data);
        if (messages.isEmpty) return;

        for (final message in messages) {
          if (_isLearning) {
            if (_learningComponentId == null) continue;

            bool bound = false;
            if (message.isNoteOn || message.isNoteOff) {
              // Note On/Off
              _bindMidi(_learningComponentId!, message.channel, note: message.data1);
              bound = true;
            } else if (message.isControlChange) {
              // CC
              _bindMidi(_learningComponentId!, message.channel, cc: message.data1);
              bound = true;
            }

            if (bound) {
              setState(() {
                _isLearning = false;
                _learningComponentId = null;
                _lastBoundTime = DateTime.now();
              });
              break; // Stop after first successful bind
            }
          } else {
            // Monitor velocity for selected component
            final selectedIds = context.read<EditorBloc>().state.selectedComponentIds;
            if (selectedIds.isNotEmpty) {
              final selectedId = selectedIds.first;
              final project = context.read<EditorBloc>().state.project;
              if (project != null) {
                final component = project.layers.firstWhere(
                  (c) => c.id == selectedId,
                  orElse: () => throw Exception('Component not found'),
                );

                int? targetChannel;
                int? targetNote;

                component.map(
                  pad: (c) {
                    targetChannel = c.midiChannel;
                    targetNote = c.midiNote;
                  },
                  knob: (c) {
                    targetChannel = c.midiChannel;
                    targetNote = c.midiCc;
                  },
                  staticImage: (_) {},
                );

                if (targetChannel != null && targetNote != null) {
                  if (message.channel == targetChannel && message.data1 == targetNote) {
                    if (message.isNoteOn) {
                      setState(() => _currentVelocity = message.data2);
                    } else if (message.isNoteOff) {
                      setState(() => _currentVelocity = 0);
                    }
                  }
                }
              }
            }
          }
        }
      },
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: BlocBuilder<EditorBloc, EditorState>(
          builder: (context, state) {
            final project = state.project;
            if (project == null) {
              return Center(child: Text(AppLocalizations.of(context)!.noProjectSelected));
            }

            // Filter selectedIds to only include components that actually exist in the project
            // This prevents crashes when undoing a "Paste" or "Add" operation where the component is removed
            // but remains in the selection state.
            final selectedIds = state.selectedComponentIds
                .where((id) => project.layers.any((layer) => layer.id == id))
                .toSet();

            if (state.status == EditorStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (selectedIds.isEmpty) {
              return _buildProjectSettings(context, project);
            }

            if (selectedIds.length > 1) {
              final selectedComponents = project.layers.where((c) => selectedIds.contains(c.id)).toList();
              return _buildMultiSelectionProperties(context, selectedComponents);
            }

            final selectedId = selectedIds.first;
            final component = project.layers.firstWhere(
              (c) => c.id == selectedId,
              orElse: () => throw Exception('Selected component not found'),
            );

            return _buildComponentProperties(context, component);
          },
        ),
      ),
    );
  }

  void _bindMidi(String componentId, int channel, {int? note, int? cc}) {
    final editorBloc = context.read<EditorBloc>();
    final project = editorBloc.state.project;
    if (project == null) return;

    final component = project.layers.firstWhere((c) => c.id == componentId);

    final updated = component.map(
      pad: (c) => c.copyWith(midiChannel: channel, midiNote: note),
      knob: (c) => c.copyWith(midiChannel: channel, midiCc: cc),
      staticImage: (c) => c, // No MIDI binding for images yet
    );

    editorBloc.add(EditorEvent.updateComponent(componentId, updated));
  }

  Widget _buildProjectSettings(BuildContext context, Project project) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          AppLocalizations.of(context)!.projectSettings,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),
        _buildEffectProperties(
          context,
          AppLocalizations.of(context)!.defaultNoteOnEffect,
          project.defaultOnEffectConfig,
          (newConfig) {
            context.read<EditorBloc>().add(
              EditorEvent.updateProjectSettings(project.copyWith(defaultOnEffectConfig: newConfig)),
            );
          },
        ),
        const SizedBox(height: 16),
        _buildEffectProperties(
          context,
          AppLocalizations.of(context)!.defaultNoteOffEffect,
          project.defaultOffEffectConfig,
          (newConfig) {
            context.read<EditorBloc>().add(
              EditorEvent.updateProjectSettings(project.copyWith(defaultOffEffectConfig: newConfig)),
            );
          },
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            AppLocalizations.of(context)!.selectComponentToEdit,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildComponentProperties(BuildContext context, Component component) {
    final isLearningThis = _isLearning && _learningComponentId == component.id;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          AppLocalizations.of(context)!.properties,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),
        _PropertyField(
          label: AppLocalizations.of(context)!.name,
          value: component.name,
          enabled: !component.isLocked,
          onChanged: (value) {
            final updated = component.map(
              pad: (c) => c.copyWith(name: value),
              knob: (c) => c.copyWith(name: value),
              staticImage: (c) => c.copyWith(name: value),
            );
            context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
          },
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: NumberInput(
                label: AppLocalizations.of(context)!.x,
                value: component.x,
                enabled: !component.isLocked,
                onChanged: (value) {
                  final updated = component.map(
                    pad: (c) => c.copyWith(x: value),
                    knob: (c) => c.copyWith(x: value),
                    staticImage: (c) => c.copyWith(x: value),
                  );
                  context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: NumberInput(
                label: AppLocalizations.of(context)!.y,
                value: component.y,
                enabled: !component.isLocked,
                onChanged: (value) {
                  final updated = component.map(
                    pad: (c) => c.copyWith(y: value),
                    knob: (c) => c.copyWith(y: value),
                    staticImage: (c) => c.copyWith(y: value),
                  );
                  context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: NumberInput(
                label: AppLocalizations.of(context)!.w,
                value: component.width,
                enabled: !component.isLocked,
                onChanged: (value) {
                  var updated = component.map(
                    pad: (c) => c.copyWith(width: value),
                    knob: (c) => c.copyWith(width: value),
                    staticImage: (c) => c.copyWith(width: value),
                  );

                  if (component.maintainAspectRatio && component.width > 0) {
                    final ratio = component.height / component.width;
                    final newHeight = value * ratio;
                    updated = updated.map(
                      pad: (c) => c.copyWith(height: newHeight),
                      knob: (c) => c.copyWith(height: newHeight),
                      staticImage: (c) => c.copyWith(height: newHeight),
                    );
                  }

                  context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: NumberInput(
                label: AppLocalizations.of(context)!.h,
                value: component.height,
                enabled: !component.isLocked,
                onChanged: (value) {
                  var updated = component.map(
                    pad: (c) => c.copyWith(height: value),
                    knob: (c) => c.copyWith(height: value),
                    staticImage: (c) => c.copyWith(height: value),
                  );

                  if (component.maintainAspectRatio && component.height > 0) {
                    final ratio = component.width / component.height;
                    final newWidth = value * ratio;
                    updated = updated.map(
                      pad: (c) => c.copyWith(width: newWidth),
                      knob: (c) => c.copyWith(width: newWidth),
                      staticImage: (c) => c.copyWith(width: newWidth),
                    );
                  }

                  context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                },
              ),
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                Text('', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 4),
                IconButton(
                  icon: Icon(
                    component.maintainAspectRatio ? Icons.link : Icons.link_off,
                    size: 20,
                    color: component.maintainAspectRatio ? Theme.of(context).colorScheme.primary : Colors.grey,
                  ),
                  tooltip: AppLocalizations.of(context)!.lockAspectRatio,
                  onPressed: () {
                    final updated = component.map(
                      pad: (c) => c.copyWith(maintainAspectRatio: !c.maintainAspectRatio),
                      knob: (c) => c.copyWith(maintainAspectRatio: !c.maintainAspectRatio),
                      staticImage: (c) => c.copyWith(maintainAspectRatio: !c.maintainAspectRatio),
                    );
                    context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        const SizedBox(height: 16),

        Text(AppLocalizations.of(context)!.typeSpecific, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...component.map(
          pad: (c) => _buildPadProperties(context, c),
          knob: (c) => _buildKnobProperties(context, c),
          staticImage: (c) => [],
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.midiBinding, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildMidiBindingSection(context, component, isLearningThis),
      ],
    );
  }

  Widget _buildMidiBindingSection(BuildContext context, Component component, bool isLearningThis) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: NumberInput(
                label: AppLocalizations.of(context)!.channel,
                value: component.map(
                  pad: (c) => (c.midiChannel ?? 0).toDouble(),
                  knob: (c) => (c.midiChannel ?? 0).toDouble(),
                  staticImage: (_) => 0,
                ),
                min: 0,
                max: 15,
                enabled: !component.isLocked && component is! ComponentStaticImage,
                onChanged: (value) {
                  final channel = value.toInt().clamp(0, 15);
                  final updated = component.map(
                    pad: (c) => c.copyWith(midiChannel: channel),
                    knob: (c) => c.copyWith(midiChannel: channel),
                    staticImage: (c) => c,
                  );
                  context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: NumberInput(
                label: component.map(
                  pad: (_) => AppLocalizations.of(context)!.note,
                  knob: (_) => AppLocalizations.of(context)!.cc,
                  staticImage: (_) => AppLocalizations.of(context)!.na,
                ),
                value: component.map(
                  pad: (c) => (c.midiNote ?? -1).toDouble(),
                  knob: (c) => (c.midiCc ?? -1).toDouble(),
                  staticImage: (_) => -1,
                ),
                min: -1,
                max: 127,
                enabled: !component.isLocked && component is! ComponentStaticImage,
                onChanged: (value) {
                  final val = value.toInt();
                  final updated = component.map(
                    pad: (c) => c.copyWith(midiNote: val < 0 ? null : val),
                    knob: (c) => c.copyWith(midiCc: val < 0 ? null : val),
                    staticImage: (c) => c,
                  );
                  context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (component is! ComponentStaticImage) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 4),
                child: Text(
                  AppLocalizations.of(context)!.velocityThreshold(
                    component.map(
                      pad: (c) => c.velocityThreshold,
                      knob: (c) => c.velocityThreshold,
                      staticImage: (_) => 0,
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: LinearProgressIndicator(
                      value:
                          (context.read<EditorBloc>().state.activeComponentIds.contains(component.id)
                              ? _currentVelocity
                              : 0) /
                          127.0,
                      backgroundColor: Colors.grey[800],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        (context.read<EditorBloc>().state.activeComponentIds.contains(component.id)
                                    ? _currentVelocity
                                    : 0) >=
                                component.map(
                                  pad: (c) => c.velocityThreshold,
                                  knob: (c) => c.velocityThreshold,
                                  staticImage: (_) => 0,
                                )
                            ? Colors.green
                            : Colors.orange,
                      ),
                      minHeight: 10,
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                      activeTrackColor: Colors.transparent,
                      inactiveTrackColor: Colors.transparent,
                    ),
                    child: Slider(
                      value: component.map(
                        pad: (c) => c.velocityThreshold.toDouble(),
                        knob: (c) => c.velocityThreshold.toDouble(),
                        staticImage: (_) => 0,
                      ),
                      min: 0,
                      max: 127,
                      divisions: 127,
                      label: component.map(
                        pad: (c) => c.velocityThreshold.toString(),
                        knob: (c) => c.velocityThreshold.toString(),
                        staticImage: (_) => '0',
                      ),
                      onChanged: component.isLocked
                          ? null
                          : (value) {
                              final threshold = value.toInt();
                              final updated = component.map(
                                pad: (c) => c.copyWith(velocityThreshold: threshold),
                                knob: (c) => c.copyWith(velocityThreshold: threshold),
                                staticImage: (c) => c,
                              );
                              context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                            },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: component is ComponentStaticImage
                    ? null
                    : () {
                        if (_isLearning) {
                          setState(() {
                            _isLearning = false;
                            _learningComponentId = null;
                          });
                        } else {
                          setState(() {
                            _isLearning = true;
                            _learningComponentId = component.id;
                          });
                        }
                      },
                icon: Icon(
                  isLearningThis
                      ? Icons.stop
                      : (_lastBoundTime != null &&
                            DateTime.now().difference(_lastBoundTime!) < const Duration(seconds: 2) &&
                            component.map(
                              pad: (c) => c.midiNote != null,
                              knob: (c) => c.midiCc != null,
                              staticImage: (_) => false,
                            ))
                      ? Icons.check_circle
                      : Icons.radio_button_checked,
                ),
                label: Text(
                  isLearningThis
                      ? AppLocalizations.of(context)!.stopLearning
                      : (_lastBoundTime != null &&
                            DateTime.now().difference(_lastBoundTime!) < const Duration(seconds: 2) &&
                            component.map(
                              pad: (c) => c.midiNote != null,
                              knob: (c) => c.midiCc != null,
                              staticImage: (_) => false,
                            ))
                      ? AppLocalizations.of(context)!.bound
                      : AppLocalizations.of(context)!.learnMidi,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLearningThis
                      ? Colors.red
                      : (_lastBoundTime != null &&
                            DateTime.now().difference(_lastBoundTime!) < const Duration(seconds: 2) &&
                            component.map(
                              pad: (c) => c.midiNote != null,
                              knob: (c) => c.midiCc != null,
                              staticImage: (_) => false,
                            ))
                      ? Colors.green
                      : null,
                  foregroundColor:
                      isLearningThis ||
                          (_lastBoundTime != null &&
                              DateTime.now().difference(_lastBoundTime!) < const Duration(seconds: 2) &&
                              component.map(
                                pad: (c) => c.midiNote != null,
                                knob: (c) => c.midiCc != null,
                                staticImage: (_) => false,
                              ))
                      ? Colors.white
                      : null,
                ),
              ),
            ),
            if (component.map(
              pad: (c) => c.midiNote != null,
              knob: (c) => c.midiCc != null,
              staticImage: (_) => false,
            )) ...[
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.clear),
                tooltip: AppLocalizations.of(context)!.clearBinding,
                onPressed: () {
                  final updated = component.map(
                    pad: (c) => c.copyWith(midiNote: null),
                    knob: (c) => c.copyWith(midiCc: null),
                    staticImage: (c) => c,
                  );
                  context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                },
              ),
            ],
          ],
        ),
      ],
    );
  }

  List<Widget> _buildPadProperties(BuildContext context, ComponentPad pad) {
    return [
      _EnumDropdown<PadShape>(
        label: AppLocalizations.of(context)!.shape,
        value: pad.shape,
        values: PadShape.values,
        onChanged: (value) {
          if (value != null) {
            context.read<EditorBloc>().add(EditorEvent.updateComponent(pad.id, pad.copyWith(shape: value)));
          }
        },
      ),
      if (pad.shape == PadShape.rect) ...[
        const SizedBox(height: 8),
        NumberInput(
          label: AppLocalizations.of(context)!.cornerRadius,
          value: pad.cornerRadius,
          min: 0,
          onChanged: (value) {
            context.read<EditorBloc>().add(EditorEvent.updateComponent(pad.id, pad.copyWith(cornerRadius: value)));
          },
        ),
      ],
      if (pad.shape == PadShape.path) ...[
        const SizedBox(height: 8),
        Row(
          children: [
            Text(AppLocalizations.of(context)!.smoothing),
            const SizedBox(width: 8),
            Expanded(
              child: Slider(
                value: pad.smoothingAmount,
                min: 0.0,
                max: 5.0,
                onChangeStart: (_) => context.read<EditorBloc>().add(const EditorEvent.interactionStart()),
                onChangeEnd: (_) => context.read<EditorBloc>().add(const EditorEvent.interactionEnd()),
                onChanged: (value) {
                  context.read<EditorBloc>().add(
                    EditorEvent.updateComponent(pad.id, pad.copyWith(smoothingAmount: value)),
                  );
                },
              ),
            ),
            SizedBox(width: 40, child: Text(pad.smoothingAmount.toStringAsFixed(2), textAlign: TextAlign.end)),
          ],
        ),
      ],
      const SizedBox(height: 8),
      _ColorPickerField(
        label: AppLocalizations.of(context)!.onColor,
        color: pad.onColor,
        onChanged: (color) {
          context.read<EditorBloc>().add(EditorEvent.updateComponent(pad.id, pad.copyWith(onColor: color)));
        },
      ),
      const SizedBox(height: 8),
      _ColorPickerField(
        label: AppLocalizations.of(context)!.offColor,
        color: pad.offColor,
        onChanged: (color) {
          context.read<EditorBloc>().add(EditorEvent.updateComponent(pad.id, pad.copyWith(offColor: color)));
        },
      ),

      const SizedBox(height: 16),
      Row(
        children: [
          Checkbox(
            value: pad.pulseModeEnabled,
            onChanged: (value) {
              context.read<EditorBloc>().add(
                EditorEvent.updateComponent(pad.id, pad.copyWith(pulseModeEnabled: value ?? false)),
              );
            },
          ),
          Text(AppLocalizations.of(context)!.pulseMode),
        ],
      ),
      if (pad.pulseModeEnabled) ...[
        const SizedBox(height: 8),
        NumberInput(
          label: AppLocalizations.of(context)!.pulseDurationMs,
          value: pad.pulseDuration.toDouble(),
          min: 10,
          step: 10,
          onChanged: (value) {
            context.read<EditorBloc>().add(
              EditorEvent.updateComponent(pad.id, pad.copyWith(pulseDuration: value.toInt())),
            );
          },
        ),
      ],
      const SizedBox(height: 16),
      _buildEffectProperties(
        context,
        AppLocalizations.of(context)!.noteOnEffect,
        pad.onEffectConfig ?? const EffectConfig(),
        (newConfig) {
          context.read<EditorBloc>().add(EditorEvent.updateComponent(pad.id, pad.copyWith(onEffectConfig: newConfig)));
        },
      ),
      const SizedBox(height: 16),
      _buildEffectProperties(
        context,
        AppLocalizations.of(context)!.noteOffEffect,
        pad.offEffectConfig ?? const EffectConfig(),
        (newConfig) {
          context.read<EditorBloc>().add(EditorEvent.updateComponent(pad.id, pad.copyWith(offEffectConfig: newConfig)));
        },
      ),
    ];
  }

  List<Widget> _buildKnobProperties(BuildContext context, ComponentKnob knob) {
    return [
      _EnumDropdown<KnobStyle>(
        label: AppLocalizations.of(context)!.style,
        value: knob.style,
        values: KnobStyle.values,
        onChanged: (value) {
          if (value != null) {
            context.read<EditorBloc>().add(EditorEvent.updateComponent(knob.id, knob.copyWith(style: value)));
          }
        },
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: NumberInput(
              label: AppLocalizations.of(context)!.minAngle,
              value: knob.minAngle,
              onChanged: (value) {
                context.read<EditorBloc>().add(EditorEvent.updateComponent(knob.id, knob.copyWith(minAngle: value)));
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: NumberInput(
              label: AppLocalizations.of(context)!.maxAngle,
              value: knob.maxAngle,
              onChanged: (value) {
                context.read<EditorBloc>().add(EditorEvent.updateComponent(knob.id, knob.copyWith(maxAngle: value)));
              },
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      _buildEffectProperties(
        context,
        AppLocalizations.of(context)!.noteOnEffect,
        knob.onEffectConfig ?? const EffectConfig(),
        (newConfig) {
          context.read<EditorBloc>().add(
            EditorEvent.updateComponent(knob.id, knob.copyWith(onEffectConfig: newConfig)),
          );
        },
      ),
      const SizedBox(height: 16),
      _buildEffectProperties(
        context,
        AppLocalizations.of(context)!.noteOffEffect,
        knob.offEffectConfig ?? const EffectConfig(),
        (newConfig) {
          context.read<EditorBloc>().add(
            EditorEvent.updateComponent(knob.id, knob.copyWith(offEffectConfig: newConfig)),
          );
        },
      ),
    ];
  }

  Widget _buildEffectProperties(
    BuildContext context,
    String title,
    EffectConfig config,
    ValueChanged<EffectConfig> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _EnumDropdown<EffectType>(
          label: AppLocalizations.of(context)!.type,
          value: config.type,
          values: EffectType.values,
          onChanged: (value) {
            if (value != null) onChanged(config.copyWith(type: value));
          },
        ),
        if (config.type != EffectType.none) ...[
          const SizedBox(height: 8),
          NumberInput(
            label: AppLocalizations.of(context)!.durationMs,
            value: config.durationMs.toDouble(),
            min: 0,
            onChanged: (value) {
              onChanged(config.copyWith(durationMs: value.toInt()));
            },
          ),
          if (config.type == EffectType.ripple) ...[
            const SizedBox(height: 8),
            NumberInput(
              label: AppLocalizations.of(context)!.scaleMultiplier,
              value: config.scale,
              min: 1.0,
              onChanged: (value) {
                onChanged(config.copyWith(scale: value));
              },
            ),
          ],
        ],
      ],
    );
  }
}

class _PropertyField extends StatelessWidget {
  final String label;
  final String value;
  final bool enabled;
  final ValueChanged<String> onChanged;

  const _PropertyField({required this.label, required this.value, this.enabled = true, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      onChanged: onChanged,
    );
  }
}

class _ColorPickerField extends StatefulWidget {
  final String label;
  final String color;
  final ValueChanged<String> onChanged;

  const _ColorPickerField({required this.label, required this.color, required this.onChanged});

  @override
  State<_ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<_ColorPickerField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.color);
  }

  @override
  void didUpdateWidget(covariant _ColorPickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != oldWidget.color && widget.color != _controller.text) {
      _controller.text = widget.color;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: widget.label,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            onChanged: widget.onChanged,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _showColorPickerDialog(context),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _parseColor(widget.color),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }

  void _showColorPickerDialog(BuildContext context) async {
    final currentColor = _parseColor(widget.color);
    final selectedColor = await showDialog<Color>(
      context: context,
      builder: (context) => AdvancedColorPickerDialog(initialColor: currentColor),
    );

    if (selectedColor != null) {
      final hex = '#${selectedColor.value.toRadixString(16).padLeft(8, '0')}';
      widget.onChanged(hex.toUpperCase());
    }
  }

  Color _parseColor(String colorStr) {
    try {
      final buffer = StringBuffer();
      if (colorStr.length == 6 || colorStr.length == 7) buffer.write('ff');
      buffer.write(colorStr.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return Colors.black;
    }
  }
}

Widget _buildMultiSelectionProperties(BuildContext context, List<Component> components) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Text(
        AppLocalizations.of(context)!.multipleSelection,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(height: 16),
      _buildAlignmentTools(context, components),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 16),
      Text(AppLocalizations.of(context)!.properties, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      // Shared Properties
      Row(
        children: [
          Expanded(
            child: _MixedNumberInput(
              label: AppLocalizations.of(context)!.x,
              values: components.map((c) => c.x).toList(),
              onChanged: (value) {
                final updates = components.map((c) {
                  return c.map(
                    pad: (comp) => comp.copyWith(x: value),
                    knob: (comp) => comp.copyWith(x: value),
                    staticImage: (comp) => comp.copyWith(x: value),
                  );
                }).toList();
                context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _MixedNumberInput(
              label: AppLocalizations.of(context)!.y,
              values: components.map((c) => c.y).toList(),
              onChanged: (value) {
                final updates = components.map((c) {
                  return c.map(
                    pad: (comp) => comp.copyWith(y: value),
                    knob: (comp) => comp.copyWith(y: value),
                    staticImage: (comp) => comp.copyWith(y: value),
                  );
                }).toList();
                context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
              },
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: _MixedNumberInput(
              label: AppLocalizations.of(context)!.w,
              values: components.map((c) => c.width).toList(),
              onChanged: (value) {
                final updates = components.map((c) {
                  return c.map(
                    pad: (comp) => comp.copyWith(width: value),
                    knob: (comp) => comp.copyWith(width: value),
                    staticImage: (comp) => comp.copyWith(width: value),
                  );
                }).toList();
                context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _MixedNumberInput(
              label: AppLocalizations.of(context)!.h,
              values: components.map((c) => c.height).toList(),
              onChanged: (value) {
                final updates = components.map((c) {
                  return c.map(
                    pad: (comp) => comp.copyWith(height: value),
                    knob: (comp) => comp.copyWith(height: value),
                    staticImage: (comp) => comp.copyWith(height: value),
                  );
                }).toList();
                context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
              },
            ),
          ),
        ],
      ),
      if (components.any((c) => c is ComponentPad && c.shape == PadShape.rect)) ...[
        const SizedBox(height: 8),
        _MixedNumberInput(
          label: AppLocalizations.of(context)!.cornerRadius,
          values: components
              .whereType<ComponentPad>()
              .where((c) => c.shape == PadShape.rect)
              .map((c) => c.cornerRadius)
              .toList(),
          onChanged: (value) {
            final updates = components.map((c) {
              if (c is ComponentPad && c.shape == PadShape.rect) {
                return c.copyWith(cornerRadius: value);
              }
              return c;
            }).toList();
            context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
          },
        ),
      ],
      if (components.any((c) => c is ComponentPad)) ...[
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.colors, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _MixedColorPickerField(
          label: AppLocalizations.of(context)!.onColor,
          colors: components.whereType<ComponentPad>().map((c) => c.onColor).toList(),
          onChanged: (color) {
            final updates = components.map((c) {
              if (c is ComponentPad) {
                return c.copyWith(onColor: color);
              }
              return c;
            }).toList();
            context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
          },
        ),
        const SizedBox(height: 8),
        _MixedColorPickerField(
          label: AppLocalizations.of(context)!.offColor,
          colors: components.whereType<ComponentPad>().map((c) => c.offColor).toList(),
          onChanged: (color) {
            final updates = components.map((c) {
              if (c is ComponentPad) {
                return c.copyWith(offColor: color);
              }
              return c;
            }).toList();
            context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
          },
        ),
      ],
      if (components.any((c) => c is ComponentPad && c.shape == PadShape.path)) ...[
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.pathSmoothing, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Text(AppLocalizations.of(context)!.amount),
            const SizedBox(width: 8),
            Expanded(
              child: Slider(
                value: components
                    .firstWhere((c) => c is ComponentPad && c.shape == PadShape.path, orElse: () => components.first)
                    .map(pad: (c) => c.smoothingAmount, knob: (_) => 0.0, staticImage: (_) => 0.0),
                min: 0.0,
                max: 5.0,
                onChangeStart: (_) => context.read<EditorBloc>().add(const EditorEvent.interactionStart()),
                onChangeEnd: (_) => context.read<EditorBloc>().add(const EditorEvent.interactionEnd()),
                onChanged: (value) {
                  final updates = components.map((c) {
                    if (c is ComponentPad && c.shape == PadShape.path) {
                      return c.copyWith(smoothingAmount: value);
                    }
                    return c;
                  }).toList();
                  context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
                },
              ),
            ),
          ],
        ),
      ],
      if (components.any((c) => c is ComponentPad)) ...[
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.pulseMode, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Checkbox(
              value: components.whereType<ComponentPad>().every(
                (c) => c.pulseModeEnabled,
              ), // Checked only if ALL are enabled
              tristate: true, // Allow indeterminate state if mixed
              onChanged: (value) {
                final updates = components.map((c) {
                  if (c is ComponentPad) {
                    return c.copyWith(pulseModeEnabled: value ?? false);
                  }
                  return c;
                }).toList();
                context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
              },
            ),
            Text(AppLocalizations.of(context)!.enablePulseMode),
          ],
        ),
        if (components.whereType<ComponentPad>().any((c) => c.pulseModeEnabled)) ...[
          const SizedBox(height: 8),
          _MixedNumberInput(
            label: AppLocalizations.of(context)!.pulseDurationMs,
            values: components.whereType<ComponentPad>().map((c) => c.pulseDuration.toDouble()).toList(),
            onChanged: (value) {
              final updates = components.map((c) {
                if (c is ComponentPad) {
                  return c.copyWith(pulseDuration: value.toInt());
                }
                return c;
              }).toList();
              context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
            },
          ),
        ],
      ],
    ],
  );
}

Widget _buildAlignmentTools(BuildContext context, List<Component> components) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(AppLocalizations.of(context)!.alignment, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.align_horizontal_left),
            tooltip: AppLocalizations.of(context)!.alignLeft,
            onPressed: () {
              if (components.isEmpty) return;
              final minX = components.map((c) => c.x).reduce((a, b) => a < b ? a : b);
              final updates = components.map((c) {
                return c.map(
                  pad: (comp) => comp.copyWith(x: minX),
                  knob: (comp) => comp.copyWith(x: minX),
                  staticImage: (comp) => comp.copyWith(x: minX),
                );
              }).toList();
              context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
            },
          ),
          IconButton(
            icon: const Icon(Icons.align_horizontal_center),
            tooltip: AppLocalizations.of(context)!.alignCenter,
            onPressed: () {
              if (components.isEmpty) return;
              // Center relative to selection bounding box
              final minX = components.map((c) => c.x).reduce((a, b) => a < b ? a : b);
              final maxX = components.map((c) => c.x + c.width).reduce((a, b) => a > b ? a : b);
              final centerX = (minX + maxX) / 2;

              final updates = components.map((c) {
                final newX = centerX - (c.width / 2);
                return c.map(
                  pad: (comp) => comp.copyWith(x: newX),
                  knob: (comp) => comp.copyWith(x: newX),
                  staticImage: (comp) => comp.copyWith(x: newX),
                );
              }).toList();
              context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
            },
          ),
          IconButton(
            icon: const Icon(Icons.align_horizontal_right),
            tooltip: AppLocalizations.of(context)!.alignRight,
            onPressed: () {
              if (components.isEmpty) return;
              final maxX = components.map((c) => c.x + c.width).reduce((a, b) => a > b ? a : b);
              final updates = components.map((c) {
                final newX = maxX - c.width;
                return c.map(
                  pad: (comp) => comp.copyWith(x: newX),
                  knob: (comp) => comp.copyWith(x: newX),
                  staticImage: (comp) => comp.copyWith(x: newX),
                );
              }).toList();
              context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
            },
          ),
        ],
      ),
      const SizedBox(height: 4),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.align_vertical_top),
            tooltip: AppLocalizations.of(context)!.alignTop,
            onPressed: () {
              if (components.isEmpty) return;
              final minY = components.map((c) => c.y).reduce((a, b) => a < b ? a : b);
              final updates = components.map((c) {
                return c.map(
                  pad: (comp) => comp.copyWith(y: minY),
                  knob: (comp) => comp.copyWith(y: minY),
                  staticImage: (comp) => comp.copyWith(y: minY),
                );
              }).toList();
              context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
            },
          ),
          IconButton(
            icon: const Icon(Icons.align_vertical_center),
            tooltip: AppLocalizations.of(context)!.alignMiddle,
            onPressed: () {
              if (components.isEmpty) return;
              final minY = components.map((c) => c.y).reduce((a, b) => a < b ? a : b);
              final maxY = components.map((c) => c.y + c.height).reduce((a, b) => a > b ? a : b);
              final centerY = (minY + maxY) / 2;

              final updates = components.map((c) {
                final newY = centerY - (c.height / 2);
                return c.map(
                  pad: (comp) => comp.copyWith(y: newY),
                  knob: (comp) => comp.copyWith(y: newY),
                  staticImage: (comp) => comp.copyWith(y: newY),
                );
              }).toList();
              context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
            },
          ),
          IconButton(
            icon: const Icon(Icons.align_vertical_bottom),
            tooltip: AppLocalizations.of(context)!.alignBottom,
            onPressed: () {
              if (components.isEmpty) return;
              final maxY = components.map((c) => c.y + c.height).reduce((a, b) => a > b ? a : b);
              final updates = components.map((c) {
                final newY = maxY - c.height;
                return c.map(
                  pad: (comp) => comp.copyWith(y: newY),
                  knob: (comp) => comp.copyWith(y: newY),
                  staticImage: (comp) => comp.copyWith(y: newY),
                );
              }).toList();
              context.read<EditorBloc>().add(EditorEvent.updateComponents(updates));
            },
          ),
        ],
      ),
    ],
  );
}

class _MixedNumberInput extends StatelessWidget {
  final String label;
  final List<double> values;
  final ValueChanged<double> onChanged;

  const _MixedNumberInput({required this.label, required this.values, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final firstValue = values.isNotEmpty ? values.first : 0.0;
    final allSame = values.every((v) => v == firstValue);

    return NumberInput(
      label: label,
      value: allSame ? firstValue : 0, // 0 as placeholder if mixed, but we should probably handle display differently
      // Since NumberInput might not support "Mixed" text, we might need to modify NumberInput or use a controller.
      // For now, if mixed, we show the first value but maybe with a different color or indicator?
      // Or we can just pass the first value and let user overwrite.
      // Ideally NumberInput should support a "hint" or "placeholder" for mixed values.
      // But let's stick to simple behavior: show first value if mixed.
      onChanged: onChanged,
    );
  }
}

class _MixedColorPickerField extends StatelessWidget {
  final String label;
  final List<String> colors;
  final ValueChanged<String> onChanged;

  const _MixedColorPickerField({required this.label, required this.colors, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final firstColor = colors.isNotEmpty ? colors.first : '#FFFFFF';
    // We could check if all are same, but for color picker, usually we just show one and let user overwrite

    return _ColorPickerField(label: label, color: firstColor, onChanged: onChanged);
  }
}

class _EnumDropdown<T extends Enum> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> values;
  final ValueChanged<T?> onChanged;

  const _EnumDropdown({required this.label, required this.value, required this.values, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      items: values.map((e) {
        return DropdownMenuItem<T>(value: e, child: Text(e.name));
      }).toList(),
      onChanged: onChanged,
    );
  }
}
