import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/core/router/app_router.dart';
import 'package:midi_visualizer_studio/core/services/midi_service.dart';
import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  final midiService = MidiService();
  final prefs = await SharedPreferences.getInstance();

  runApp(MidiVisualizerApp(midiService: midiService, prefs: prefs));
}

class MidiVisualizerApp extends StatelessWidget {
  final MidiService midiService;
  final SharedPreferences prefs;

  const MidiVisualizerApp({super.key, required this.midiService, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProjectRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MidiBloc(midiService)),
          BlocProvider(create: (context) => SettingsBloc(prefs)),
        ],
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'MIDI Visualizer Studio',
              theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
              darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
                useMaterial3: true,
              ),
              themeMode: state.themeMode,
              routerConfig: appRouter,
            );
          },
        ),
      ),
    );
  }
}
