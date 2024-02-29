import 'package:audio_pal/app/home.dart';
import 'package:audio_pal/window/windows_buttons.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class MainWindow extends StatelessWidget {
  const MainWindow({super.key});
  @override
  Widget build(BuildContext context) {
    var backgroundEndColor = Theme.of(context).colorScheme.secondary;
    var backgroundStartColor = Theme.of(context).colorScheme.primaryContainer;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [backgroundStartColor, backgroundEndColor],
            stops: const [0.0, 1.0]),
      ),
      child: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(
                  child: MoveWindow(),
                ),
                const WindowButtons(),
              ],
            ),
          ),
          const Expanded(
            child: MyHomePage(),
          ),
        ],
      ),
    );
  }
}
