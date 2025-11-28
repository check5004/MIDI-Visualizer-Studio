import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_event.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences _prefs;
  static const String _themeKey = 'theme_mode';
  static const String _chromaKeyColorKey = 'default_chroma_key_color';

  SettingsBloc(this._prefs) : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleTheme>(_onToggleTheme);
    on<UpdateChromaKeyColor>(_onUpdateChromaKeyColor);

    add(const SettingsEvent.loadSettings());
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) {
    final themeIndex = _prefs.getInt(_themeKey);
    final chromaKeyColor = _prefs.getInt(_chromaKeyColorKey);

    var newState = state;
    if (themeIndex != null) {
      newState = newState.copyWith(themeMode: ThemeMode.values[themeIndex]);
    }
    if (chromaKeyColor != null) {
      newState = newState.copyWith(defaultChromaKeyColor: chromaKeyColor);
    }
    emit(newState);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<SettingsState> emit) async {
    await _prefs.setInt(_themeKey, event.mode.index);
    emit(state.copyWith(themeMode: event.mode));
  }

  void _onUpdateChromaKeyColor(UpdateChromaKeyColor event, Emitter<SettingsState> emit) async {
    await _prefs.setInt(_chromaKeyColorKey, event.color);
    emit(state.copyWith(defaultChromaKeyColor: event.color));
  }
}
