import 'dart:convert';

import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu/db/pie_item_task.dart';

class OpenAppTask extends PieItemTask {
  OpenAppTask();

  set appPath(String value) {
    arguments = [value];
  }

  String get appPath => arguments[0];
}