library pie_menyu_core;

import 'package:pie_menyu_core/db/pie_item_task.dart';

class RunFileTask extends PieItemTask {
  RunFileTask() : super(taskType: PieItemTaskType.runFile) {
    _fieldCheck();
  }

  RunFileTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck(){
    if (arguments.length != 1) {
      arguments = [""];
    }
  }

  set filePath(String value) {
    arguments = [value];
  }

  String get filePath => arguments[0];
}