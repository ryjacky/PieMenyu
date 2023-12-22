import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:pie_menyu/system/keyboard/keyboard_event.dart';

import 'keyboard_hook.dart';

class KeyboardProvider extends ChangeNotifier {
  Offset cursorPosition = Offset.zero;
  ReceivePort? _receivePort;
  SendPort? _sendPort;

  KeyboardProvider(){
    initializeKeyboardHook();
  }

  void initializeKeyboardHook() async {
    _receivePort = await KeyboardHook.isolated();
    _receivePort!.listen((event) {
      if (event is SendPort) {
        _sendPort = event;
      }
      log("FROM ISOLATE: ${(event)}");

    });
  }

  @override
  void dispose() {
    _sendPort?.send(KeyboardHookControl.unhook);
    super.dispose();
  }

}
