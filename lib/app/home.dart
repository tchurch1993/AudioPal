import 'dart:async';

import 'package:audio_pal/app/add_hot_key.dart';
import 'package:audio_pal/database/audio_hotkey_database.dart';
import 'package:audio_pal/database/models/audio_hotkey.dart';
import 'package:audio_pal/enums/enums.dart';
import 'package:audio_pal/main.dart';
import 'package:audio_pal/services/audio_device_service.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<AudioHotKey>>? audioHotKeys;
  @override
  void initState() {
    super.initState();
    audioHotKeys = AudioHotKeyDatabase.instance.getAllAudioHotKeys();
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              useIndicator: true,
              labelType: NavigationRailLabelType.selected,
              elevation: 5,
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.spatial_audio),
                  selectedIcon: Icon(Icons.spatial_audio),
                  label: Text('Devices'),
                ),
              ],
              // have trailing widget be at bottom of navigation rail
              trailing: Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () async {
                          // show a color picker
                          var res = await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return SettingAlertDialog();
                            },
                          );
                          if (res == true) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Settings Saved'),
                                elevation: 5,
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<AudioHotKey>>(
                future: audioHotKeys,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    return ReorderableListView.builder(
                      proxyDecorator: (widget, index, animation) {
                        return Material(
                          color: Colors.transparent,
                          elevation: 5,
                          child: widget,
                        );
                      },
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return buildAudioHotKeyListTile(snapshot.data![index]);
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        setState(() {
                          final item = snapshot.data!.removeAt(oldIndex);
                          snapshot.data!.insert(newIndex, item);
                        });
                      },
                    );
                  }
                  return const Center(child: Text('No Audio HotKeys'));
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //create add hotkey window
            var res = await showDialog<bool>(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('Add Audio HotKey'),
                  content: AudioHotKeyForm(),
                );
              },
            );
            if (res == true) {
              setState(() {
                audioHotKeys =
                    AudioHotKeyDatabase.instance.getAllAudioHotKeys();
              });
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Audio HotKey Added'),
                  elevation: 5,
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          tooltip: 'Add Audio HotKey',
          child: const Icon(Icons.add),
        ));
  }

  Widget buildAudioHotKeyListTile(AudioHotKey audioHotKey) {
    return Card(
      key: ValueKey(audioHotKey.id),
      elevation: 5,
      child: ListTile(
        tileColor: Theme.of(context).cardTheme.color,
        title: Text(
          audioHotKey.deviceName,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          buildHotKeyString(audioHotKey),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 14,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.error,
          ),
          onPressed: () async {
            await AudioDeviceService().unregisterHotKey(audioHotKey);
            await AudioHotKeyDatabase.instance
                .deleteAudioHotKey(audioHotKey.id!);
            setState(() {
              audioHotKeys = AudioHotKeyDatabase.instance.getAllAudioHotKeys();
            });
          },
        ),
        leading: Icon(
          audioHotKey.deviceType == DeviceType.recording
              ? Icons.mic
              : Icons.speaker,
          color: audioHotKey.deviceType == DeviceType.recording
              ? Colors.blue
              : Colors.green,
        ),
      ),
    );
  }

  String buildHotKeyString(AudioHotKey audioHotKey) {
    // capitalize the first letter of the key
    var modifiers = audioHotKey.modifiers
            ?.map((e) => e.toString().split('.').last)
            .join(' + ') ??
        '';
    var key = audioHotKey.keyCode.toString().split('.').last;

    var resultString = modifiers.isEmpty ? key : '$modifiers + $key';
    return resultString.toUpperCase();
  }
}

class SettingAlertDialog extends StatefulWidget {
  const SettingAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  _SettingAlertDialogState createState() => _SettingAlertDialogState();
}

class _SettingAlertDialogState extends State<SettingAlertDialog> {
  Color _selectedColor = Colors.blue; // Default color
  // create a debounce timer
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Settings'),
      // change the color of the app
      content: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          var prefs = snapshot.data as SharedPreferences;

          _selectedColor = Color(prefs.getInt('color') ?? _selectedColor.value);

          return StatefulBuilder(builder: (context, setState) {
            return ColorWheelPicker(
              color: _selectedColor,
              onChanged: (Color color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              onWheel: (bool value) {
                if (value) {
                  _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    MyApp.setTheme(context, _selectedColor);
                  });
                }
              },
            );
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            MyApp.setTheme(context, _selectedColor);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
