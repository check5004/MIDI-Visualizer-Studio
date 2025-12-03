import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/features/common/ui/advanced_color_picker_dialog.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/number_input.dart';
import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';

class InspectorPanel extends StatefulWidget {
  const InspectorPanel({super.key});

  @override
  State<InspectorPanel> createState() => _InspectorPanelState();
}

class _InspectorPanelState extends State<InspectorPanel> {
  bool _isLearning = false;
  String? _learningComponentId;
  int _currentVelocity = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MidiBloc, MidiState>(
      listenWhen: (previous, current) => current.lastPacket != null && current.lastPacket != previous.lastPacket,
      listener: (context, midiState) {
        final packet = midiState.lastPacket!;
        if (packet.data.isEmpty) return;

        final status = packet.data[0] & 0xF0;
        final channel = packet.data[0] & 0x0F;
        final data1 = packet.data.length > 1 ? packet.data[1] : 0;
        final data2 = packet.data.length > 2 ? packet.data[2] : 0;

        if (_isLearning) {
          if (_learningComponentId == null) return;

          bool bound = false;
          if (status == 0x90 || status == 0x80) {
            // Note On/Off
            _bindMidi(_learningComponentId!, channel, note: data1);
            bound = true;
          } else if (status == 0xB0) {
            // CC
            _bindMidi(_learningComponentId!, channel, cc: data1);
            bound = true;
          }

          if (bound) {
            setState(() {
              _isLearning = false;
              _learningComponentId = null;
            });

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('MIDI Bound!')));
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
                if (channel == targetChannel && data1 == targetNote) {
                  if (status == 0x90 && data2 > 0) {
                    setState(() => _currentVelocity = data2);
                  } else if (status == 0x80 || (status == 0x90 && data2 == 0)) {
                    setState(() => _currentVelocity = 0);
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
              return const Center(child: Text('No Project Selected'));
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
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Select a component to edit its properties.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildComponentProperties(BuildContext context, Component component) {
    final isLearningThis = _isLearning && _learningComponentId == component.id;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Properties', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        _PropertyField(
          label: 'Name',
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
                label: 'X',
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
                label: 'Y',
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
                label: 'W',
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
                label: 'H',
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
                  tooltip: 'Lock Aspect Ratio',
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

        const Text('Type Specific', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...component.map(
          pad: (c) => _buildPadProperties(context, c),
          knob: (c) => _buildKnobProperties(context, c),
          staticImage: (c) => [],
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        const Text('MIDI Binding', style: TextStyle(fontWeight: FontWeight.bold)),
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
                label: 'Channel',
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
                label: component.map(pad: (_) => 'Note', knob: (_) => 'CC', staticImage: (_) => 'N/A'),
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
                  'Velocity Threshold: ${component.map(pad: (c) => c.velocityThreshold, knob: (c) => c.velocityThreshold, staticImage: (_) => 0)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: LinearProgressIndicator(
                      value: _currentVelocity / 127.0,
                      backgroundColor: Colors.grey[800],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _currentVelocity >=
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
                icon: Icon(isLearningThis ? Icons.stop : Icons.radio_button_checked),
                label: Text(isLearningThis ? 'Stop Learning' : 'Learn MIDI'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLearningThis ? Colors.red : null,
                  foregroundColor: isLearningThis ? Colors.white : null,
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
                tooltip: 'Clear Binding',
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
        label: 'Shape',
        value: pad.shape,
        values: PadShape.values,
        onChanged: (value) {
          if (value != null) {
            context.read<EditorBloc>().add(EditorEvent.updateComponent(pad.id, pad.copyWith(shape: value)));
          }
        },
      ),
      if (pad.shape == PadShape.path) ...[
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Smoothing'),
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
        label: 'On Color',
        color: pad.onColor,
        onChanged: (color) {
          context.read<EditorBloc>().add(EditorEvent.updateComponent(pad.id, pad.copyWith(onColor: color)));
        },
      ),
      const SizedBox(height: 8),
      _ColorPickerField(
        label: 'Off Color',
        color: pad.offColor,
        onChanged: (color) {
          context.read<EditorBloc>().add(EditorEvent.updateComponent(pad.id, pad.copyWith(offColor: color)));
        },
      ),
    ];
  }

  List<Widget> _buildKnobProperties(BuildContext context, ComponentKnob knob) {
    return [
      _EnumDropdown<KnobStyle>(
        label: 'Style',
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
              label: 'Min Angle',
              value: knob.minAngle,
              onChanged: (value) {
                context.read<EditorBloc>().add(EditorEvent.updateComponent(knob.id, knob.copyWith(minAngle: value)));
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: NumberInput(
              label: 'Max Angle',
              value: knob.maxAngle,
              onChanged: (value) {
                context.read<EditorBloc>().add(EditorEvent.updateComponent(knob.id, knob.copyWith(maxAngle: value)));
              },
            ),
          ),
        ],
      ),
    ];
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
      const Text('Multiple Selection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 16),
      _buildAlignmentTools(context, components),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 16),
      const Text('Properties', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      // Shared Properties
      Row(
        children: [
          Expanded(
            child: _MixedNumberInput(
              label: 'X',
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
              label: 'Y',
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
              label: 'W',
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
              label: 'H',
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
      if (components.any((c) => c is ComponentPad && c.shape == PadShape.path)) ...[
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),
        const Text('Path Smoothing', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            const Text('Amount'),
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
    ],
  );
}

Widget _buildAlignmentTools(BuildContext context, List<Component> components) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Alignment', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.align_horizontal_left),
            tooltip: 'Align Left',
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
            tooltip: 'Align Center',
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
            tooltip: 'Align Right',
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
            tooltip: 'Align Top',
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
            tooltip: 'Align Middle',
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
            tooltip: 'Align Bottom',
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
