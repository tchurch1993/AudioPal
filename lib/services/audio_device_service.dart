import 'dart:async';

import 'package:audio_pal/database/audio_hotkey_database.dart';
import 'package:audio_pal/database/models/audio_hotkey.dart';
import 'package:audio_pal/services/system_tray_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:win32audio/win32audio.dart';
import 'package:collection/collection.dart';

class AudioDeviceService {
  static final AudioDeviceService _instance = AudioDeviceService._internal();

  List<AudioDevice> _audioDevices = [];
  List<AudioHotKey> _audioHotKeys = [];
  final audioPlayer = AudioPlayer();

  AudioDeviceService._internal();

  factory AudioDeviceService() {
    return _instance;
  }

  Future<void> registerHotKeys() async {
    // read hotkeys from database
    _audioHotKeys = await AudioHotKeyDatabase.instance.getAllAudioHotKeys();
    // read audio devices
    await _populateAudioDevices();
    // register hotkeys
    for (var audioHotKey in _audioHotKeys) {
      var hotKey = HotKey(
        audioHotKey.keyCode,
        modifiers: audioHotKey.modifiers,
        identifier: audioHotKey.id.toString(),
        scope: HotKeyScope.system,
      );
      await hotKeyManager.register(
        hotKey,
        keyDownHandler: (hotKey) => _setDefaultAudioDevice(hotKey),
      );
    }
  }

  Future<void> registerHotKey(AudioHotKey audioHotKey) async {
    var hotKey = HotKey(
      audioHotKey.keyCode,
      modifiers: audioHotKey.modifiers,
      identifier: audioHotKey.id.toString(),
      scope: HotKeyScope.system,
    );
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) => _setDefaultAudioDevice(hotKey),
    );

    _audioHotKeys = await AudioHotKeyDatabase.instance.getAllAudioHotKeys();
  }

  Future<void> unregisterHotKey(AudioHotKey audioHotKey) async {
    var hotKey = HotKey(
      audioHotKey.keyCode,
      modifiers: audioHotKey.modifiers,
      identifier: audioHotKey.id.toString(),
      scope: HotKeyScope.system,
    );
    await hotKeyManager.unregister(hotKey);

    _audioHotKeys = await AudioHotKeyDatabase.instance.getAllAudioHotKeys();
  }

  Future<void> _populateAudioDevices() async {
    _audioDevices = await Audio.enumDevices(AudioDeviceType.input) ?? [];
    _audioDevices.addAll(await Audio.enumDevices(AudioDeviceType.output) ?? []);
  }

  _setDefaultAudioDevice(HotKey hotKey) async {
    final audioHotKey = _audioHotKeys.firstWhereOrNull(
      (audioHotKey) => hotKey.identifier == audioHotKey.id.toString(),
    );
    if (audioHotKey != null) {
      await _switchAudioDevice(audioHotKey);
      await SystemTrayService().refreshTrayToolTip();
      await audioPlayer.play(AssetSource('pop_alert.mp3'));
    }
  }

  _switchAudioDevice(AudioHotKey audioHotKey) async {
    if (await _checkIfDeviceExists(audioHotKey.deviceGuid)) {
      await Audio.setDefaultDevice(
        audioHotKey.deviceGuid,
        communications: true,
        multimedia: true,
        console: true,
      );
    } else {
      debugPrint('Device with id ${audioHotKey.id} does not exist');
    }
  }

  Future<bool> _checkIfDeviceExists(String deviceGuid) async {
    var device = _audioDevices.firstWhereOrNull(
      (device) => device.id == deviceGuid.toString(),
    );
    if (device == null) {
      await _populateAudioDevices();
    }
    return _audioDevices.any((device) => device.id == deviceGuid.toString());
  }
}
