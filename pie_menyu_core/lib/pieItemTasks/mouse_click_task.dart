library pie_menyu_core;
import 'dart:io';
import 'dart:math';

import 'package:flutter_auto_gui/flutter_auto_gui.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/executor/executable.dart';
import 'package:win32/win32.dart';

class MouseClickTask extends PieItemTask with Executable {
  MouseClickTask() : super(taskType: PieItemTaskType.mouseClick){
    _fieldCheck();
  }

  MouseClickTask.from(PieItemTask pieItemTask) : super.from(pieItemTask){
    _fieldCheck();
  }

  _fieldCheck(){
    if (arguments.length != 3) {
      arguments = ["", "", ""];
    }
    taskType = PieItemTaskType.mouseClick;
  }

  set mouseButton(MouseButton value) {
    arguments[0] = value.name;
  }

  MouseButton get mouseButton {
    if (arguments[0] == MouseButton.right.name) {
      return MouseButton.right;
    } else if (arguments[0] == MouseButton.middle.name) {
      return MouseButton.middle;
    } else {
      return MouseButton.left;
    }
  }

  set x(int value) {
    arguments[1] = value.toString();
  }

  int get x {
    return int.tryParse(arguments[1]) ?? 0;
  }

  set y(int value) {
    arguments[2] = value.toString();
  }

  int get y {
    return int.tryParse(arguments[2]) ?? 0;
  }

  @override
  Future<void> execute() async {
    if (Platform.isWindows) {
      SetCursorPos(x, y);
    } else {
      await FlutterAutoGUI.moveTo(point: Point(x, y));
    }
    await Future.delayed(const Duration(milliseconds: 10));
    await FlutterAutoGUI.click(button: mouseButton);
  }
}
