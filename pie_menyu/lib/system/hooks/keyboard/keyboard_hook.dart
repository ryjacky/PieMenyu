import 'dart:developer';
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'keyboard_event.dart';

class KeyboardHookIsolate {
  static KeyboardHookIsolate? _keyboardHookIsolate;

  int _hookHandle = NULL;
  Isolate? _isolate;
  final List<Function(int, int)> _mouseMoveListeners = [];

  factory KeyboardHookIsolate() {
    if (_keyboardHookIsolate == null) {
      _keyboardHookIsolate = KeyboardHookIsolate._();
      _keyboardHookIsolate!._startIsolated();
    }
    return _keyboardHookIsolate!;
  }

  KeyboardHookIsolate._();

  addMouseMoveListener(Function(int, int) listener) {
    _mouseMoveListeners.add(listener);
  }

  Future<void> _startIsolated() async {
    final receivePort = ReceivePort();

    _isolate = await Isolate.spawn((sendPort) => KeyboardHook._(sendPort), receivePort.sendPort);
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
    if (_keyboardHookIsolate != null){
      UnhookWindowsHookEx(_keyboardHookIsolate!._hookHandle);
      _keyboardHookIsolate!._isolate?.kill(priority: Isolate.immediate);
      _keyboardHookIsolate = null;
    }
  }
}
class KeyboardHook {
  final SendPort _sendPort;
  int _hookHandle = NULL;

  KeyboardHook._(this._sendPort) {
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
