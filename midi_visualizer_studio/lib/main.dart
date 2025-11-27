import 'package:flutter/material.dart';
import 'package:midi_visualizer_studio/core/router/app_router.dart';

void main() {
  runApp(const MidiVisualizerApp());
}

class MidiVisualizerApp extends StatelessWidget {
  const MidiVisualizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MIDI Visualizer Studio',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      routerConfig: appRouter,
    );
  }
}
