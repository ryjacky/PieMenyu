import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class MouseCursorProvider extends ChangeNotifier {
  Offset _mouseCursorPosition = Offset.zero;
  bool trackMouseMove;
  static Process? _mouseHookProc;

  MouseCursorProvider({required this.trackMouseMove}) {
    if (_mouseHookProc == null) {
      _initializeMouseHook();
    }
  }

  _initializeMouseHook() async {
    _mouseHookProc = await Process.start(
        p.join(Directory(Platform.resolvedExecutable).parent.path, "data",
            "flutter_assets", "support", "mouseHook.exe"),
        []);

    await _mouseHookProc!.stdout.transform(utf8.decoder).forEach((element) async {
      if (!trackMouseMove) {
        return;
      }

      try {
        List<String> parts = element.trim().split("\t");
        _mouseCursorPosition = Offset(double.parse(parts[0]), double.parse(parts[1]));
        notifyListeners();
      } catch (e) {
        log("Invalid mouse hook info: $element");
      }
    });
  }

  Offset get cursorPosition => _mouseCursorPosition;

}