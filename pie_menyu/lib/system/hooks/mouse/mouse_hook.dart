import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

class MouseHookIsolate {
  static MouseHookIsolate? _mouseHookIsolate;

  int _hookHandle = NULL;
  Isolate? _isolate;
  final List<Function(int, int)> _mouseMoveListeners = [];

  factory MouseHookIsolate() {
    if (_mouseHookIsolate == null) {
      _mouseHookIsolate = MouseHookIsolate._();
      _mouseHookIsolate!._startIsolated();
    }
    return _mouseHookIsolate!;
  }

  MouseHookIsolate._();

  addMouseMoveListener(Function(int, int) listener) {
    _mouseMoveListeners.add(listener);
  }

  Future<void> _startIsolated() async {
    final receivePort = ReceivePort();

    _isolate = await Isolate.spawn((sendPort) => MouseHook._(sendPort), receivePort.sendPort);
    receivePort.listen((message) {
      if (message is int){
        _hookHandle = message;
      }
      else if (message is String){
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
    });

  }

  void stop(){
    if (_mouseHookIsolate != null){
      UnhookWindowsHookEx(_mouseHookIsolate!._hookHandle);
      _mouseHookIsolate!._isolate?.kill(priority: Isolate.immediate);
      _mouseHookIsolate = null;
    }
  }
}

class MouseHook {
  final SendPort _sendPort;
  int _hookHandle = NULL;

  MouseHook._(this._sendPort) {
    final callback = NativeCallable<CallWndProc>.isolateLocal(mouseHookProc,
        exceptionalReturn: 0);

    int hInst = GetModuleHandle(nullptr);
    _hookHandle =
        SetWindowsHookEx(WH_MOUSE_LL, callback.nativeFunction, hInst, NULL);
    _sendPort.send(_hookHandle);

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
      _sendPort.send("${pMouseStruct.ref.pt.x}\t${pMouseStruct.ref.pt.y}");
    }

    return CallNextHookEx(_hookHandle, nCode, wParam, lParam);
  }
}
