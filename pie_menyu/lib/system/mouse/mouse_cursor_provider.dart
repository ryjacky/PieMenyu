import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pie_menyu/system/system_hook.dart';
import 'package:window_manager/window_manager.dart';

import 'mouse_events.dart';

class MouseCursorProvider extends ChangeNotifier {
  MouseEvent _mouseEvent = MouseEvent(position: Offset.zero);

  MouseCursorProvider() {
    initializeMouseHook();
  }

  MouseEvent get mouseEvent => _mouseEvent;

  void initializeMouseHook() async {
    Stream out = await SystemHook.isolated(HookTypes.mouse);
    out.listen((event) async {
      if (!await windowManager.isFocused()) {
        return;
      }

      try {
        List<String> pos = event.toString().trim().split("\t");
        _mouseEvent = MouseEvent(position: Offset(double.parse(pos[0]), double.parse(pos[1])));
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
