library global_hotkey;
import 'hotkey.dart';

enum HotkeyEventType { hotkeyTriggered, hotkeyReleased }

class HotkeyEvent {
  final HotkeyEventType type;
  final Hotkey hotkey;

  HotkeyEvent(this.type, this.hotkey);
}