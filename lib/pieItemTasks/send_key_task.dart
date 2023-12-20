import 'dart:convert';

import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu/db/pie_item_task.dart';

class SendKeyTask extends PieItemTask {
  SendKeyTask();

  set hotkey(HotKey value) {
    arguments = [jsonEncode(value.toJson())];
  }

  HotKey get hotkey {
    return HotKey.fromJson(jsonDecode(arguments[0]));
  }
}