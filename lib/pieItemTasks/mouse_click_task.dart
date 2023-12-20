import 'package:pie_menyu/db/pie_item_task.dart';

class MouseClickTask extends PieItemTask {
  MouseClickTask();

  _beforeSet(){
    if (arguments.length != 3) {
      arguments = ["", "", ""];
    }
  }

  set mouseButton(MouseButton value) {
    _beforeSet();
    arguments[0] = value.name;
  }

  MouseButton get mouseButton {
    return MouseButton.values
        .firstWhere((element) => element.name == arguments[0]);
  }

  set x(int value) {
    _beforeSet();
    arguments[1] = value.toString();
  }

  int get x {
    return int.parse(arguments[1]);
  }

  set y(int value) {
    _beforeSet();
    arguments[2] = value.toString();
  }

  int get y {
    return int.parse(arguments[2]);
  }
}

enum MouseButton {
  left,
  right,
  middle,
  fourth,
}
