import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/material.dart';

import 'mouse_hook.dart';

class MouseCursorProvider extends ChangeNotifier {
  Offset cursorPosition = Offset.zero;
  ReceivePort? _receivePort;
  SendPort? _sendPort;

  MouseCursorProvider(){
    initializeMouseHook();
  }

  void initializeMouseHook() async {
    _receivePort = await MouseHook.isolated();
    _receivePort!.listen((event) {
      if (event is SendPort) {
        _sendPort = event;
      }
      log("FROM ISOLATE: $event");
    });
  }

  @override
  void dispose() {
    _sendPort?.send(HookControl.unhook);
    super.dispose();
  }

}
