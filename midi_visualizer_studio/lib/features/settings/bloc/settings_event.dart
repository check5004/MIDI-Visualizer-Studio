import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.loadSettings() = LoadSettings;
  const factory SettingsEvent.toggleTheme(ThemeMode mode) = ToggleTheme;
  const factory SettingsEvent.updateChromaKeyColor(int color) = UpdateChromaKeyColor;
  const factory SettingsEvent.toggleWindowless(bool isWindowless) = ToggleWindowless;
}
