enum KeyboardEventType {
  keyDown,
  keyUp,
  keyPress,
}
class KeyboardEvent {
  final KeyboardEventType type;
  final int vkCode;
  KeyboardEvent(this.type, this.vkCode);
}