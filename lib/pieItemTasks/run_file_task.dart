import 'dart:convert';

import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu/db/pie_item_task.dart';

class RunFileTask extends PieItemTask {
  RunFileTask();

  set filePath(String value) {
    arguments = [value];
  }

  String get filePath => arguments[0];
}