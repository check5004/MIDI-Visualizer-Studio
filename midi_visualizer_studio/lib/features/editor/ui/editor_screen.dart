import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_bloc.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_event.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/editor_state.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/canvas_view.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/inspector_panel.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/layer_panel.dart';
import 'package:midi_visualizer_studio/features/editor/ui/parts/editor_app_bar.dart';
import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';
import 'package:midi_visualizer_studio/features/editor/bloc/history_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';
import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';

class EditorScreen extends StatefulWidget {
  final String projectId;
  final Project? project;

  const EditorScreen({super.key, required this.projectId, this.project});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  double _inspectorWidth = 350.0;
  double _layerPanelWidth = 250.0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HistoryCubit()),
        BlocProvider(
          create: (context) => EditorBloc(
            historyCubit: context.read<HistoryCubit>(),
            projectRepository: context.read<ProjectRepository>(),
          )..add(EditorEvent.loadProject(path: widget.projectId, project: widget.project)),
        ),
      ],
      child: BlocBuilder<EditorBloc, EditorState>(
        builder: (context, state) {
          if (state.status == EditorStatus.loading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          return BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settingsState) {
              final shortcuts = settingsState.shortcuts;

              return Actions(
                actions: {
                  CopyIntent: CallbackAction<CopyIntent>(
                    onInvoke: (_) => context.read<EditorBloc>().add(const EditorEvent.copy()),
                  ),
                  PasteIntent: CallbackAction<PasteIntent>(
                    onInvoke: (_) => context.read<EditorBloc>().add(const EditorEvent.paste()),
                  ),
                  CutIntent: CallbackAction<CutIntent>(
                    onInvoke: (_) => context.read<EditorBloc>().add(const EditorEvent.cut()),
                  ),
                  DeleteIntent: CallbackAction<DeleteIntent>(
                    onInvoke: (_) => context.read<EditorBloc>().add(const EditorEvent.delete()),
                  ),
                  DuplicateIntent: CallbackAction<DuplicateIntent>(
                    onInvoke: (_) => context.read<EditorBloc>().add(const EditorEvent.duplicate()),
                  ),
                  UndoIntent: CallbackAction<UndoIntent>(
                    onInvoke: (_) => context.read<EditorBloc>().add(const EditorEvent.undo()),
                  ),
                  RedoIntent: CallbackAction<RedoIntent>(
                    onInvoke: (_) => context.read<EditorBloc>().add(const EditorEvent.redo()),
                  ),
                },
                child: FocusableActionDetector(
                  autofocus: true,
                  shortcuts: {
                    if (shortcuts.containsKey('copy')) shortcuts['copy']!.toActivator(): const CopyIntent(),
                    if (shortcuts.containsKey('paste')) shortcuts['paste']!.toActivator(): const PasteIntent(),
                    if (shortcuts.containsKey('cut')) shortcuts['cut']!.toActivator(): const CutIntent(),
                    if (shortcuts.containsKey('delete')) shortcuts['delete']!.toActivator(): const DeleteIntent(),
                    if (shortcuts.containsKey('duplicate'))
                      shortcuts['duplicate']!.toActivator(): const DuplicateIntent(),
                    if (shortcuts.containsKey('undo')) shortcuts['undo']!.toActivator(): const UndoIntent(),
                    if (shortcuts.containsKey('redo')) shortcuts['redo']!.toActivator(): const RedoIntent(),
                  },
                  child: BlocListener<MidiBloc, MidiState>(
                    listener: (context, midiState) {
                      if (midiState.lastPacket != null) {
                        context.read<EditorBloc>().add(EditorEvent.handleMidiMessage(midiState.lastPacket!));
                      }
                    },
                    child: Scaffold(
                      appBar: const EditorAppBar(),
                      body: Row(
                        children: [
                          // Layer Panel (Left)
                          SizedBox(width: _layerPanelWidth, child: const LayerPanel()),
                          // Left Resize Handle
                          MouseRegion(
                            cursor: SystemMouseCursors.resizeColumn,
                            child: GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                setState(() {
                                  _layerPanelWidth += details.delta.dx;
                                  _layerPanelWidth = _layerPanelWidth.clamp(200.0, 500.0);
                                });
                              },
                              child: Container(width: 5, color: Theme.of(context).colorScheme.surface),
                            ),
                          ),
                          // Canvas (Center)
                          const Expanded(child: CanvasView()),
                          // Right Resize Handle
                          MouseRegion(
                            cursor: SystemMouseCursors.resizeColumn,
                            child: GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                setState(() {
                                  _inspectorWidth -= details.delta.dx;
                                  _inspectorWidth = _inspectorWidth.clamp(300.0, 600.0);
                                });
                              },
                              child: Container(width: 5, color: Theme.of(context).colorScheme.surface),
                            ),
                          ),
                          // Inspector (Right)
                          SizedBox(width: _inspectorWidth, child: const InspectorPanel()),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CopyIntent extends Intent {
  const CopyIntent();
}

class PasteIntent extends Intent {
  const PasteIntent();
}

class CutIntent extends Intent {
  const CutIntent();
}

class DeleteIntent extends Intent {
  const DeleteIntent();
}

class DuplicateIntent extends Intent {
  const DuplicateIntent();
}

class UndoIntent extends Intent {
  const UndoIntent();
}

class RedoIntent extends Intent {
  const RedoIntent();
}
