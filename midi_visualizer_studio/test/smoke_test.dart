import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/core/services/midi_service.dart';
import 'package:midi_visualizer_studio/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final midiService = MidiService();
    SharedPreferences.setMockInitialValues({});

    // Mock window_manager
    const channel = MethodChannel('window_manager');
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getBounds') {
        return {'x': 0.0, 'y': 0.0, 'width': 800.0, 'height': 600.0};
      }
      return null;
    });

    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(MidiVisualizerApp(midiService: midiService, prefs: prefs));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Verify we are in Preview Screen (check for Close button)
    expect(find.byIcon(Icons.close), findsOneWidget);
  });
}
