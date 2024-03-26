library pie_menyu_core;

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:uni_platform/uni_platform.dart';
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
      if ((keyState & 0x8000) != 0) releaseKeyWindows(i);
    }

    // Free the allocated memory
    calloc.free(keyboardState);
  }

  void pressKeyWindows(int vKey) {
    final inputs = calloc<INPUT>(1);
    inputs[0].type = INPUT_KEYBOARD;
    inputs[0].ki.wVk = vKey;
    SendInput(1, inputs, sizeOf<INPUT>());
    calloc.free(inputs);
  }

  void releaseKeyWindows(int vKey) {
    final inputs = calloc<INPUT>(1);
    inputs[0].type = INPUT_KEYBOARD;
    inputs[0].ki.wVk = vKey;
    inputs[0].ki.dwFlags = KEYEVENTF_KEYUP;
    SendInput(1, inputs, sizeOf<INPUT>());
    calloc.free(inputs);
  }

  @override
  Future<void> execute() async {
    final platformKeyCode = key?.physicalKey?.keyCode;
    if (platformKeyCode == null) return;

    if (Platform.isWindows) {
      releasePressedKeysWindows();

      if (ctrl) pressKeyWindows(VK_CONTROL);
      if (shift) pressKeyWindows(VK_SHIFT);
      if (alt) pressKeyWindows(VK_MENU);
      pressKeyWindows(platformKeyCode);

      releaseKeyWindows(platformKeyCode);
      if (alt) releaseKeyWindows(VK_MENU);
      if (shift) releaseKeyWindows(VK_SHIFT);
      if (ctrl) releaseKeyWindows(VK_CONTROL);
    } else if (Platform.isMacOS) {
    } else if (Platform.isLinux) {}
  }
}
