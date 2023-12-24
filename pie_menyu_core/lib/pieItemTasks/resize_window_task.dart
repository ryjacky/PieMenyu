library pie_menyu_core;

import 'package:pie_menyu_core/db/pie_item_task.dart';

class ResizeWindowTask extends PieItemTask {
  ResizeWindowTask() : super(taskType: PieItemTaskType.resizeWindow) {
    _fieldCheck();
  }

  ResizeWindowTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck(){
    if (arguments.length != 2) {
      arguments = ["", ""];
    }
  }

  set width(int value) {
    arguments[0] = value.toString();
  }

  int get width => int.parse(arguments[0]);

  set height(int value) {
    arguments[1] = value.toString();
  }

  int get height => int.parse(arguments[1]);

  @override
  void execute() {
    // TODO: implement execute
  }
}