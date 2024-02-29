import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowButtons extends StatefulWidget {
  const WindowButtons({super.key});

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(
      () {
        appWindow.maximizeOrRestore();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColors = WindowButtonColors(
      iconNormal: theme.colorScheme.primary,
      mouseOver: theme.colorScheme.secondary.withOpacity(0.5),
      mouseDown: theme.colorScheme.secondary,
      normal: theme.colorScheme.primaryContainer.withOpacity(0.5),
      iconMouseOver: theme.colorScheme.primary,
      iconMouseDown: theme.colorScheme.secondaryContainer,
    );

    final closeButtonColors = WindowButtonColors(
      mouseOver: theme.colorScheme.error.withOpacity(0.5),
      mouseDown: theme.colorScheme.errorContainer,
      normal: theme.colorScheme.primaryContainer.withOpacity(0.5),
      iconMouseOver: theme.colorScheme.onError,
      iconNormal: theme.colorScheme.primary,
    );
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        appWindow.isMaximized
            ? RestoreWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
                animate: true,
              )
            : MaximizeWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
                animate: true,
              ),
        CloseWindowButton(
          colors: closeButtonColors,
          animate: true,
        ),
      ],
    );
  }
}
