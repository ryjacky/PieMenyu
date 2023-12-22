abstract class IMouseEvents {
}

class MouseMoveEvent extends IMouseEvents {
  final int x;
  final int y;
  MouseMoveEvent(this.x, this.y);
}