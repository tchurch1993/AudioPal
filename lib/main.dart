import 'package:audio_pal/services/audio_device_service.dart';
import 'package:audio_pal/services/system_tray_service.dart';
import 'package:audio_pal/theme/theme.dart';
import 'package:audio_pal/window/main_window.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;

  AudioDeviceService().registerHotKeys();

  appWindow.size = const Size(600, 450);
  appWindow.alignment = Alignment.center;
  appWindow.title = 'Audio Pal';
  appWindow.minSize = const Size(600, 450);
  runApp(const MyApp());
  doWhenWindowReady(() {
    appWindow.show();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  // TODO: maybe make this into a service or something?
  static void setTheme(BuildContext context, Color newColor) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('color', newColor.value);
    });
    state.setState(() {
      state.theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: newColor, brightness: Brightness.dark),
        brightness: Brightness.dark,
      );
    });
  }
}

class _MyAppState extends State<MyApp> {
  var theme = AppTheme.darkTheme();

  @override
  void initState() {
    super.initState();
    // TODO: should probably move all of these services from singletons to GetIt or something
    SystemTrayService();
    SharedPreferences.getInstance().then((prefs) {
      final color = prefs.getInt('color');
      if (color != null) {
        setState(() {
          theme = ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(color),
              brightness: Brightness.dark,
            ),
            brightness: Brightness.dark,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audio Pal',
      theme: theme,
      themeAnimationCurve: Curves.fastOutSlowIn,
      // animation for when window shows
      home: WindowBorder(
        width: 1,
        color: theme.primaryColor,
        child: const MainWindow(),
      ),
    );
  }
}
