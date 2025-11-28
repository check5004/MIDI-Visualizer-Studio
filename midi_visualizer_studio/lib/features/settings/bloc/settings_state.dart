import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(ThemeMode.light) ThemeMode themeMode,
    @Default(0xFF00FF00) int defaultChromaKeyColor, // Default to Green
  }) = _SettingsState;
}
