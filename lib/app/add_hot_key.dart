import 'package:audio_pal/database/audio_hotkey_database.dart';
import 'package:audio_pal/database/models/audio_hotkey.dart';
import 'package:audio_pal/enums/enums.dart';
import 'package:audio_pal/services/audio_device_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:win32audio/win32audio.dart';

class AudioHotKeyForm extends StatefulWidget {
  const AudioHotKeyForm({super.key, this.hotkey, this.deviceId});

  final HotKey? hotkey;
  final String? deviceId;
  @override
  State<AudioHotKeyForm> createState() => _AudioHotKeyFormState();
}

class _AudioHotKeyFormState extends State<AudioHotKeyForm> {
  late String selectedDevice;
  Future<List<AudioDevice>>? audioDevices;
  HotKey? hotKey;
  String? deviceId;

  @override
  void initState() {
    super.initState();
    hotKey = widget.hotkey;
    deviceId = widget.deviceId;
    audioDevices = getAudioDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Select Audio Device'),
          const Gap(20),
          FutureBuilder(
              future: audioDevices,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return DropdownMenu<String>(
                  initialSelection: deviceId,
                  onSelected: (deviceId) {
                    setState(() {
                      this.deviceId = deviceId;
                    });
                  },
                  dropdownMenuEntries: [
                    for (var device in snapshot.data as List<AudioDevice>)
                      DropdownMenuEntry(
                        value: device.id,
                        label: device.name,
                      ),
                  ],
                );
              }),
          const Gap(20),
          const Text('Record HotKey'),
          const Gap(20),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (hotKey == null) const Text('Press a key combination'),
                  HotKeyRecorder(
                    initalHotKey: hotKey,
                    onHotKeyRecorded: (hotKey) {
                      setState(() {
                        this.hotKey = hotKey;
                      });
                      print(
                          'HotKey Recorded: ${hotKey.modifiers} + ${hotKey.keyCode}');
                    },
                  ),
                ],
              ),
            ),
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel'),
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () async {
                  if (hotKey == null || deviceId == null) {
                    return;
                  }
                  var devices = await audioDevices ?? [];
                  var device = devices
                      .firstWhereOrNull((device) => device.id == deviceId);
                  if (device == null) {
                    if (!mounted) return;
                    Navigator.of(context).pop(false);
                  }
                  var audioHotKey = AudioHotKey(
                    deviceGuid: deviceId!,
                    keyCode: hotKey!.keyCode,
                    modifiers: hotKey!.modifiers,
                    deviceName: device!.name,
                    deviceType: DeviceType.playback,
                  );
                  var res = await AudioHotKeyDatabase.instance
                      .insertAudioHotKey(audioHotKey);
                  var hotKeyToRegister = AudioHotKey(
                    id: res,
                    modifiers: hotKey!.modifiers,
                    keyCode: hotKey!.keyCode,
                    deviceName: device.name,
                    deviceGuid: device.id,
                    deviceType: DeviceType.playback,
                  );
                  await AudioDeviceService().registerHotKey(hotKeyToRegister);
                  if (!mounted) return;
                  Navigator.of(context).pop(true);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<AudioDevice>> getAudioDevices() async {
    var audioDevices = await Audio.enumDevices(AudioDeviceType.input) ?? [];
    audioDevices.addAll(await Audio.enumDevices(AudioDeviceType.output) ?? []);
    return audioDevices;
  }
}
