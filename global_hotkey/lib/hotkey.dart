library global_hotkey;
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Hotkey {
  final LogicalKeySet keySet;
  final Set<String> context;

  Hotkey(this.keySet, {this.context = const <String>{}});

  factory Hotkey.fromKeyCode(
      int keyCode, {
        Set<String> context = const <String>{},
        bool ctrl = false,
        bool shift = false,
        bool alt = false,
      }) {
    LogicalKeyboardKey? key;
    if (Platform.isWindows) {
      key = kWindowsToLogicalKey[keyCode];
    } else if (Platform.isMacOS) {
    } else if (Platform.isLinux) {}

    if (key != null) {
      return Hotkey(
          LogicalKeySet(
            key,
            ctrl ? LogicalKeyboardKey.control : null,
            shift ? LogicalKeyboardKey.shift : null,
            alt ? LogicalKeyboardKey.alt : null,
          ),
          context: context);
    } else {
      throw Exception("Key not found");
    }
  }

  @override
  int get hashCode => keySet.hashCode ^ context.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is Hotkey) {
      return keySet == other.keySet && context == other.context;
    }
    return false;
  }
}
