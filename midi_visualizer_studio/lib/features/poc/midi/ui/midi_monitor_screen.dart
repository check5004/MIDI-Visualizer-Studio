import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';

class MidiMonitorScreen extends StatefulWidget {
  const MidiMonitorScreen({super.key});

  @override
  State<MidiMonitorScreen> createState() => _MidiMonitorScreenState();
}

class _MidiMonitorScreenState extends State<MidiMonitorScreen> {
  final _midiCommand = MidiCommand();
  List<MidiDevice> _devices = [];
  final List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _initMidi();
  }

  Future<void> _initMidi() async {
    _midiCommand.onMidiDataReceived!.listen((MidiPacket packet) {
      final data = packet.data;
      final timestamp = DateTime.now().toIso8601String().split('T')[1];
      final status = data[0];
      final type = status & 0xF0;
      final channel = (status & 0x0F) + 1;

      String message = '';
      if (type == 0x90) {
        message = 'Note On: ${data[1]} Vel: ${data[2]}';
      } else if (type == 0x80) {
        message = 'Note Off: ${data[1]}';
      } else if (type == 0xB0) {
        message = 'CC: ${data[1]} Val: ${data[2]}';
      } else {
        message = 'Other: $data';
      }

      setState(() {
        _logs.insert(0, '[$timestamp] Ch:$channel $message');
        if (_logs.length > 50) _logs.removeLast();
      });
    });

    _refreshDevices();
  }

  Future<void> _refreshDevices() async {
    final devices = await _midiCommand.devices;
    setState(() {
      _devices = devices ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIDI Monitor PoC'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _refreshDevices)],
      ),
      body: Column(
        children: [
          // Device List
          Container(
            height: 150,
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final device = _devices[index];
                return ListTile(
                  title: Text(device.name),
                  subtitle: Text('ID: ${device.id} Type: ${device.type}'),
                  trailing: Switch(
                    value: device.connected,
                    onChanged: (connected) {
                      if (connected) {
                        _midiCommand.connectToDevice(device);
                      } else {
                        _midiCommand.disconnectDevice(device);
                      }
                      // Give it a moment to update state
                      Future.delayed(const Duration(milliseconds: 500), _refreshDevices);
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          // Log Area
          Expanded(
            child: ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(_logs[index], style: const TextStyle(fontFamily: 'Monospace')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
