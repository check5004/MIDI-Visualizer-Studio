import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_event.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'General', icon: Icon(Icons.settings)),
              Tab(text: 'MIDI', icon: Icon(Icons.piano)),
              Tab(text: 'Streaming', icon: Icon(Icons.videocam)),
            ],
          ),
        ),
        body: const TabBarView(children: [_GeneralSettingsTab(), _MidiSettingsTab(), _StreamingSettingsTab()]),
      ),
    );
  }
}

class _GeneralSettingsTab extends StatelessWidget {
  const _GeneralSettingsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            final isDark = state.themeMode == ThemeMode.dark;
            return ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: isDark,
                onChanged: (value) {
                  context.read<SettingsBloc>().add(SettingsEvent.toggleTheme(value ? ThemeMode.dark : ThemeMode.light));
                },
              ),
            );
          },
        ),
        const Divider(),
        const ListTile(leading: Icon(Icons.info), title: Text('Version'), trailing: Text('1.0.0')),
        ListTile(
          leading: const Icon(Icons.description),
          title: const Text('Licenses'),
          onTap: () => showLicensePage(context: context),
        ),
      ],
    );
  }
}

class _MidiSettingsTab extends StatelessWidget {
  const _MidiSettingsTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MidiBloc, MidiState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              title: const Text('MIDI Devices'),
              trailing: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<MidiBloc>().add(const MidiEvent.scanDevices());
                },
              ),
            ),
            if (state.status == MidiStatus.scanning)
              const Center(child: LinearProgressIndicator())
            else if (state.devices.isEmpty)
              const Center(child: Text('No MIDI devices found'))
            else
              ...state.devices.map((device) {
                final isConnected = state.connectedDevice?.id == device.id;
                return ListTile(
                  leading: const Icon(Icons.usb),
                  title: Text(device.name),
                  subtitle: Text(device.type),
                  trailing: ElevatedButton(
                    onPressed: () {
                      if (isConnected) {
                        context.read<MidiBloc>().add(MidiEvent.disconnectDevice(device));
                      } else {
                        context.read<MidiBloc>().add(MidiEvent.connectDevice(device));
                      }
                    },
                    child: Text(isConnected ? 'Disconnect' : 'Connect'),
                  ),
                );
              }),
          ],
        );
      },
    );
  }
}

class _StreamingSettingsTab extends StatelessWidget {
  const _StreamingSettingsTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final colors = [
          0xFF00FF00, // Green
          0xFF0000FF, // Blue
          0xFFFF00FF, // Magenta
          0xFF000000, // Black
          0xFFFFFFFF, // White
        ];

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ListTile(
              title: Text('Chroma Key Defaults'),
              subtitle: Text('Set the default background color for new projects.'),
            ),
            ListTile(
              title: const Text('Default Color'),
              subtitle: Wrap(
                spacing: 8,
                children: colors.map((color) {
                  final isSelected = state.defaultChromaKeyColor == color;
                  return GestureDetector(
                    onTap: () {
                      context.read<SettingsBloc>().add(SettingsEvent.updateChromaKeyColor(color));
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(color),
                        border: isSelected
                            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 3)
                            : Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Windowless Mode'),
              subtitle: const Text('Hide window title bar and frame (for OBS capturing).'),
              trailing: Switch(
                value: state.isWindowless,
                onChanged: (value) {
                  context.read<SettingsBloc>().add(SettingsEvent.toggleWindowless(value));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
