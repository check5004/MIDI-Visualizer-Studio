import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/core/router/app_router.dart';
import 'package:midi_visualizer_studio/core/services/midi_service.dart';
import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final midiService = MidiService();
  runApp(MidiVisualizerApp(midiService: midiService));
}

class MidiVisualizerApp extends StatelessWidget {
  final MidiService midiService;

  const MidiVisualizerApp({super.key, required this.midiService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MidiBloc(midiService),
      child: MaterialApp.router(
        title: 'MIDI Visualizer Studio',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
        routerConfig: appRouter,
      ),
    );
  }
}
