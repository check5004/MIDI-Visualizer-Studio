import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:midi_visualizer_studio/data/models/shortcut_config.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(0xFF00FF00) int defaultChromaKeyColor,
    @Default(0xFF1E1E1E) int editorBackgroundColor, // Default to dark grey
    @Default(false) bool isWindowless,
    @Default({}) Map<String, ShortcutConfig> shortcuts,
  }) = _SettingsState;
}
