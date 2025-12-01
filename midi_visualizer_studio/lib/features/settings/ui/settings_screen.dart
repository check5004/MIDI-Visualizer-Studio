import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:midi_visualizer_studio/data/models/shortcut_config.dart';
import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_event.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';
import 'package:midi_visualizer_studio/features/settings/ui/parts/settings_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          int crossAxisCount;
          if (width < 600) {
            crossAxisCount = 1;
          } else if (width < 1000) {
            crossAxisCount = 2;
          } else {
            crossAxisCount = 3;
          }

          final sections = [
            const _GeneralSettingsSection(),
            const _MidiSettingsSection(),
            const _StreamingSettingsSection(),
            const _ShortcutsSettingsSection(),
          ];

          final columns = List.generate(crossAxisCount, (_) => <Widget>[]);
          for (var i = 0; i < sections.length; i++) {
            columns[i % crossAxisCount].add(sections[i]);
          }

          if (crossAxisCount == 1) {
            return ListView(padding: const EdgeInsets.all(16), children: sections);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < crossAxisCount; i++) ...[
                  if (i > 0) const SizedBox(width: 16),
                  Expanded(child: Column(children: columns[i])),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GeneralSettingsSection extends StatelessWidget {
  const _GeneralSettingsSection();

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      title: 'General',
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

class _MidiSettingsSection extends StatelessWidget {
  const _MidiSettingsSection();

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      title: 'MIDI',
      children: [
        BlocBuilder<MidiBloc, MidiState>(
          builder: (context, state) {
            return Column(
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
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: LinearProgressIndicator()),
                  )
                else if (state.devices.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: Text('No MIDI devices found')),
                  )
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
        ),
      ],
    );
  }
}

class _StreamingSettingsSection extends StatelessWidget {
  const _StreamingSettingsSection();

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      title: 'Streaming',
      children: [
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            final colors = [
              0xFF00FF00, // Green
              0xFF0000FF, // Blue
              0xFFFF00FF, // Magenta
              0xFF000000, // Black
              0xFFFFFFFF, // White
            ];

            return Column(
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
        ),
      ],
    );
  }
}

class _ShortcutsSettingsSection extends StatelessWidget {
  const _ShortcutsSettingsSection();

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      title: 'Shortcuts',
      children: [
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            final shortcuts = state.shortcuts;
            final sortedKeys = shortcuts.keys.toList()..sort();

            return Column(
              children: [
                ListTile(
                  title: const Text('Reset to Defaults'),
                  leading: const Icon(Icons.restore),
                  onTap: () {
                    context.read<SettingsBloc>().add(const SettingsEvent.resetShortcuts());
                  },
                ),
                const Divider(),
                if (sortedKeys.isEmpty)
                  const Padding(padding: EdgeInsets.all(16.0), child: Text('No shortcuts configured'))
                else
                  ...sortedKeys.map((actionId) {
                    final config = shortcuts[actionId]!;
                    return ListTile(
                      title: Text(actionId.toUpperCase()),
                      trailing: _ShortcutRecorder(
                        config: config,
                        onChanged: (newConfig) {
                          context.read<SettingsBloc>().add(SettingsEvent.updateShortcut(actionId, newConfig));
                        },
                      ),
                    );
                  }),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ShortcutRecorder extends StatefulWidget {
  final ShortcutConfig config;
  final ValueChanged<ShortcutConfig> onChanged;

  const _ShortcutRecorder({required this.config, required this.onChanged});

  @override
  State<_ShortcutRecorder> createState() => _ShortcutRecorderState();
}

class _ShortcutRecorderState extends State<_ShortcutRecorder> {
  bool _isRecording = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        if (!_isRecording) return KeyEventResult.ignored;
        if (event is! KeyDownEvent) return KeyEventResult.handled;

        final key = event.logicalKey;
        if (key == LogicalKeyboardKey.escape) {
          setState(() => _isRecording = false);
          return KeyEventResult.handled;
        }

        // Ignore modifier-only presses for final config, but consume them
        if (key == LogicalKeyboardKey.controlLeft ||
            key == LogicalKeyboardKey.controlRight ||
            key == LogicalKeyboardKey.metaLeft ||
            key == LogicalKeyboardKey.metaRight ||
            key == LogicalKeyboardKey.altLeft ||
            key == LogicalKeyboardKey.altRight ||
            key == LogicalKeyboardKey.shiftLeft ||
            key == LogicalKeyboardKey.shiftRight) {
          return KeyEventResult.handled;
        }

        final newConfig = ShortcutConfig(
          keyId: key.keyId,
          isControl: HardwareKeyboard.instance.isControlPressed,
          isMeta: HardwareKeyboard.instance.isMetaPressed,
          isAlt: HardwareKeyboard.instance.isAltPressed,
          isShift: HardwareKeyboard.instance.isShiftPressed,
        );

        widget.onChanged(newConfig);
        setState(() => _isRecording = false);
        return KeyEventResult.handled;
      },
      child: GestureDetector(
        onTap: () {
          setState(() => _isRecording = true);
          _focusNode.requestFocus();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _isRecording
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: _isRecording ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2) : null,
          ),
          child: Text(
            _isRecording ? 'Press keys...' : widget.config.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isRecording
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
