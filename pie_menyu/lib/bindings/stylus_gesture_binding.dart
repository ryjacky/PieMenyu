import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mouse_event/mouse_event.dart' as system_hook;
import 'package:pie_menyu/window/pie_menyu_window_manager.dart';
import 'package:window_manager/window_manager.dart';

class StylusGestureBinding {
  // Private constructor to prevent direct instantiation
  StylusGestureBinding._();

  static StylusGestureBinding? _instance;

  // Getter for the instance, checking for null
  factory StylusGestureBinding.instance() {
    if (_instance == null) {
      throw Exception("StylusGestureBinding has not been initialized!");
    }

    return _instance!;
  }

  // Method to access the binding, ensuring initialization
  static Future<StylusGestureBinding> initialize() async {
    _instance ??= StylusGestureBinding._();
    await _instance!._performInitialization();

    return _instance!;
  }

  /// Perform required initialization tasks
  /// PointerHoverEvents that are synthesized from this class will not work
  /// with [InkWell]
  /// Currently supported widgets include but not limited to: [Listener], [MouseRegion]
  Future<void> _performInitialization() async {
    system_hook.MouseEventPlugin.startListening((mouseEvent) async {
      if (!await windowManager.isFocused()) return;

      // MSDN: https://learn.microsoft.com/en-us/windows/win32/tablet/system-events-and-mouse-messages?redirectedfrom=MSDN
      // See "Distinguishing Pen Input from Mouse and Touch"
      // Summary: dwExtraInfo that starts with 0xFF5157 means the message
      // is synthesized from a pen
      if (mouseEvent.dwExtraInfo & 0xFFFFFF00 != 0xFF515700) return;

      GestureBinding.instance.handlePointerEvent(
        PointerHoverEvent(
          position: await PieMenyuWindow.getRelativeCursorScreenPoint(
            position: mouseEvent.getOffset()
          ),
        ),
      );
    });
  }
}
