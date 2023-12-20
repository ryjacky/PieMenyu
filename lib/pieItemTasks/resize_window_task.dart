import 'package:pie_menyu/db/pie_item_task.dart';

class ResizeWindowTask extends PieItemTask {
  ResizeWindowTask();

  _beforeSet() {
    if (arguments.length != 2) {
      arguments = ["0", "0"];
    }
  }

  set width(int value) {
    _beforeSet();
    arguments[0] = value.toString();
  }

  int get width => int.parse(arguments[0]);

  set height(int value) {
    _beforeSet();
    arguments[1] = value.toString();
  }

  int get height => int.parse(arguments[1]);
}