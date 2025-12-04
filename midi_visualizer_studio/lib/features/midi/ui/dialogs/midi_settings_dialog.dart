import 'package:flutter/material.dart';
import 'package:midi_visualizer_studio/features/midi/ui/parts/midi_device_list.dart';

class MidiSettingsDialog extends StatelessWidget {
  const MidiSettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 500),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('MIDI Settings', style: Theme.of(context).textTheme.headlineSmall),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
                ],
              ),
              const Divider(),
              const Expanded(child: MidiDeviceList()),
            ],
          ),
        ),
      ),
    );
  }
}
