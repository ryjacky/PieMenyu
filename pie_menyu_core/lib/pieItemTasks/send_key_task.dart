library pie_menyu_core;

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auto_gui/flutter_auto_gui.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:win32/win32.dart';

import '../executor/executable.dart';

class SendKeyTask extends PieItemTask with Executable {
  SendKeyTask() : super(taskType: PieItemTaskType.sendKey) {
    _fieldCheck();
  }

  SendKeyTask.from(super.pieItemTask) : super.from() {
    _fieldCheck();
  }

  _fieldCheck() {
    if (arguments.length != 4) {
      arguments = ["", "", "", ""];
    }
    taskType = PieItemTaskType.sendKey;
  }

  set ctrl(bool value) {
    arguments[0] = value.toString();
  }

  bool get ctrl => arguments[0] == "true";

  set shift(bool value) {
    arguments[1] = value.toString();
  }

  bool get shift => arguments[1] == "true";

  set alt(bool value) {
    arguments[2] = value.toString();
  }

  bool get alt => arguments[2] == "true";

  set key(LogicalKeyboardKey? value) {
    if (value != null) arguments[3] = value.keyId.toString();
  }

  LogicalKeyboardKey? get key {
    final keyId = int.tryParse(arguments[3]);
    if (keyId == null) return null;
    return LogicalKeyboardKey(keyId);
  }

  List<String> get hotkeyStrings {
    final keys = <String>[];

    if (ctrl) keys.add("Ctrl");
    if (shift) keys.add("Shift");
    if (alt) keys.add("Alt");

    keys.add(key?.keyLabel ?? "");
    return keys;
  }

  void releasePressedKeysWindows() {
    // Get the state of all keys
    final keyboardState = calloc<BYTE>(256);
    GetKeyboardState(keyboardState);

    // Release all keys that are currently pressed
    for (var i = 0; i < 256; i++) {
      final keyState = GetAsyncKeyState(i);

      // Release the key if it is currently being pressed
      if ((keyState & 0x8000) != 0) {
        final inputs = calloc<INPUT>(1);
        inputs[0].type = INPUT_KEYBOARD;
        inputs[0].ki.wVk = i;
        inputs[0].ki.dwFlags = KEYEVENTF_KEYUP;
        SendInput(1, inputs, sizeOf<INPUT>());
        calloc.free(inputs);
      }
    }

    // Free the allocated memory
    calloc.free(keyboardState);
  }

  @override
  Future<void> execute() async {
    if (Platform.isWindows) {
      releasePressedKeysWindows();
    } else if (Platform.isMacOS) {} else if (Platform.isLinux) {

    }
    final keys = hotkeyStrings.map((e) => e.toLowerCase()).toList();

    await FlutterAutoGUI.hotkey(
        keys: keys, interval: const Duration(milliseconds: 10));
    // I've spent so much time debugging this and find out that
    // FlutterAutoGUI.hotkey is a fake future that returns before hotkey
    // is pressed.
    await Future.delayed(const Duration(milliseconds: 50));
  }
}
