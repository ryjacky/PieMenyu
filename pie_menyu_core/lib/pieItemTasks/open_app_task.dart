library pie_menyu_core;

import 'package:pie_menyu_core/db/pie_item_task.dart';

import '../executor/executable.dart';

class OpenAppTask extends PieItemTask with Executable {
  OpenAppTask() : super(taskType: PieItemTaskType.openApp) {
    _fieldCheck();
  }

  OpenAppTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck() {
    if (arguments.length != 1) {
      arguments = [""];
    }
    taskType = PieItemTaskType.openApp;
  }

  set appPath(String value) {
    arguments = [value];
  }

  String get appPath => arguments[0];

  @override
  Future<void> execute() async {
    // TODO: implement execute
  }
}
