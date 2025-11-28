import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
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
        width: 300,
        color: Colors.grey[200],
        child: BlocBuilder<EditorBloc, EditorState>(
          builder: (context, state) {
            final selectedIds = state.selectedComponentIds;
            final project = state.project;

            if (project == null) {
              return const Center(child: CircularProgressIndicator());
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
              child: _NumberField(
                label: 'Width',
                value: project.canvasWidth,
                onChanged: (value) {
                  context.read<EditorBloc>().add(
                    EditorEvent.updateProjectSettings(project.copyWith(canvasWidth: value)),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _NumberField(
                label: 'Height',
                value: project.canvasHeight,
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
          onChanged: (value) {
            final updated = component.map(
              pad: (c) => c.copyWith(name: value),
              knob: (c) => c.copyWith(name: value),
            );
            context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
          },
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _NumberField(
                label: 'X',
                value: component.x,
                onChanged: (value) {
                  final updated = component.map(
                    pad: (c) => c.copyWith(x: value),
                    knob: (c) => c.copyWith(x: value),
                  );
                  context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _NumberField(
                label: 'Y',
                value: component.y,
                onChanged: (value) {
                  final updated = component.map(
                    pad: (c) => c.copyWith(y: value),
                    knob: (c) => c.copyWith(y: value),
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
              child: _NumberField(
                label: 'W',
                value: component.width,
                onChanged: (value) {
                  final updated = component.map(
                    pad: (c) => c.copyWith(width: value),
                    knob: (c) => c.copyWith(width: value),
                  );
                  context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _NumberField(
                label: 'H',
                value: component.height,
                onChanged: (value) {
                  final updated = component.map(
                    pad: (c) => c.copyWith(height: value),
                    knob: (c) => c.copyWith(height: value),
                  );
                  context.read<EditorBloc>().add(EditorEvent.updateComponent(component.id, updated));
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('MIDI Binding', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ListTile(
          leading: Icon(Icons.input, color: isLearningThis ? Colors.red : null),
          title: Text(isLearningThis ? 'Press MIDI Control...' : 'Click to Learn'),
          subtitle: Text(
            component.map(
              pad: (c) => c.midiNote != null ? 'CH:${c.midiChannel} Note:${c.midiNote}' : 'Not bound',
              knob: (c) => c.midiCc != null ? 'CH:${c.midiChannel} CC:${c.midiCc}' : 'Not bound',
            ),
          ),
          tileColor: isLearningThis ? Colors.red.withOpacity(0.1) : null,
          onTap: () {
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
        ),
      ],
    );
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
  final ValueChanged<String> onChanged;

  const _PropertyField({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      onChanged: onChanged,
    );
  }
}

class _NumberField extends StatelessWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const _NumberField({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      onChanged: (val) {
        final num = double.tryParse(val);
        if (num != null) {
          onChanged(num);
        }
      },
    );
  }
}
