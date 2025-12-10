import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:midi_visualizer_studio/data/models/shortcut_config.dart';

import 'package:midi_visualizer_studio/features/settings/bloc/settings_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_event.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';
import 'package:midi_visualizer_studio/features/settings/ui/parts/settings_card.dart';
import 'package:midi_visualizer_studio/features/midi/ui/parts/midi_device_list.dart';
import 'package:midi_visualizer_studio/features/common/ui/advanced_color_picker_dialog.dart';
import 'package:midi_visualizer_studio/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settingsTitle)),
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
      title: AppLocalizations.of(context)!.general,
      children: [
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            final isDark = state.themeMode == ThemeMode.dark;

            return Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(AppLocalizations.of(context)!.language),
                  trailing: DropdownButton<Locale>(
                    value: state.locale,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: Locale('en'), child: Text('English')),
                      DropdownMenuItem(value: Locale('ja'), child: Text('日本語')),
                    ],
                    onChanged: (Locale? newLocale) {
                      if (newLocale != null) {
                        context.read<SettingsBloc>().add(SettingsEvent.updateLocale(newLocale));
                      }
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: Text(AppLocalizations.of(context)!.darkMode),
                  trailing: Switch(
                    value: isDark,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                        SettingsEvent.toggleTheme(value ? ThemeMode.dark : ThemeMode.light),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        const Divider(),
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return ListTile(
              title: Text(AppLocalizations.of(context)!.editorBackground),
              trailing: GestureDetector(
                onTap: () async {
                  final color = Color(state.editorBackgroundColor);
                  final selectedColor = await showDialog<Color>(
                    context: context,
                    builder: (context) => AdvancedColorPickerDialog(initialColor: color),
                  );
                  if (selectedColor != null) {
                    context.read<SettingsBloc>().add(SettingsEvent.updateEditorBackgroundColor(selectedColor.value));
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(state.editorBackgroundColor),
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info),
          title: Text(AppLocalizations.of(context)!.version),
          trailing: const Text('1.0.0'),
        ),
        ListTile(
          leading: const Icon(Icons.description),
          title: Text(AppLocalizations.of(context)!.licenses),
          onTap: () => showLicensePage(context: context),
        ),
        const Divider(),
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return ListTile(
              leading: const Icon(Icons.preview),
              title: Text(AppLocalizations.of(context)!.launchInPreviewMode),
              subtitle: Text(AppLocalizations.of(context)!.launchInPreviewModeDescription),
              trailing: Switch(
                value: state.shouldLaunchInPreview,
                onChanged: (value) {
                  context.read<SettingsBloc>().add(SettingsEvent.toggleLaunchInPreview(value));
                },
              ),
            );
          },
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
      title: AppLocalizations.of(context)!.midi,
      children: [SizedBox(height: 300, child: const MidiDeviceList())],
    );
  }
}

class _StreamingSettingsSection extends StatelessWidget {
  const _StreamingSettingsSection();

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      title: AppLocalizations.of(context)!.streaming,
      children: [
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Column(
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context)!.chromaKeyDefaults),
                  subtitle: Text(AppLocalizations.of(context)!.chromaKeyDefaultsDescription),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.defaultColor),
                  trailing: GestureDetector(
                    onTap: () async {
                      final color = Color(state.defaultChromaKeyColor);
                      final selectedColor = await showDialog<Color>(
                        context: context,
                        builder: (context) => AdvancedColorPickerDialog(initialColor: color),
                      );
                      if (selectedColor != null) {
                        context.read<SettingsBloc>().add(SettingsEvent.updateChromaKeyColor(selectedColor.value));
                      }
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(state.defaultChromaKeyColor),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.windowlessMode),
                  subtitle: Text(AppLocalizations.of(context)!.windowlessModeDescription),
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
      title: AppLocalizations.of(context)!.shortcuts,
      children: [
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            final shortcuts = state.shortcuts;
            final sortedKeys = shortcuts.keys.toList()..sort();

            return Column(
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context)!.resetToDefaults),
                  leading: const Icon(Icons.restore),
                  onTap: () {
                    context.read<SettingsBloc>().add(const SettingsEvent.resetShortcuts());
                  },
                ),
                const Divider(),
                if (sortedKeys.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(AppLocalizations.of(context)!.noShortcutsConfigured),
                  )
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
            _isRecording ? AppLocalizations.of(context)!.pressKeys : widget.config.label,
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
