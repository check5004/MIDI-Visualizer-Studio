import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/core/router/app_router.dart';
import 'package:midi_visualizer_studio/core/services/midi_service.dart';
import 'package:midi_visualizer_studio/features/common/services/color_history_service.dart';
import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (!kIsWeb && Platform.isWindows) {
    await Window.initialize();
  }

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 820),
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
  final colorHistoryService = ColorHistoryService(prefs);

  final projectRepository = ProjectRepository();
  runApp(
    MidiVisualizerApp(
      midiService: midiService,
      prefs: prefs,
      colorHistoryService: colorHistoryService,
      projectRepository: projectRepository,
    ),
  );
}

class MidiVisualizerApp extends StatelessWidget {
  final MidiService midiService;
  final SharedPreferences prefs;
  final ColorHistoryService colorHistoryService;
  final ProjectRepository projectRepository;

  const MidiVisualizerApp({
    super.key,
    required this.midiService,
    required this.prefs,
    required this.colorHistoryService,
    required this.projectRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: projectRepository),
        RepositoryProvider.value(value: colorHistoryService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MidiBloc(midiService)),
          BlocProvider(create: (context) => SettingsBloc(prefs)),
        ],
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'MIDI Visualizer Studio',
              theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue), useMaterial3: true),
              darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue, brightness: Brightness.dark),
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
