import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:midi_visualizer_studio/data/models/shortcut_config.dart';

part 'settings_event.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.loadSettings() = LoadSettings;
  const factory SettingsEvent.toggleTheme(ThemeMode mode) = ToggleTheme;
  const factory SettingsEvent.updateChromaKeyColor(int color) = UpdateChromaKeyColor;
  const factory SettingsEvent.updateEditorBackgroundColor(int color) = UpdateEditorBackgroundColor;
  const factory SettingsEvent.toggleWindowless(bool isWindowless) = ToggleWindowless;
  const factory SettingsEvent.toggleLaunchInPreview(bool enabled) = ToggleLaunchInPreview;
  const factory SettingsEvent.updateLocale(Locale locale) = UpdateLocale;
  const factory SettingsEvent.updateShortcut(String actionId, ShortcutConfig config) = UpdateShortcut;
  const factory SettingsEvent.resetShortcuts() = ResetShortcuts;
}
