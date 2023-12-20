import 'dart:convert';

import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu/db/pie_item_task.dart';

class OpenFolderTask extends PieItemTask {
  OpenFolderTask();

  set folderPath(String value) {
    arguments = [value];
  }

  String get folderPath => arguments[0];
}