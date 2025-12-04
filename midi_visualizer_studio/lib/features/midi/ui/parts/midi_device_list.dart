import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:midi_visualizer_studio/features/midi/bloc/midi_bloc.dart';

class MidiDeviceList extends StatefulWidget {
  const MidiDeviceList({super.key});

  @override
  State<MidiDeviceList> createState() => _MidiDeviceListState();
}

class _MidiDeviceListState extends State<MidiDeviceList> {
  // Map to store the last active time for each device ID
  final Map<String, DateTime> _lastActiveTime = {};
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    // Timer to refresh UI for fading out the signal indicator
    _refreshTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MidiBloc, MidiState>(
      listener: (context, state) {
        if (state.lastPacket != null) {
          final deviceId = state.lastPacket!.device.id;
          setState(() {
            _lastActiveTime[deviceId] = DateTime.now();
          });
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              title: const Text('MIDI Devices'),
              trailing: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<MidiBloc>().add(const MidiEvent.scanDevices());
                },
              ),
            ),
            if (state.status == MidiStatus.scanning)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: LinearProgressIndicator()),
              )
            else if (state.devices.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text('No MIDI devices found')),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: state.devices.length,
                  itemBuilder: (context, index) {
                    final device = state.devices[index];
                    final isConnected = state.connectedDevice?.id == device.id;
                    final lastActive = _lastActiveTime[device.id];
                    final isSignalActive =
                        lastActive != null && DateTime.now().difference(lastActive) < const Duration(milliseconds: 300);

                    return ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Signal Indicator
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSignalActive ? Colors.green : Colors.grey.withOpacity(0.3),
                              boxShadow: isSignalActive
                                  ? [BoxShadow(color: Colors.green.withOpacity(0.6), blurRadius: 8, spreadRadius: 2)]
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.usb),
                        ],
                      ),
                      title: Text(device.name),
                      subtitle: Text(device.type),
                      trailing: ElevatedButton(
                        onPressed: () {
                          if (isConnected) {
                            context.read<MidiBloc>().add(MidiEvent.disconnectDevice(device));
                          } else {
                            context.read<MidiBloc>().add(MidiEvent.connectDevice(device));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isConnected ? Theme.of(context).colorScheme.errorContainer : null,
                          foregroundColor: isConnected ? Theme.of(context).colorScheme.onErrorContainer : null,
                        ),
                        child: Text(isConnected ? 'Disconnect' : 'Connect'),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
