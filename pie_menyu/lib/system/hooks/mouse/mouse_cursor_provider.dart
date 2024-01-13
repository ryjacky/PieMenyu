import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'mouse_events.dart';
import 'mouse_hook.dart';

class MouseCursorProvider extends ChangeNotifier {
  MouseEvent _mouseEvent = MouseEvent(position: Offset.zero);

  MouseHookIsolate? _mouseHookIsolate;

  MouseCursorProvider() {
    initializeMouseHook();
  }

  MouseEvent get mouseEvent => _mouseEvent;

  void initializeMouseHook() async {
    _mouseHookIsolate = MouseHookIsolate();
    _mouseHookIsolate!.addMouseMoveListener((x, y) async {
      if (await windowManager.isFocused()) {
        _mouseEvent = MouseEvent(position: Offset(x.toDouble(), y.toDouble()));
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _mouseHookIsolate?.stop();
    super.dispose();
  }
}
