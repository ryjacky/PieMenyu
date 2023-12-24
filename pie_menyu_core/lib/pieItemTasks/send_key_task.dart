library pie_menyu_core;

import 'dart:convert';

import 'package:hotkey_manager/hotkey_manager.dart';
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
    if (arguments.length != 1) {
      arguments = [""];
    }
  }

  set hotkey(HotKey? value) {
    if (value == null) {
      arguments = [];
      return;
    }

    arguments = [jsonEncode(value.toJson())];
  }

  HotKey? get hotkey {
    try {
      return HotKey.fromJson(jsonDecode(arguments[0]));
    } catch (e) {
      return null;
    }
  }

  @override
  void execute() {
    // TODO: implement execute
  }
}
