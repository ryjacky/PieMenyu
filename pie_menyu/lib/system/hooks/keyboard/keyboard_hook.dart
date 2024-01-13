import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu/system/hooks/system_hook_isolate.dart';
import 'package:win32/win32.dart';

import '../system_hook.dart';
import 'keyboard_event.dart';

class KeyboardHookIsolate extends SystemHookIsolate {
  static KeyboardHookIsolate? _keyboardHookIsolate;

  final List<Function()> _keyUpListener = [];

  factory KeyboardHookIsolate(List<HotKey> hotkeyList) {
    if (_keyboardHookIsolate == null) {
      _keyboardHookIsolate = KeyboardHookIsolate._();
      _keyboardHookIsolate!.startIsolated(KeyboardHook()..hotKeyList = hotkeyList);
    }
    return _keyboardHookIsolate!;
  }

  KeyboardHookIsolate._();

  addKeyUpListener(Function() listener) {
    _keyUpListener.add(listener);
  }

  @override
  void onMessage(message) {
    if (message is KeyboardEvent) {
      if (message.type == KeyboardEventType.keyUp) {
        for (var listener in _keyUpListener) {
          listener();
        }
      }
    }
  }
}

class KeyboardHook extends SystemHook {
  List<HotKey> hotKeyList = [];
  int mouseHookProc(int nCode, int wParam, int lParam) {
    final pKeyboardStruct = Pointer<KBDLLHOOKSTRUCT>.fromAddress(lParam);
    if (wParam == WM_KEYDOWN || wParam == WM_SYSKEYDOWN) {
      sendPort?.send(
          KeyboardEvent(KeyboardEventType.keyDown, pKeyboardStruct.ref.vkCode));
    } else if (wParam == WM_KEYUP || wParam == WM_SYSKEYUP) {
      sendPort?.send(
          KeyboardEvent(KeyboardEventType.keyUp, pKeyboardStruct.ref.vkCode));
    }
    return CallNextHookEx(hookHandle, nCode, wParam, lParam);
  }

  @override
  void start(SendPort sendPort) {
    this.sendPort = sendPort;
    final callback = NativeCallable<CallWndProc>.isolateLocal(mouseHookProc,
        exceptionalReturn: 0);

    int hInst = GetModuleHandle(nullptr);
    hookHandle =
        SetWindowsHookEx(WH_KEYBOARD_LL, callback.nativeFunction, hInst, NULL);
    sendPort.send(hookHandle);
    final msg = calloc<MSG>();

    while (GetMessage(msg, NULL, 0, 0) != 0) {
      TranslateMessage(msg);
      DispatchMessage(msg);
    }

    calloc.free(msg);
  }
}
