import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/component.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';

class InspectorPanel extends StatelessWidget {
  const InspectorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[200],
      child: BlocBuilder<EditorBloc, EditorState>(
        builder: (context, state) {
          final selectedIds = state.selectedComponentIds;
          final project = state.project;

          if (project == null || selectedIds.isEmpty) {
            return const Center(child: Text('No Selection'));
          }

          if (selectedIds.length > 1) {
            return const Center(child: Text('Multiple Selection'));
          }

          final selectedId = selectedIds.first;
          final component = project.layers.firstWhere(
            (c) => c.id == selectedId,
            orElse: () => throw Exception('Selected component not found'),
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Properties', style: TextStyle(fontWeight: FontWeight.bold)),
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
            ],
          );
        },
      ),
    );
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
