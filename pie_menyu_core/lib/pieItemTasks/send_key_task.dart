library pie_menyu_core;

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:win32/win32.dart';

import '../executor/executable.dart';

class SendKeyTask extends PieItemTask with Executable {
  final Map<LogicalKeyboardKey, int> _logicalKeyVKey = {
    LogicalKeyboardKey.keyA: 65,
    LogicalKeyboardKey.numpadAdd: 107,
    // LogicalKeyboardKey.alt: 262144,
    LogicalKeyboardKey.numpadEnter: 93,
    LogicalKeyboardKey.attn: 246,
    LogicalKeyboardKey.keyB: 66,
    LogicalKeyboardKey.backspace: 8,
    LogicalKeyboardKey.browserBack: 166,
    LogicalKeyboardKey.browserFavorites: 171,
    LogicalKeyboardKey.browserForward: 167,
    LogicalKeyboardKey.browserHome: 172,
    LogicalKeyboardKey.browserRefresh: 168,
    LogicalKeyboardKey.browserSearch: 170,
    LogicalKeyboardKey.browserStop: 169,
    LogicalKeyboardKey.keyC: 67,
    LogicalKeyboardKey.cancel: 3,
    LogicalKeyboardKey.shift: 20,
    LogicalKeyboardKey.capsLock: 20,
    LogicalKeyboardKey.clear: 12,
    // LogicalKeyboardKey.control:131072,
    // LogicalKeyboardKey.control:17,
    LogicalKeyboardKey.crSel: 247,
    LogicalKeyboardKey.keyD: 68,
    LogicalKeyboardKey.digit0: 48,
    LogicalKeyboardKey.digit1: 49,
    LogicalKeyboardKey.digit2: 50,
    LogicalKeyboardKey.digit3: 51,
    LogicalKeyboardKey.digit4: 52,
    LogicalKeyboardKey.digit5: 53,
    LogicalKeyboardKey.digit6: 54,
    LogicalKeyboardKey.digit7: 55,
    LogicalKeyboardKey.digit8: 56,
    LogicalKeyboardKey.digit9: 57,
    LogicalKeyboardKey.numpadDecimal: 110,
    LogicalKeyboardKey.delete: 46,
    LogicalKeyboardKey.numpadDivide: 111,
    LogicalKeyboardKey.arrowDown: 40,
    LogicalKeyboardKey.keyE: 69,
    LogicalKeyboardKey.end: 35,
    LogicalKeyboardKey.enter: 13,
    LogicalKeyboardKey.eraseEof: 249,
    LogicalKeyboardKey.escape: 27,
    LogicalKeyboardKey.execute: 43,
    LogicalKeyboardKey.exSel: 248,
    LogicalKeyboardKey.keyF: 70,
    LogicalKeyboardKey.f1: 112,
    LogicalKeyboardKey.f10: 121,
    LogicalKeyboardKey.f11: 122,
    LogicalKeyboardKey.f12: 123,
    LogicalKeyboardKey.f13: 124,
    LogicalKeyboardKey.f14: 125,
    LogicalKeyboardKey.f15: 126,
    LogicalKeyboardKey.f16: 127,
    LogicalKeyboardKey.f17: 128,
    LogicalKeyboardKey.f18: 129,
    LogicalKeyboardKey.f19: 130,
    LogicalKeyboardKey.f2: 113,
    LogicalKeyboardKey.f20: 131,
    LogicalKeyboardKey.f21: 132,
    LogicalKeyboardKey.f22: 133,
    LogicalKeyboardKey.f23: 134,
    LogicalKeyboardKey.f24: 135,
    LogicalKeyboardKey.f3: 114,
    LogicalKeyboardKey.f4: 115,
    LogicalKeyboardKey.f5: 116,
    LogicalKeyboardKey.f6: 117,
    LogicalKeyboardKey.f7: 118,
    LogicalKeyboardKey.f8: 119,
    LogicalKeyboardKey.f9: 120,
    LogicalKeyboardKey.finalMode: 24,
    LogicalKeyboardKey.keyG: 71,
    LogicalKeyboardKey.keyH: 72,
    LogicalKeyboardKey.hangulMode: 21,
    LogicalKeyboardKey.hanjaMode: 25,
    LogicalKeyboardKey.help: 47,
    LogicalKeyboardKey.home: 36,
    LogicalKeyboardKey.keyI: 73,
    LogicalKeyboardKey.accept: 30,
    LogicalKeyboardKey.convert: 28,
    LogicalKeyboardKey.nonConvert: 29,
    LogicalKeyboardKey.insert: 45,
    LogicalKeyboardKey.keyJ: 74,
    LogicalKeyboardKey.junjaMode: 23,
    LogicalKeyboardKey.keyK: 75,
    LogicalKeyboardKey.kanaMode: 21,
    LogicalKeyboardKey.kanjiMode: 25,
    LogicalKeyboardKey.unidentified: 65535,
    LogicalKeyboardKey.keyL: 76,
    LogicalKeyboardKey.launchApplication1: 182,
    LogicalKeyboardKey.launchApplication2: 183,
    LogicalKeyboardKey.launchMail: 180,
    // LogicalKeyboardKey.mouseLeft:1,
    LogicalKeyboardKey.controlLeft: 162,
    LogicalKeyboardKey.arrowLeft: 37,
    LogicalKeyboardKey.altLeft: 164,
    LogicalKeyboardKey.shiftLeft: 160,
    LogicalKeyboardKey.metaLeft: 91,
    LogicalKeyboardKey.keyM: 77,
    // LogicalKeyboardKey.mouseMiddle:4,
    LogicalKeyboardKey.mediaTrackNext: 176,
    LogicalKeyboardKey.mediaPlayPause: 179,
    LogicalKeyboardKey.mediaTrackPrevious: 177,
    LogicalKeyboardKey.mediaStop: 178,
    LogicalKeyboardKey.contextMenu: 18,
    // LogicalKeyboardKey.ctrlAltShift:-65536,
    LogicalKeyboardKey.numpadMultiply: 106,
    LogicalKeyboardKey.keyN: 78,
    LogicalKeyboardKey.pageDown: 34,
    // LogicalKeyboardKey.unidentified:252,
    // LogicalKeyboardKey.unidentified:0,
    LogicalKeyboardKey.numLock: 144,
    LogicalKeyboardKey.numpad0: 96,
    LogicalKeyboardKey.numpad1: 97,
    LogicalKeyboardKey.numpad2: 98,
    LogicalKeyboardKey.numpad3: 99,
    LogicalKeyboardKey.numpad4: 100,
    LogicalKeyboardKey.numpad5: 101,
    LogicalKeyboardKey.numpad6: 102,
    LogicalKeyboardKey.numpad7: 103,
    LogicalKeyboardKey.numpad8: 104,
    LogicalKeyboardKey.numpad9: 105,
    LogicalKeyboardKey.keyO: 79,
    LogicalKeyboardKey.semicolon: 186,
    LogicalKeyboardKey.backslash: 226,
    LogicalKeyboardKey.slash: 191,
    LogicalKeyboardKey.tilde: 192,
    LogicalKeyboardKey.bracketLeft: 219,
    LogicalKeyboardKey.bracketRight: 221,
    // LogicalKeyboardKey.clear:254,
    LogicalKeyboardKey.comma: 188,
    LogicalKeyboardKey.minus: 189,
    LogicalKeyboardKey.period: 190,
    LogicalKeyboardKey.add: 187,
    // LogicalKeyboardKey.slash:191,
    LogicalKeyboardKey.quote: 222,
    LogicalKeyboardKey.keyP: 80,
    LogicalKeyboardKey.pause: 19,
    LogicalKeyboardKey.pageUp: 33,
    LogicalKeyboardKey.print: 42,
    LogicalKeyboardKey.printScreen: 44,
    LogicalKeyboardKey.keyQ: 81,
    LogicalKeyboardKey.keyR: 82,
    // LogicalKeyboardKey.mouseRight:2,
    LogicalKeyboardKey.controlRight: 163,
    LogicalKeyboardKey.arrowRight: 39,
    LogicalKeyboardKey.altRight: 165,
    LogicalKeyboardKey.shiftRight: 161,
    LogicalKeyboardKey.metaRight: 92,
    LogicalKeyboardKey.keyS: 83,
    // LogicalKeyboardKey.scro:145,
    LogicalKeyboardKey.select: 41,
    // LogicalKeyboardKey.media:181,
    // LogicalKeyboardKey.shift:65536,
    // LogicalKeyboardKey.shift:16,
    LogicalKeyboardKey.sleep: 95,
    LogicalKeyboardKey.space: 32,
    LogicalKeyboardKey.numpadSubtract: 109,
    LogicalKeyboardKey.keyT: 84,
    LogicalKeyboardKey.tab: 9,
    LogicalKeyboardKey.keyU: 85,
    LogicalKeyboardKey.arrowUp: 38,
    LogicalKeyboardKey.keyV: 86,
    LogicalKeyboardKey.audioVolumeDown: 174,
    LogicalKeyboardKey.audioVolumeMute: 173,
    LogicalKeyboardKey.audioVolumeUp: 175,
    LogicalKeyboardKey.keyW: 87,
    LogicalKeyboardKey.keyX: 88,
    LogicalKeyboardKey.keyY: 89,
    LogicalKeyboardKey.keyZ: 90,
    LogicalKeyboardKey.zoomToggle: 251,
  };

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
    if (Platform.isWindows) {
      releasePressedKeysWindows();

      if (key == null || _logicalKeyVKey[key] == null) return;

      if (ctrl) pressKeyWindows(VK_CONTROL);
      if (shift) pressKeyWindows(VK_SHIFT);
      if (alt) pressKeyWindows(VK_MENU);
      pressKeyWindows(_logicalKeyVKey[key]!);

      releaseKeyWindows(_logicalKeyVKey[key]!);
      if (alt) releaseKeyWindows(VK_MENU);
      if (shift) releaseKeyWindows(VK_SHIFT);
      if (ctrl) releaseKeyWindows(VK_CONTROL);
    } else if (Platform.isMacOS) {
    } else if (Platform.isLinux) {}
  }
}
