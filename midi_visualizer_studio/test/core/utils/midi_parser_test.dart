import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/core/utils/midi_parser.dart';

void main() {
  group('MidiParser', () {
    test('parses single Note On message', () {
      final data = Uint8List.fromList([0x90, 60, 100]);
      final messages = MidiParser.parse(data);

      expect(messages.length, 1);
      expect(messages[0].isNoteOn, true);
      expect(messages[0].channel, 0);
      expect(messages[0].data1, 60);
      expect(messages[0].data2, 100);
    });

    test('parses single Note Off message', () {
      final data = Uint8List.fromList([0x80, 60, 0]);
      final messages = MidiParser.parse(data);

      expect(messages.length, 1);
      expect(messages[0].isNoteOff, true);
      expect(messages[0].channel, 0);
      expect(messages[0].data1, 60);
      expect(messages[0].data2, 0);
    });

    test('parses multiple messages in one packet (Note On + Note Off)', () {
      // Note On (Ch 1, Note 60, Vel 100) + Note Off (Ch 1, Note 60, Vel 0)
      final data = Uint8List.fromList([0x90, 60, 100, 0x80, 60, 0]);
      final messages = MidiParser.parse(data);

      expect(messages.length, 2);

      expect(messages[0].isNoteOn, true);
      expect(messages[0].channel, 0);
      expect(messages[0].data1, 60);
      expect(messages[0].data2, 100);

      expect(messages[1].isNoteOff, true);
      expect(messages[1].channel, 0);
      expect(messages[1].data1, 60);
      expect(messages[1].data2, 0);
    });

    test('parses mixed messages (CC + Note On)', () {
      // CC (Ch 1, CC 10, Val 127) + Note On (Ch 2, Note 64, Vel 80)
      final data = Uint8List.fromList([0xB0, 10, 127, 0x91, 64, 80]);
      final messages = MidiParser.parse(data);

      expect(messages.length, 2);

      expect(messages[0].isControlChange, true);
      expect(messages[0].channel, 0);
      expect(messages[0].data1, 10);
      expect(messages[0].data2, 127);

      expect(messages[1].isNoteOn, true);
      expect(messages[1].channel, 1);
      expect(messages[1].data1, 64);
      expect(messages[1].data2, 80);
    });

    test('ignores System Real-Time messages', () {
      // Clock (0xF8) + Note On + Active Sensing (0xFE)
      final data = Uint8List.fromList([0xF8, 0x90, 60, 100, 0xFE]);
      final messages = MidiParser.parse(data);

      expect(messages.length, 1);
      expect(messages[0].isNoteOn, true);
    });

    test('handles incomplete messages gracefully', () {
      // Note On with missing data2
      final data = Uint8List.fromList([0x90, 60]);
      final messages = MidiParser.parse(data);

      expect(messages.length, 0);
    });
  });
}
