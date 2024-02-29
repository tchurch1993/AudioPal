// create a light and dark theme data object

import 'package:flutter/material.dart';

// create an app theme class with light and dark theme data based off of a seed color passed in.

Color _seedColor = Color.fromARGB(255, 27, 140, 185);

class AppTheme {
  static Color get seedColor => _seedColor;

  static set seedColor(Color color) => _seedColor = color;

  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor, brightness: Brightness.light),
      brightness: Brightness.light,
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor, brightness: Brightness.dark),
      brightness: Brightness.dark,
      useMaterial3: true,
    );
  }
}
