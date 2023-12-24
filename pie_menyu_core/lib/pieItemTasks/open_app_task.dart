library pie_menyu_core;

import 'package:pie_menyu_core/db/pie_item_task.dart';

class OpenAppTask extends PieItemTask {
  OpenAppTask() : super(taskType: PieItemTaskType.openApp) {
    _fieldCheck();
  }

  OpenAppTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck(){
    if (arguments.length != 1) {
      arguments = [""];
    }
  }


  set appPath(String value) {
    arguments = [value];
  }

  String get appPath => arguments[0];

  @override
  void execute() {
    // TODO: implement execute
  }
}