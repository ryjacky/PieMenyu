import 'dart:convert';

import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu/db/pie_item_task.dart';

class MoveWindowTask extends PieItemTask {
  MoveWindowTask();

  _beforeSet(){
    if (arguments.length != 2) {
      arguments = ["0", "0"];
    }
  }

  set x(int value) {
    _beforeSet();
    arguments[0] = value.toString();
  }

  int get x => int.parse(arguments[0]);

  set y(int value) {
    _beforeSet();
    arguments[1] = value.toString();
  }

  int get y => int.parse(arguments[1]);
}