//create a singleton class to manage the system tray

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:system_tray/system_tray.dart';
import 'package:win32audio/win32audio.dart';

class SystemTrayService {
  static final SystemTrayService _instance = SystemTrayService._internal();

  SystemTrayService._internal() {
    _initSystemTray();
  }

  factory SystemTrayService() {
    return _instance;
  }

  final SystemTray _systemTray = SystemTray();
  final Menu _menuSimple = Menu();
  final AppWindow _appWindow = AppWindow();

  Future<void> _initSystemTray() async {
    await _systemTray.initSystemTray(iconPath: getTrayImagePath());
    _systemTray.setTitle("system tray");

    await _systemTray.setToolTip(await getTrayToolTipString());

    // handle system tray event
    _systemTray.registerSystemTrayEventHandler((eventName) {
      debugPrint("eventName: $eventName");
      if (eventName == kSystemTrayEventClick) {
        Platform.isWindows ? _appWindow.show() : _systemTray.popUpContextMenu();
      } else if (eventName == kSystemTrayEventRightClick) {
        Platform.isWindows ? _systemTray.popUpContextMenu() : _appWindow.show();
      }
    });

    await _menuSimple.buildFrom([
      MenuItemLabel(
          label: 'Show',
          image: getImagePath(),
          onClicked: (menuItem) => _appWindow.show()),
      MenuItemLabel(
          label: 'Hide',
          image: getImagePath(),
          onClicked: (menuItem) => _appWindow.hide()),
      MenuItemLabel(
        label: 'Exit',
        image: getImagePath(),
        onClicked: (menuItem) => _appWindow.close(),
      ),
    ]);

    _systemTray.setContextMenu(_menuSimple);
  }

  Future<String> getTrayToolTipString() async {
    final defaultInputDevice =
        await Audio.getDefaultDevice(AudioDeviceType.input);
    final defaultOutputDevice =
        await Audio.getDefaultDevice(AudioDeviceType.output);
    return "Audio Pal\nInput: ${defaultInputDevice?.name}\nOutput: ${defaultOutputDevice?.name}";
  }

  String getTrayImagePath() {
    return Platform.isWindows
        ? 'assets/AudioPalLogo.ico'
        : 'assets/AudioPalLogo.png';
  }

  String getImagePath() {
    return Platform.isWindows
        ? 'assets/AudioPalLogo.ico'
        : 'assets/AudioPalLogo.png';
  }

  Future<void> refreshTrayToolTip() async {
    _systemTray.setToolTip(await getTrayToolTipString());
  }
}
