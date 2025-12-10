import 'package:flutter/material.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/number_input.dart';
import 'package:midi_visualizer_studio/l10n/app_localizations.dart';

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
      title: Text(AppLocalizations.of(context)!.createPadGrid),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NumberInput(
            label: AppLocalizations.of(context)!.rows,
            value: _rows.toDouble(),
            min: 1,
            max: 16,
            onChanged: (value) => setState(() => _rows = value.toInt()),
          ),
          const SizedBox(height: 16),
          NumberInput(
            label: AppLocalizations.of(context)!.columns,
            value: _cols.toDouble(),
            min: 1,
            max: 16,
            onChanged: (value) => setState(() => _cols = value.toInt()),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.cancel)),
        FilledButton(onPressed: _submit, child: Text(AppLocalizations.of(context)!.create)),
      ],
    );
  }
}
