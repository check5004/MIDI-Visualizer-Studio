import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_bloc.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_event.dart';
import 'package:midi_visualizer_studio/features/settings/bloc/settings_state.dart';

import 'package:midi_visualizer_studio/features/settings/ui/settings_screen.dart';

class FakeSettingsBloc extends Bloc<SettingsEvent, SettingsState> implements SettingsBloc {
  FakeSettingsBloc() : super(const SettingsState());
}

class FakeMidiBloc extends Bloc<MidiEvent, MidiState> implements MidiBloc {
  FakeMidiBloc() : super(const MidiState());
}

void main() {
  late FakeSettingsBloc fakeSettingsBloc;
  late FakeMidiBloc fakeMidiBloc;

  setUp(() {
    fakeSettingsBloc = FakeSettingsBloc();
    fakeMidiBloc = FakeMidiBloc();
  });

  tearDown(() {
    fakeSettingsBloc.close();
    fakeMidiBloc.close();
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>.value(value: fakeSettingsBloc),
        BlocProvider<MidiBloc>.value(value: fakeMidiBloc),
      ],
      child: const MaterialApp(home: SettingsScreen()),
    );
  }

  testWidgets('SettingsScreen displays 1 column on small screens', (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Row), findsNothing);
  });

  testWidgets('SettingsScreen displays 2 columns on medium screens', (tester) async {
    tester.view.physicalSize = const Size(800, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(ListView), findsNothing);
    expect(find.byType(Row), findsAtLeastNWidgets(1));
  });

  testWidgets('SettingsScreen displays 3 columns on large screens', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(ListView), findsNothing);
    expect(find.byType(Row), findsAtLeastNWidgets(1));
  });

  testWidgets('General section displays Dark Mode toggle', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Dark Mode'), findsOneWidget);
    expect(find.byType(Switch), findsAtLeastNWidgets(1));
  });

  testWidgets('MIDI section displays device list', (tester) async {
    final device = MidiDevice('1', 'Test Device', 'input', false);
    fakeMidiBloc.emit(MidiState(devices: [device]));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Rebuild with new state

    expect(find.text('MIDI Devices'), findsOneWidget);
    expect(find.text('Test Device'), findsOneWidget);
  });
}
