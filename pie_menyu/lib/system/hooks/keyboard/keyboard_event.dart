import 'package:hotkey_manager/hotkey_manager.dart';

enum KeyboardEventType {
  keyDown,
  keyUp,
  keyPress,
}
class KeyboardEvent {
  final KeyboardEventType type;
  final HotKey? hotkey;
  final int vkCode;
  KeyboardEvent(this.type, this.vkCode, {this.hotkey});
}