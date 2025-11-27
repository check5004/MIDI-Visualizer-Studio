import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MIDI Visualizer Studio')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => context.push('/editor/new-project'), child: const Text('New Project')),
            const SizedBox(height: 40),
            const Text('Developer Tools (PoC)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.format_paint),
              label: const Text('Bucket Fill PoC'),
              onPressed: () => context.push('/poc/bucket-fill'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.piano),
              label: const Text('MIDI Monitor PoC'),
              onPressed: () => context.push('/poc/midi'),
            ),
          ],
        ),
      ),
    );
  }
}
