import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'keyboard_event.dart';

enum KeyboardHookControl { unhook }

class KeyboardHook {
  final SendPort _sendPort;
  final ReceivePort _receivePort = ReceivePort();
  int _hookHandle = NULL;

  static Future<ReceivePort> isolated() async {
    final receivePort = ReceivePort();

    Isolate.spawn((sendPort) => KeyboardHook._(sendPort), receivePort.sendPort);

    return receivePort;
  }

  KeyboardHook._(this._sendPort) {
    _sendPort.send(_receivePort.sendPort);
    _receivePort.listen((message) {
      if (message == KeyboardHookControl.unhook){
        UnhookWindowsHookEx(_hookHandle);
      }
    });

    final callback = NativeCallable<CallWndProc>.isolateLocal(mouseHookProc,
        exceptionalReturn: 0);

    int hInst = GetModuleHandle(nullptr);
    _hookHandle =
        SetWindowsHookEx(WH_KEYBOARD_LL, callback.nativeFunction, hInst, NULL);
    final msg = calloc<MSG>();

    while (GetMessage(msg, NULL, 0, 0) != 0) {
      TranslateMessage(msg);
      DispatchMessage(msg);
    }

    calloc.free(msg);
  }

  int mouseHookProc(int nCode, int wParam, int lParam) {
    final pKeyboardStruct = Pointer<KBDLLHOOKSTRUCT>.fromAddress(lParam);
    if (wParam == WM_KEYUP || wParam == WM_SYSKEYUP) {
      _sendPort.send(KeyboardEvent(KeyboardEventType.keyUp, pKeyboardStruct.ref.vkCode));
    }
    return CallNextHookEx(_hookHandle, nCode, wParam, lParam);
  }
}
