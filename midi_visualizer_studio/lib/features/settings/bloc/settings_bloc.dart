import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_event.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences _prefs;
  static const String _themeKey = 'theme_mode';
  static const String _chromaKeyColorKey = 'default_chroma_key_color';
  static const String _windowlessKey = 'is_windowless';

  SettingsBloc(this._prefs) : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleTheme>(_onToggleTheme);
    on<UpdateChromaKeyColor>(_onUpdateChromaKeyColor);
    on<ToggleWindowless>(_onToggleWindowless);

    add(const SettingsEvent.loadSettings());
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) {
    final themeIndex = _prefs.getInt(_themeKey);
    final chromaKeyColor = _prefs.getInt(_chromaKeyColorKey);
    final isWindowless = _prefs.getBool(_windowlessKey);

    var newState = state;
    if (themeIndex != null) {
      newState = newState.copyWith(themeMode: ThemeMode.values[themeIndex]);
    }
    if (chromaKeyColor != null) {
      newState = newState.copyWith(defaultChromaKeyColor: chromaKeyColor);
    }
    if (isWindowless != null) {
      newState = newState.copyWith(isWindowless: isWindowless);
      _applyWindowStyle(isWindowless);
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

  void _onToggleWindowless(ToggleWindowless event, Emitter<SettingsState> emit) async {
    await _prefs.setBool(_windowlessKey, event.isWindowless);
    emit(state.copyWith(isWindowless: event.isWindowless));
    _applyWindowStyle(event.isWindowless);
  }

  Future<void> _applyWindowStyle(bool isWindowless) async {
    if (isWindowless) {
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    } else {
      await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    }
  }
}
