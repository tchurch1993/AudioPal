import 'package:flutter/services.dart';

enum Modifier { none, alt, ctrl, shift, noRepeat, windows }

extension KeyModifierExtension on Modifier {
  int get value {
    switch (this) {
      case Modifier.none:
        return 0x0000;
      case Modifier.alt:
        return 0x0001;
      case Modifier.ctrl:
        return 0x0002;
      case Modifier.shift:
        return 0x0004;
      case Modifier.noRepeat:
        return 0x4000;
      case Modifier.windows:
        return 0x0008;
      default:
        return 0x0000;
    }
  }
}

// get from logicalKeyboardKey
extension KeyModifierFromLogicalKeyboardKey on LogicalKeyboardKey {
  Modifier get modifier {
    switch (this) {
      case LogicalKeyboardKey.alt:
        return Modifier.alt;
      case LogicalKeyboardKey.control:
        return Modifier.ctrl;
      case LogicalKeyboardKey.shift:
        return Modifier.shift;
      case LogicalKeyboardKey.meta:
        return Modifier.windows;
      default:
        return Modifier.none;
    }
  }
}

extension KeyModifierFromModifier on Modifier {
  LogicalKeyboardKey? get logicalKeyboardKey {
    switch (this) {
      case Modifier.alt:
        return LogicalKeyboardKey.alt;
      case Modifier.ctrl:
        return LogicalKeyboardKey.control;
      case Modifier.shift:
        return LogicalKeyboardKey.shift;
      case Modifier.windows:
        return LogicalKeyboardKey.meta;
      default:
        return null;
    }
  }
}
