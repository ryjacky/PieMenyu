import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:pie_menyu/system/hooks/system_hook.dart';
import 'package:pie_menyu/system/hooks/system_hook_isolate.dart';
import 'package:win32/win32.dart';

class MouseHookIsolate extends SystemHookIsolate {
  static MouseHookIsolate? _instance;

  final List<Function(int, int)> _mouseMoveListeners = [];

  MouseHookIsolate._();

  factory MouseHookIsolate() {
    if (_instance == null) {
      _instance = MouseHookIsolate._();
      _instance!.startIsolated(MouseHook());
    }
    return _instance!;
  }

  addMouseMoveListener(Function(int, int) listener) {
    _mouseMoveListeners.add(listener);
  }

  @override
  void onMessage(message) {
    if (message is String){
      try {
        final pos = message.trim().split("\t");
        final x = int.parse(pos[0]);
        final y = int.parse(pos[1]);
        for (var listener in _mouseMoveListeners) {
          listener(x, y);
        }
      } catch (e) {
        log("Invalid mouse hook info: $message");
      }
    }
  }
}

class MouseHook extends SystemHook {
  SendPort? _sendPort;
  int _hookHandle = NULL;

  MouseHook();

  int mouseHookProc(int nCode, int wParam, int lParam) {
    final pMouseStruct = Pointer<MOUSEHOOKSTRUCT>.fromAddress(lParam);
    if (nCode >= 0 && wParam == WM_MOUSEMOVE) {
      _sendPort?.send("${pMouseStruct.ref.pt.x}\t${pMouseStruct.ref.pt.y}");
    }

    return CallNextHookEx(_hookHandle, nCode, wParam, lParam);
  }

  @override
  void start(SendPort sendPort) {
    _sendPort = sendPort;

    final callback = NativeCallable<CallWndProc>.isolateLocal(mouseHookProc,
        exceptionalReturn: 0);

    int hInst = GetModuleHandle(nullptr);
    _hookHandle =
        SetWindowsHookEx(WH_MOUSE_LL, callback.nativeFunction, hInst, NULL);
    _sendPort?.send(_hookHandle);

    final msg = calloc<MSG>();

    while (GetMessage(msg, NULL, 0, 0) != 0) {
      TranslateMessage(msg);
      DispatchMessage(msg);
    }

    calloc.free(msg);
  }
}
