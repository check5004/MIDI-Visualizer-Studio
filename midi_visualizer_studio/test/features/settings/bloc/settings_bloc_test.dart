import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_event.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_bloc_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late SettingsBloc settingsBloc;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    when(mockSharedPreferences.getInt(any)).thenReturn(null);
    when(mockSharedPreferences.setInt(any, any)).thenAnswer((_) async => true);
    settingsBloc = SettingsBloc(mockSharedPreferences);
  });

  tearDown(() {
    settingsBloc.close();
  });

  group('SettingsBloc', () {
    test('initial state is SettingsState()', () {
      expect(settingsBloc.state, const SettingsState());
    });

    test('emits [SettingsState] with loaded values when LoadSettings is added', () async {
      when(mockSharedPreferences.getInt('theme_mode')).thenReturn(ThemeMode.dark.index);
      when(mockSharedPreferences.getInt('default_chroma_key_color')).thenReturn(0xFF0000FF);

      final bloc = SettingsBloc(mockSharedPreferences);

      await expectLater(
        bloc.stream,
        emitsInOrder([const SettingsState(themeMode: ThemeMode.dark, defaultChromaKeyColor: 0xFF0000FF)]),
      );
    });

    test('emits [SettingsState] with new theme mode when ToggleTheme is added', () async {
      final future = expectLater(settingsBloc.stream, emitsInOrder([const SettingsState(themeMode: ThemeMode.dark)]));

      settingsBloc.add(const SettingsEvent.toggleTheme(ThemeMode.dark));

      await future;

      verify(mockSharedPreferences.setInt('theme_mode', ThemeMode.dark.index)).called(1);
    });

    test('emits [SettingsState] with new chroma key color when UpdateChromaKeyColor is added', () async {
      final future = expectLater(
        settingsBloc.stream,
        emitsInOrder([const SettingsState(defaultChromaKeyColor: 0xFFFF00FF)]),
      );

      settingsBloc.add(const SettingsEvent.updateChromaKeyColor(0xFFFF00FF));

      await future;

      verify(mockSharedPreferences.setInt('default_chroma_key_color', 0xFFFF00FF)).called(1);
    });
  });
}
