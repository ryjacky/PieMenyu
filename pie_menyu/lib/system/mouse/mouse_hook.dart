import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:ui';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'mouse_events.dart';

enum HookControl { unhook }

class MouseHook {
  final SendPort _sendPort;
  final ReceivePort _receivePort = ReceivePort();
  int _hookHandle = NULL;

  static Future<ReceivePort> isolated() async {
    final receivePort = ReceivePort();

    await Isolate.spawn((sendPort) => MouseHook._(sendPort), receivePort.sendPort);

    return receivePort;
  }

  MouseHook._(this._sendPort) {
    _sendPort.send(_receivePort.sendPort);
    _receivePort.listen((message) {
      if (message == HookControl.unhook){
        print("UNHOOK");
        UnhookWindowsHookEx(_hookHandle);
      }
      print("UNHOOK");

    });

    final callback = NativeCallable<CallWndProc>.isolateLocal(mouseHookProc,
        exceptionalReturn: 0);

    int hInst = GetModuleHandle(nullptr);
    _hookHandle =
        SetWindowsHookEx(WH_MOUSE_LL, callback.nativeFunction, hInst, NULL);
    final msg = calloc<MSG>();

    while (GetMessage(msg, NULL, 0, 0) != 0) {
      TranslateMessage(msg);
      DispatchMessage(msg);
    }

    calloc.free(msg);
  }

  int mouseHookProc(int nCode, int wParam, int lParam) {
    final pMouseStruct = Pointer<MOUSEHOOKSTRUCT>.fromAddress(lParam);
    if (nCode >= 0 && wParam == WM_MOUSEMOVE) {
      _sendPort.send(MouseEvent(position: Offset(pMouseStruct.ref.pt.x.toDouble(), pMouseStruct.ref.pt.y.toDouble())));
    }

    return CallNextHookEx(_hookHandle, nCode, wParam, lParam);
  }
}
