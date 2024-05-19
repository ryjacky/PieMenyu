library pie_menyu_core;
import 'dart:developer';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'dart:ffi';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/executor/executable.dart';
import 'package:win32/win32.dart';

enum MouseButton { right, left, middle }

extension _MouseButtonFlag on MouseButton {
  int get downFlag {
    switch (this) {
      case MouseButton.right:
        return MOUSEEVENTF_RIGHTDOWN;
      case MouseButton.left:
        return MOUSEEVENTF_LEFTDOWN;
      case MouseButton.middle:
        return MOUSEEVENTF_MIDDLEDOWN;
    }
  }
  int get upFlag {
    switch (this) {
      case MouseButton.right:
        return MOUSEEVENTF_RIGHTUP;
      case MouseButton.left:
        return MOUSEEVENTF_LEFTUP;
      case MouseButton.middle:
        return MOUSEEVENTF_MIDDLEUP;
    }
  }
}

class MouseClickTask extends PieItemTask with Executable {
  MouseClickTask() : super(taskType: PieItemTaskType.mouseClick){
    _fieldCheck();
  }

  MouseClickTask.from(super.pieItemTask) : super.from(){
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

  sendClickWindows(){
    SetCursorPos(x, y);

    final mouse = calloc<INPUT>();
    mouse.ref.type = INPUT_MOUSE;
    mouse.ref.mi.dwFlags = mouseButton.downFlag;
    var result = SendInput(1, mouse, sizeOf<INPUT>());
    if (result != TRUE) log('Error: ${GetLastError()}');

    mouse.ref.mi.dwFlags = mouseButton.upFlag;
    result = SendInput(1, mouse, sizeOf<INPUT>());
    if (result != TRUE) log('Error: ${GetLastError()}');

    free(mouse);
  }

  @override
  Future<void> execute() async {
    if (Platform.isWindows) {
      sendClickWindows();
    } else if (Platform.isMacOS) {
    } else if (Platform.isLinux) {

    }
  }
}
