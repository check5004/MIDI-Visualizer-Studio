import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/core/router/app_router.dart';
import 'package:midi_visualizer_studio/core/services/midi_service.dart';
import 'package:midi_visualizer_studio/features/common/services/color_history_service.dart';
import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:midi_visualizer_studio/data/models/project.dart'; // actually used in logic? Yes, Project type is used in extra. Wait, initialExtra: project. Project is type.
import 'package:midi_visualizer_studio/data/models/project.dart';

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

  // Check if we should launch in preview mode
  final shouldLaunchInPreview = prefs.getBool('launch_in_preview') ?? true;
  final isInPreviewMode = prefs.getBool('is_in_preview_mode') ?? false;
  final lastProjectId = prefs.getString('last_project_id');

  RouterConfig<Object>? routerConfig;

  if (shouldLaunchInPreview && isInPreviewMode && lastProjectId != null) {
    try {
      // Just ensure we can load the project so we have the ID to lookup in list
      // But actually we already have the ID (lastProjectId).
      // We are trying to find the path in the list.

      final projects = await projectRepository.getProjects();
      final projectToLoadIndex = projects.indexWhere((p) => p.id == lastProjectId);

      if (projectToLoadIndex != -1) {
        // We have the project in the list, but we need to re-load it to ensure we have full data if getProjects() was returning lightweight objects (though currently it returns full objects)
        // Actually getProjects returns full objects.
        final project = projects[projectToLoadIndex];

        routerConfig = createAppRouter(initialLocation: '/preview', initialExtra: project);
      }
    } catch (e) {
      debugPrint('Failed to load last project for preview: $e');
    }
  }

  routerConfig ??= createAppRouter();

  runApp(
    MidiVisualizerApp(
      midiService: midiService,
      prefs: prefs,
      colorHistoryService: colorHistoryService,
      projectRepository: projectRepository,
      routerConfig: routerConfig,
    ),
  );
}

class MidiVisualizerApp extends StatelessWidget {
  final MidiService midiService;
  final SharedPreferences prefs;
  final ColorHistoryService colorHistoryService;
  final ProjectRepository projectRepository;
  final RouterConfig<Object> routerConfig;

  const MidiVisualizerApp({
    super.key,
    required this.midiService,
    required this.prefs,
    required this.colorHistoryService,
    required this.projectRepository,
    required this.routerConfig,
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
              routerConfig: routerConfig,
            );
          },
        ),
      ),
    );
  }
}
