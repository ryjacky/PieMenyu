library global_hotkey;

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:win32/win32.dart';
import 'package:ffi/ffi.dart';
import 'dart:ffi';

import 'hotkey.dart';
import 'hotkey_event.dart';
import 'windows_hotkey_manager.dart';

class GlobalHotkey {
  static const dwExtraInfoIgnoreFlag = 195833;
  static GlobalHotkey? _instance;

  Isolate? _hotkeyManagerIsolate;
  final StreamController<HotkeyEvent> _controller =
      StreamController<HotkeyEvent>.broadcast();

  Stream<HotkeyEvent> get keyEvents => _controller.stream;
  static GlobalHotkey get instance {
    return _instance ?? (throw Exception("GlobalHotkey not initialized, make sure you have called GlobalHotkey.initialize() first."));
  }

  factory GlobalHotkey.initialize(Set<Hotkey> hotkeys) {
    return _instance ??= GlobalHotkey._(hotkeys);
  }

  GlobalHotkey._(Set<Hotkey> hotkeys) {
    if (Platform.isWindows) {
      startWindowsHotkeyManagerIsolated(hotkeys);
    }
  }

  void dispose() {
    _controller.close();
    final kbd = calloc<INPUT>();
    kbd.ref.type = INPUT_TYPE.INPUT_KEYBOARD;
    kbd.ref.ki.wVk = 0xE8;
    SendInput(1, kbd, sizeOf<INPUT>());
    kbd.ref.ki.dwFlags = KEYBD_EVENT_FLAGS.KEYEVENTF_KEYUP;
    SendInput(1, kbd, sizeOf<INPUT>());

  }

  void startWindowsHotkeyManagerIsolated(Set<Hotkey> hotkeys) async {
    final receivePort = ReceivePort();
    _hotkeyManagerIsolate = await Isolate.spawn(
        (port) => WindowsHotkeyManager(port, hotkeys), receivePort.sendPort);

    receivePort.listen((message) {
      if (message is HotkeyEvent) _controller.add(message);
      if (message == null) {
        _controller.close();
        _instance = null;
      }
    });

  }
}
