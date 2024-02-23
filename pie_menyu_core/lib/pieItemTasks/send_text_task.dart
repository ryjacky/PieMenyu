library pie_menyu_core;

import 'package:clipboard/clipboard.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auto_gui/flutter_auto_gui.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';

import '../executor/executable.dart';

class PasteTextTask extends PieItemTask with Executable {
  PasteTextTask() : super(taskType: PieItemTaskType.sendText) {
    _fieldCheck();
  }

  PasteTextTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck() {
    if (arguments.length != 1) {
      arguments = [""];
    }
    taskType = PieItemTaskType.sendText;
  }

  set text(String value) {
    arguments[0] = value;
  }

  String get text => arguments[0];

  @override
  Future<void> execute() async {
    await FlutterClipboard.copy(text);
    SendKeyTask()..ctrl = true..key = LogicalKeyboardKey.keyV..execute();
  }
}
