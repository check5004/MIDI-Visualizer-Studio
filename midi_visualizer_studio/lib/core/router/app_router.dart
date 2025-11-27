import 'package:go_router/go_router.dart';
import 'package:midi_visualizer_studio/features/editor/ui/editor_screen.dart';
import 'package:midi_visualizer_studio/features/home/ui/home_screen.dart';
import 'package:midi_visualizer_studio/features/settings/ui/settings_screen.dart';
import 'package:midi_visualizer_studio/features/splash/ui/splash_screen.dart';
import 'package:midi_visualizer_studio/features/tutorial/ui/tutorial_screen.dart';

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
        return EditorScreen(projectId: projectId);
      },
    ),
    GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
  ],
);
