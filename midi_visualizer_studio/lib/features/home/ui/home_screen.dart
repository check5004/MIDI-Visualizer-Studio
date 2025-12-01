import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';
import 'package:midi_visualizer_studio/features/settings/ui/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Projects')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
            ],
            trailing: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(
                icon: const Icon(Icons.help_outline),
                onPressed: () => context.push('/tutorial'),
                tooltip: 'Tutorial',
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),

          // Main Content
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildRecentProjects() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(32.0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Projects', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text('Manage your MIDI visualizer projects.', style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 0.6,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return _NewProjectCard();
                }
                return _ProjectCard(index: index);
              },
              childCount: 6, // 1 New + 5 Mock Projects
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildRecentProjects();
      case 1:
        return const SettingsScreen();
      default:
        return _buildRecentProjects();
    }
  }
}

class _NewProjectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          final projectRepository = context.read<ProjectRepository>();
          final project = projectRepository.createEmptyProject();
          context.push('/editor/${project.id}', extra: project);
        },
        child: Container(
          color: colorScheme.primary.withValues(alpha: 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: colorScheme.primary.withValues(alpha: 0.15), shape: BoxShape.circle),
                child: Icon(Icons.add, size: 32, color: colorScheme.primary),
              ),
              const SizedBox(height: 16),
              Text(
                'New Project',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorScheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final int index;

  const _ProjectCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          context.push('/editor/project-$index');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: colorScheme.surfaceContainerHighest,
                child: Center(child: Icon(Icons.grid_view, size: 48, color: colorScheme.onSurfaceVariant)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Project $index',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text('Edited 2h ago', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            // TODO: In a real app, we would load the project here.
                            // For now, we'll just navigate to preview with a dummy project or ID.
                            // Since we don't have a real project object here easily without loading,
                            // we might need to rely on the PreviewScreen to load it if passed an ID.
                            // But PreviewScreen currently expects a Project object.
                            // Let's assume for now we can't easily launch without loading.
                            // But the user wants "Direct Launch".
                            // I will pass a dummy project for now to demonstrate the flow.
                            final projectRepository = context.read<ProjectRepository>();
                            // This is a hack for the mock. In reality we'd get the project by ID.
                            final project = projectRepository.createProject(rows: 4, cols: 4);
                            context.pushReplacement('/preview', extra: project);
                          },
                          icon: const Icon(Icons.play_arrow, size: 16),
                          label: const Text('Launch'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
