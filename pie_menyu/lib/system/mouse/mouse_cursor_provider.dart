import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pie_menyu/system/system_hook.dart';
import 'package:window_manager/window_manager.dart';

class MouseCursorProvider extends ChangeNotifier {
  Offset cursorPosition = Offset.zero;

  MouseCursorProvider() {
    initializeMouseHook();
  }

  void initializeMouseHook() async {
    // _receivePort = await MouseHook.isolated();
    // _receivePort!.listen((event) async {
    //   if (event is SendPort) {
    //     _sendPort = event;
    //   }
    //
    //   if (!await windowManager.isFocused()) {
    //     return;
    //   }
    //
    //   if (event is MouseMoveEvent){
    //     cursorPosition = Offset(event.x.toDouble(), event.y.toDouble());
    //   }
    //   notifyListeners();
    // });

    Stream out = await SystemHook.isolated(HookTypes.mouse);
    out.listen((event) async {
      if (!await windowManager.isFocused()) {
        return;
      }

      try {
        List<String> pos = event.toString().trim().split("\t");
        cursorPosition = Offset(double.parse(pos[0]), double.parse(pos[1]));
        notifyListeners();
      } catch (e) {
        log("Invalid mouse hook info: $event");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
