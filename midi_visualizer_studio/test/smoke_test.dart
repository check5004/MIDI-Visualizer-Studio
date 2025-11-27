import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MidiVisualizerApp());
    await tester.pumpAndSettle();
    expect(find.text('Splash Screen'), findsOneWidget);
  });
}
