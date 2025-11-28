import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/core/services/midi_service.dart';
import 'package:midi_visualizer_studio/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final midiService = MidiService();
    await tester.pumpWidget(MidiVisualizerApp(midiService: midiService));
    await tester.pumpAndSettle();
    expect(find.text('Splash Screen'), findsOneWidget);
  });
}
