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
  Future<void> execute() async {
    if (hotkey != null) {
      await AutoGUI.hotkey(keys: hotkey!);
    }
  }
}
