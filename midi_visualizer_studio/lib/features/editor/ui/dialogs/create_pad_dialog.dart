import 'package:flutter/material.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/number_input.dart';

class CreatePadDialog extends StatefulWidget {
  const CreatePadDialog({super.key});

  @override
  State<CreatePadDialog> createState() => _CreatePadDialogState();
}

class _CreatePadDialogState extends State<CreatePadDialog> {
  int _rows = 4;
  int _cols = 4;

  void _submit() {
    Navigator.of(context).pop({'rows': _rows, 'cols': _cols});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create PAD Grid'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NumberInput(
            label: 'Rows',
            value: _rows.toDouble(),
            min: 1,
            max: 16,
            onChanged: (value) => setState(() => _rows = value.toInt()),
          ),
          const SizedBox(height: 16),
          NumberInput(
            label: 'Columns',
            value: _cols.toDouble(),
            min: 1,
            max: 16,
            onChanged: (value) => setState(() => _cols = value.toInt()),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        FilledButton(onPressed: _submit, child: const Text('Create')),
      ],
    );
  }
}
