library pie_menyu_core;

import 'package:pie_menyu_core/db/pie_item_task.dart';

import '../executor/executable.dart';

class SendTextTask extends PieItemTask with Executable {
  SendTextTask() : super(taskType: PieItemTaskType.sendText) {
    _fieldCheck();
  }

  SendTextTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck() {
    if (arguments.length != 1) {
      arguments = [""];
    }
  }

  set text(String value) {
    arguments = [value];
  }

  String get text => arguments[0];

  @override
  Future<void> execute() async {
    // TODO: implement execute
  }
}
