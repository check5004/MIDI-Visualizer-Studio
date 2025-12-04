import 'dart:typed_data';

class MidiMessage {
  final int status;
  final int channel;
  final int data1;
  final int data2;

  const MidiMessage({required this.status, required this.channel, required this.data1, required this.data2});

  bool get isNoteOn => status == 0x90 && data2 > 0;
  bool get isNoteOff => status == 0x80 || (status == 0x90 && data2 == 0);
  bool get isControlChange => status == 0xB0;

  @override
  String toString() =>
      'MidiMessage(status: ${status.toRadixString(16)}, channel: $channel, data1: $data1, data2: $data2)';
}

class MidiParser {
  /// Parses a raw MIDI packet into a list of [MidiMessage]s.
  /// Handles multiple messages in a single packet.
  /// Currently supports 3-byte messages (Note On, Note Off, CC, etc.).
  static List<MidiMessage> parse(Uint8List data) {
    final messages = <MidiMessage>[];
    int i = 0;

    while (i < data.length) {
      final byte = data[i];

      // Status byte (0x80 - 0xFF)
      if (byte >= 0x80) {
        // System Real-Time messages (0xF8 - 0xFF) are single byte and can appear anywhere
        if (byte >= 0xF8) {
          // We can ignore these for now as they don't affect pads/knobs
          i++;
          continue;
        }

        final status = byte & 0xF0;
        final channel = byte & 0x0F;

        // Check if we have enough bytes for a standard 3-byte message
        // Note On (0x90), Note Off (0x80), CC (0xB0), Pitch Bend (0xE0), etc.
        // Program Change (0xC0) and Channel Pressure (0xD0) are 2 bytes.

        if (status == 0xC0 || status == 0xD0) {
          // 2-byte message
          if (i + 1 < data.length) {
            final data1 = data[i + 1];
            // We treat 2-byte messages as having data2 = 0 for simplicity in our specific use case,
            // or we could make data2 optional. For now, let's just parse them.
            messages.add(MidiMessage(status: status, channel: channel, data1: data1, data2: 0));
            i += 2;
          } else {
            break; // Incomplete message
          }
        } else {
          // 3-byte message (0x80, 0x90, 0xA0, 0xB0, 0xE0)
          if (i + 2 < data.length) {
            final data1 = data[i + 1];
            final data2 = data[i + 2];

            // Ensure data bytes are valid (0-127)
            if (data1 < 0x80 && data2 < 0x80) {
              messages.add(MidiMessage(status: status, channel: channel, data1: data1, data2: data2));
              i += 3;
            } else {
              // Invalid data bytes, maybe running status or sync issue.
              // Skip this status byte and try next
              i++;
            }
          } else {
            break; // Incomplete message
          }
        }
      } else {
        // Data byte without status (Running Status?)
        // For now, we just skip unexpected data bytes to avoid getting stuck
        i++;
      }
    }

    return messages;
  }
}
