import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';
import 'package:midi_visualizer_studio/features/home/ui/home_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_screen_test.mocks.dart';

@GenerateMocks([ProjectRepository])
void main() {
  late MockProjectRepository mockProjectRepository;

  setUp(() {
    mockProjectRepository = MockProjectRepository();
  });

  Widget createWidgetUnderTest() {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/editor/:id', builder: (context, state) => const SizedBox()),
        GoRoute(path: '/preview', builder: (context, state) => const SizedBox()),
        GoRoute(path: '/tutorial', builder: (context, state) => const SizedBox()),
        GoRoute(path: '/settings', builder: (context, state) => const SizedBox()),
      ],
    );

    return RepositoryProvider<ProjectRepository>.value(
      value: mockProjectRepository,
      child: MaterialApp.router(routerConfig: router),
    );
  }

  testWidgets('HomeScreen displays project card with Edit and Delete buttons', (tester) async {
    final project = Project(
      id: '1',
      name: 'Test Project',
      version: '1.0.0',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      layers: [],
    );

    when(mockProjectRepository.getProjects()).thenAnswer((_) async => [project]);

    await tester.pumpWidget(createWidgetUnderTest());

    // Wait for projects to load
    await tester.pumpAndSettle();

    // Verify Project Card
    expect(find.text('Test Project'), findsOneWidget);

    // Verify Buttons
    expect(find.text('Edit'), findsOneWidget); // FilledButton.icon label
    expect(find.byIcon(Icons.file_upload_outlined), findsOneWidget); // Export
    expect(find.byIcon(Icons.delete_outline), findsOneWidget); // Delete
  });

  testWidgets('Delete button shows confirmation dialog and deletes project on confirm', (tester) async {
    final project = Project(
      id: '1',
      name: 'Test Project',
      version: '1.0.0',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      layers: [],
    );

    when(mockProjectRepository.getProjects()).thenAnswer((_) async => [project]);
    when(mockProjectRepository.deleteProject(any)).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.pumpAndSettle();

    // Tap Delete
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    // Verify Dialog
    expect(find.text('Delete Project'), findsOneWidget);
    expect(find.text('Are you sure you want to delete "Test Project"? This action cannot be undone.'), findsOneWidget);

    // Tap Delete in Dialog
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle(); // Wait for dialog to close and bloc to process

    // Verify deleteProject was called
    verify(mockProjectRepository.deleteProject('1')).called(1);
  });

  testWidgets('Delete button cancels on cancel', (tester) async {
    final project = Project(
      id: '1',
      name: 'Test Project',
      version: '1.0.0',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      layers: [],
    );

    when(mockProjectRepository.getProjects()).thenAnswer((_) async => [project]);

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.pumpAndSettle();

    // Tap Delete
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    // Tap Cancel in Dialog
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // Verify deleteProject was NOT called
    verifyNever(mockProjectRepository.deleteProject(any));
  });
}
