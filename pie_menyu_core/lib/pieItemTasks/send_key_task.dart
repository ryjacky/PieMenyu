library pie_menyu_core;

import 'dart:convert';

import 'package:flutter_auto_gui/flutter_auto_gui.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/flutter_auto_gui/flutter_auto_gui.dart';
import '../executor/executable.dart';

class SendKeyTask extends PieItemTask with Executable {
  SendKeyTask() : super(taskType: PieItemTaskType.sendKey) {
    _fieldCheck();
  }

  SendKeyTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck() {
    if (arguments.length != 4) {
      arguments = ["", "", "", ""];
    }
  }

  set ctrl(bool value) {
    arguments[0] = value.toString();
  }

  bool get ctrl => arguments[0] == "true";

  set shift(bool value) {
    arguments[1] = value.toString();
  }

  bool get shift => arguments[1] == "true";

  set alt(bool value) {
    arguments[2] = value.toString();
  }

  bool get alt => arguments[2] == "true";

  set key(String value) {
    arguments[3] = value;
  }

  String get key => arguments[3];

  String get hotkeyString {
    final keys = <String>[];
    if (ctrl) {
      keys.add("ctrl");
    }
    if (shift) {
      keys.add("shift");
    }
    if (alt) {
      keys.add("alt");
    }
    keys.add(key);
    return keys.join("+");
  }

  @override
  Future<void> execute() async {
    final keys = <String>[];
    if (ctrl) {
      keys.add("ctrl");
    }
    if (shift) {
      keys.add("shift");
    }
    if (alt) {
      keys.add("alt");
    }
    keys.add(key.toLowerCase());
    await FlutterAutoGUI.hotkey(keys: keys);
  }
}
