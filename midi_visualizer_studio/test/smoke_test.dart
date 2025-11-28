import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/core/services/midi_service.dart';
import 'package:midi_visualizer_studio/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final midiService = MidiService();
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(MidiVisualizerApp(midiService: midiService, prefs: prefs));
    await tester.pumpAndSettle();
    expect(find.text('Splash Screen'), findsOneWidget);
  });
}
