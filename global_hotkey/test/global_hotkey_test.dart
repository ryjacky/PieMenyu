import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:global_hotkey/global_hotkey.dart';
import 'package:global_hotkey/hotkey.dart';
import 'package:global_hotkey/hotkey_event.dart';
import 'package:win32/win32.dart';
import 'dart:ffi';

void main() {
  group('GlobalHotkey', () {
    late GlobalHotkey hotkey;

    setUp(() {
      hotkey = GlobalHotkey.initialize({
        Hotkey(LogicalKeySet(LogicalKeyboardKey.keyA, LogicalKeyboardKey.control), context: "C:\\Program Files\\JetBrains\\IntelliJ IDEA 2024.1\\bin\\idea64.exe"),
        Hotkey(LogicalKeySet(LogicalKeyboardKey.keyF), context: "C:\\Program Files\\JetBrains\\IntelliJ IDEA 2024.1\\bin\\idea64.exe"),
      });

    });

    test('keyUp adds KeyEvent to stream', () async {


      hotkey.keyEvents.listen(
              (HotkeyEvent e) {
            if (e.type == HotkeyEventType.hotkeyTriggered) {
              print("Hotkey triggered: ${e.hotkey.keySet.keys}");
            } else if (e.type == HotkeyEventType.hotkeyReleased) {
              print("Hotkey released: ${e.hotkey.keySet.keys}");

            }
          }
      );


      await Future.delayed(Duration(seconds: 5), () {
        print("end of test");
        //send Control, shift, alt and windows and e, x, i, t, p , m, n,y, u,s
        final kbd = calloc<INPUT>();
        kbd.ref.type = INPUT_TYPE.INPUT_KEYBOARD;
        kbd.ref.ki.wVk = 0xE8;
        SendInput(1, kbd, sizeOf<INPUT>());
        kbd.ref.ki.dwFlags = KEYBD_EVENT_FLAGS.KEYEVENTF_KEYUP;
        SendInput(1, kbd, sizeOf<INPUT>());
      });
    });



    tearDown(() {
      hotkey.dispose();

    });
  });
}