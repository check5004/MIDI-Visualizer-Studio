import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:midi_visualizer_studio/data/models/shortcut_config.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(ThemeMode.light) ThemeMode themeMode,
    @Default(0xFF00FF00) int defaultChromaKeyColor, // Default to Green
    @Default(false) bool isWindowless,
    @Default({}) Map<String, ShortcutConfig> shortcuts,
  }) = _SettingsState;
}
