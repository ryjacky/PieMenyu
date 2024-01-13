import 'dart:isolate';

import 'package:pie_menyu/system/hooks/system_hook.dart';
import 'package:win32/win32.dart';

abstract class SystemHookIsolate {
  int _hookHandle = NULL;
  Isolate? _isolate;

  Future<void> startIsolated(SystemHook hook) async {
    final receivePort = ReceivePort();

    _isolate = await Isolate.spawn(
        (sendPort) => hook.start(sendPort), receivePort.sendPort);
    receivePort.listen((message) {
      if (message is int && _hookHandle == NULL) {
        _hookHandle = message;
      } else {
        onMessage(message);
      }
    });
  }

  void onMessage(dynamic message);

  void stop() {
    UnhookWindowsHookEx(_hookHandle);
    _isolate?.kill(priority: Isolate.immediate);
  }
}
