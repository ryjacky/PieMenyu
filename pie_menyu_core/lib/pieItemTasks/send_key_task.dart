library pie_menyu_core;

import 'package:flutter_auto_gui/flutter_auto_gui.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';

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

  List<String> get hotkeyStrings {
    final keys = <String>[];
    if (ctrl) {
      keys.add("Ctrl");
    }
    if (shift) {
      keys.add("Shift");
    }
    if (alt) {
      keys.add("Alt");
    }
    keys.add(key);
    return keys;
  }

  @override
  Future<void> execute() async {
    final keys = hotkeyStrings
        .map((e) => e.toLowerCase())
        .toList();

    await FlutterAutoGUI.hotkey(keys: keys, interval: Duration(milliseconds: 50));

    // I've spent so much time debugging this and find out that
    // FlutterAutoGUI.hotkey is a fake future that returns before hotkey
    // is pressed.
    await Future.delayed(Duration(milliseconds: 60));
  }
}
