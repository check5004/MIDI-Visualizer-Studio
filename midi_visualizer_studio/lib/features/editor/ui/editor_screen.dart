import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/canvas_view.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/inspector_panel.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/layer_panel.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/editor_app_bar.dart';
import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/history_bloc.dart';
import 'package:window_manager/window_manager.dart';

class EditorScreen extends StatelessWidget {
  final String projectId;

  const EditorScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HistoryCubit()),
        BlocProvider(
          create: (context) => EditorBloc(
            historyCubit: context.read<HistoryCubit>(),
            projectRepository: context.read<ProjectRepository>(),
          )..add(EditorEvent.loadProject(projectId)),
        ),
      ],
      child: BlocConsumer<EditorBloc, EditorState>(
        listenWhen: (previous, current) => previous.mode != current.mode,
        listener: (context, state) async {
          if (kIsWeb) return; // Window manager not supported on web

          if (state.mode == EditorMode.overlay) {
            await windowManager.setHasShadow(false);
            await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
            await windowManager.setBackgroundColor(Colors.transparent);
            await windowManager.setAlwaysOnTop(true);
          } else {
            await windowManager.setHasShadow(true);
            await windowManager.setTitleBarStyle(TitleBarStyle.normal);
            if (context.mounted) {
              await windowManager.setBackgroundColor(Theme.of(context).scaffoldBackgroundColor);
            }
            await windowManager.setAlwaysOnTop(false);
          }
        },
        builder: (context, state) {
          if (state.status == EditorStatus.loading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state.mode == EditorMode.overlay) {
            return const Scaffold(backgroundColor: Colors.transparent, body: CanvasView());
          }

          return Scaffold(
            appBar: const EditorAppBar(),
            body: Row(
              children: [
                // Layer Panel (Left)
                const SizedBox(width: 250, child: LayerPanel()),
                // Canvas (Center)
                const Expanded(child: CanvasView()),
                // Inspector (Right)
                const SizedBox(width: 300, child: InspectorPanel()),
              ],
            ),
          );
        },
      ),
    );
  }
}
