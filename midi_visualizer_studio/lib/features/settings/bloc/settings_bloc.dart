import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'package:midi_visualizer_studio/data/models/shortcut_config.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_event.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences _prefs;
  static const String _themeKey = 'theme_mode';
  static const String _chromaKeyColorKey = 'default_chroma_key_color';
  static const String _editorBackgroundColorKey = 'editor_background_color';
  static const String _windowlessKey = 'is_windowless';
  static const String _shortcutsKey = 'shortcuts_config';

  SettingsBloc(this._prefs) : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleTheme>(_onToggleTheme);
    on<UpdateChromaKeyColor>(_onUpdateChromaKeyColor);
    on<UpdateEditorBackgroundColor>(_onUpdateEditorBackgroundColor);
    on<ToggleWindowless>(_onToggleWindowless);
    on<UpdateShortcut>(_onUpdateShortcut);
    on<ResetShortcuts>(_onResetShortcuts);

    add(const SettingsEvent.loadSettings());
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) {
    final themeIndex = _prefs.getInt(_themeKey);
    final chromaKeyColor = _prefs.getInt(_chromaKeyColorKey);
    final editorBackgroundColor = _prefs.getInt(_editorBackgroundColorKey);
    final isWindowless = _prefs.getBool(_windowlessKey);
    final shortcutsJson = _prefs.getString(_shortcutsKey);

    var newState = state;
    if (themeIndex != null) {
      newState = newState.copyWith(themeMode: ThemeMode.values[themeIndex]);
    }
    if (chromaKeyColor != null) {
      newState = newState.copyWith(defaultChromaKeyColor: chromaKeyColor);
    }
    if (editorBackgroundColor != null) {
      newState = newState.copyWith(editorBackgroundColor: editorBackgroundColor);
    }
    if (isWindowless != null) {
      newState = newState.copyWith(isWindowless: isWindowless);
      _applyWindowStyle(isWindowless);
    }

    if (shortcutsJson != null) {
      try {
        final Map<String, dynamic> jsonMap = jsonDecode(shortcutsJson);
        final shortcuts = jsonMap.map((key, value) => MapEntry(key, ShortcutConfig.fromJson(value)));
        // Merge with defaults to ensure all keys exist
        final mergedShortcuts = {..._defaultShortcuts, ...shortcuts};
        newState = newState.copyWith(shortcuts: mergedShortcuts);
      } catch (e) {
        debugPrint('Failed to load shortcuts: $e');
        newState = newState.copyWith(shortcuts: _defaultShortcuts);
      }
    } else {
      newState = newState.copyWith(shortcuts: _defaultShortcuts);
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

  void _onUpdateEditorBackgroundColor(UpdateEditorBackgroundColor event, Emitter<SettingsState> emit) async {
    await _prefs.setInt(_editorBackgroundColorKey, event.color);
    emit(state.copyWith(editorBackgroundColor: event.color));
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

  void _onUpdateShortcut(UpdateShortcut event, Emitter<SettingsState> emit) async {
    final newShortcuts = Map<String, ShortcutConfig>.from(state.shortcuts);
    newShortcuts[event.actionId] = event.config;

    await _saveShortcuts(newShortcuts);
    emit(state.copyWith(shortcuts: newShortcuts));
  }

  void _onResetShortcuts(ResetShortcuts event, Emitter<SettingsState> emit) async {
    await _saveShortcuts(_defaultShortcuts);
    emit(state.copyWith(shortcuts: _defaultShortcuts));
  }

  Future<void> _saveShortcuts(Map<String, ShortcutConfig> shortcuts) async {
    final jsonMap = shortcuts.map((key, value) => MapEntry(key, value.toJson()));
    await _prefs.setString(_shortcutsKey, jsonEncode(jsonMap));
  }

  Map<String, ShortcutConfig> get _defaultShortcuts => {
    'undo': const ShortcutConfig(
      keyId: 0x0000000007a, // LogicalKeyboardKey.keyZ.keyId
      isMeta: true,
    ),
    'redo': const ShortcutConfig(
      keyId: 0x0000000007a, // LogicalKeyboardKey.keyZ.keyId
      isMeta: true,
      isShift: true,
    ),
    'copy': const ShortcutConfig(
      keyId: 0x00000000063, // LogicalKeyboardKey.keyC.keyId
      isMeta: true,
    ),
    'paste': const ShortcutConfig(
      keyId: 0x00000000076, // LogicalKeyboardKey.keyV.keyId
      isMeta: true,
    ),
    'cut': const ShortcutConfig(
      keyId: 0x00000000078, // LogicalKeyboardKey.keyX.keyId
      isMeta: true,
    ),
    'delete': const ShortcutConfig(
      keyId: 0x0010000007f, // LogicalKeyboardKey.delete.keyId
    ),
    'duplicate': const ShortcutConfig(
      keyId: 0x00000000064, // LogicalKeyboardKey.keyD.keyId
      isMeta: true,
    ),
  };
}
