import 'package:go_router/go_router.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/ui/editor_screen.dart';
import 'package:midi_visualizer_studio/features/home/ui/home_screen.dart';
import 'package:midi_visualizer_studio/features/settings/ui/settings_screen.dart';
import 'package:midi_visualizer_studio/features/splash/ui/splash_screen.dart';
import 'package:midi_visualizer_studio/features/tutorial/ui/tutorial_screen.dart';
import 'package:midi_visualizer_studio/features/poc/bucket_fill/ui/bucket_fill_screen.dart';
import 'package:midi_visualizer_studio/features/poc/midi/ui/midi_monitor_screen.dart';
import 'package:midi_visualizer_studio/features/preview/ui/preview_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/tutorial', builder: (context, state) => const TutorialScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/editor/:projectId',
      builder: (context, state) {
        final projectId = state.pathParameters['projectId']!;
        final project = state.extra as Project?;
        return EditorScreen(projectId: projectId, project: project);
      },
    ),
    GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
    GoRoute(path: '/poc/bucket-fill', builder: (context, state) => const BucketFillScreen()),
    GoRoute(path: '/poc/midi', builder: (context, state) => const MidiMonitorScreen()),
    GoRoute(
      path: '/preview',
      builder: (context, state) {
        final project = state.extra as Project;
        return PreviewScreen(project: project);
      },
    ),
  ],
);
