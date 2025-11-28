import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_event.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences _prefs;
  static const String _themeKey = 'theme_mode';

  SettingsBloc(this._prefs) : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleTheme>(_onToggleTheme);

    add(const SettingsEvent.loadSettings());
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) {
    final themeIndex = _prefs.getInt(_themeKey);
    if (themeIndex != null) {
      final themeMode = ThemeMode.values[themeIndex];
      emit(state.copyWith(themeMode: themeMode));
    }
  }

  void _onToggleTheme(ToggleTheme event, Emitter<SettingsState> emit) async {
    await _prefs.setInt(_themeKey, event.mode.index);
    emit(state.copyWith(themeMode: event.mode));
  }
}
