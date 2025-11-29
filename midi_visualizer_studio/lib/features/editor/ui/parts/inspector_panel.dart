import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<MidiBloc, MidiState>(
      listenWhen: (previous, current) =>
          _isLearning && current.lastPacket != null && current.lastPacket != previous.lastPacket,
      listener: (context, midiState) {
        if (_learningComponentId == null) return;

        final packet = midiState.lastPacket!;
        // Assuming Note On/Off or CC
        // Packet data: [status, data1, data2]
        // Status: 0x9n (Note On), 0x8n (Note Off), 0xBn (CC)
        // n = channel (0-15)

        if (packet.data.isEmpty) return;

        final status = packet.data[0] & 0xF0;
        final channel = packet.data[0] & 0x0F;
        final data1 = packet.data.length > 1 ? packet.data[1] : 0;

        if (status == 0x90 || status == 0x80) {
          // Note On/Off
          _bindMidi(_learningComponentId!, channel, note: data1);
        } else if (status == 0xB0) {
          // CC
          _bindMidi(_learningComponentId!, channel, cc: data1);
        }

        setState(() {
          _isLearning = false;
          _learningComponentId = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('MIDI Bound!')));
      },
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: BlocBuilder<EditorBloc, EditorState>(
          builder: (context, state) {
            final selectedIds = state.selectedComponentIds;
            final project = state.project;

            if (state.status == EditorStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (project == null) {
              return const Center(child: Text('No Project Selected'));
            }

            if (selectedIds.isEmpty) {
              return _buildProjectSettings(context, project);
            }

            if (selectedIds.length > 1) {
              return const Center(child: Text('Multiple Selection'));
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
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Project Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        _PropertyField(
          label: 'Name',
          value: project.name,
          onChanged: (value) {
            context.read<EditorBloc>().add(EditorEvent.updateProjectSettings(project.copyWith(name: value)));
          },
        ),
        const SizedBox(height: 16),
        const Text('Canvas Size', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: NumberInput(
                label: 'Width',
                value: project.canvasWidth,
                step: 10,
                onChanged: (value) {
                  context.read<EditorBloc>().add(
                    EditorEvent.updateProjectSettings(project.copyWith(canvasWidth: value)),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: NumberInput(
                label: 'Height',
                value: project.canvasHeight,
                step: 10,
                onChanged: (value) {
                  context.read<EditorBloc>().add(
                    EditorEvent.updateProjectSettings(project.copyWith(canvasHeight: value)),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Background', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ListTile(
          title: const Text('Color'),
          subtitle: Text(project.backgroundColor),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _parseColor(project.backgroundColor),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onTap: () => _showColorPicker(context, project),
        ),
      ],
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
                  final updated = component.map(
                    pad: (c) => c.copyWith(width: value),
                    knob: (c) => c.copyWith(width: value),
                    staticImage: (c) => c.copyWith(width: value),
                  );
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
                  final updated = component.map(
                    pad: (c) => c.copyWith(height: value),
                    knob: (c) => c.copyWith(height: value),
                    staticImage: (c) => c.copyWith(height: value),
                  );
                  context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
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

  void _showColorPicker(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Select Background Color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Transparent'),
              leading: const Icon(Icons.grid_on),
              onTap: () {
                context.read<EditorBloc>().add(
                  EditorEvent.updateProjectSettings(project.copyWith(backgroundColor: '#00000000')),
                );
                Navigator.pop(dialogContext);
              },
            ),
            ListTile(
              title: const Text('Green Screen'),
              leading: const Icon(Icons.circle, color: Colors.green),
              onTap: () {
                context.read<EditorBloc>().add(
                  EditorEvent.updateProjectSettings(project.copyWith(backgroundColor: '#00FF00')),
                );
                Navigator.pop(dialogContext);
              },
            ),
            ListTile(
              title: const Text('Blue Screen'),
              leading: const Icon(Icons.circle, color: Colors.blue),
              onTap: () {
                context.read<EditorBloc>().add(
                  EditorEvent.updateProjectSettings(project.copyWith(backgroundColor: '#0000FF')),
                );
                Navigator.pop(dialogContext);
              },
            ),
            ListTile(
              title: const Text('Black'),
              leading: const Icon(Icons.circle, color: Colors.black),
              onTap: () {
                context.read<EditorBloc>().add(
                  EditorEvent.updateProjectSettings(project.copyWith(backgroundColor: '#000000')),
                );
                Navigator.pop(dialogContext);
              },
            ),
            ListTile(
              title: const Text('White'),
              leading: const Icon(Icons.circle, color: Colors.white),
              onTap: () {
                context.read<EditorBloc>().add(
                  EditorEvent.updateProjectSettings(project.copyWith(backgroundColor: '#FFFFFF')),
                );
                Navigator.pop(dialogContext);
              },
            ),
          ],
        ),
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
      return Colors.white;
    }
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

class _ColorPickerField extends StatelessWidget {
  final String label;
  final String color;
  final ValueChanged<String> onChanged;

  const _ColorPickerField({required this.label, required this.color, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: color,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _showColorPickerDialog(context),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _parseColor(color),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }

  void _showColorPickerDialog(BuildContext context) {
    // Simple preset picker for now
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Select $label'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.purple,
                Colors.orange,
                Colors.black,
                Colors.white,
                Colors.grey,
              ].map((c) {
                return GestureDetector(
                  onTap: () {
                    // Convert Color to Hex
                    final hex = '#${c.value.toRadixString(16).padLeft(8, '0').substring(2)}';
                    onChanged(hex.toUpperCase());
                    Navigator.pop(dialogContext);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: c,
                      border: Border.all(color: Colors.grey),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList(),
        ),
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
      return Colors.white;
    }
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
