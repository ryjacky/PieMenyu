library pie_menyu_core;

import 'package:pie_menyu_core/db/pie_item_task.dart';

class OpenSubMenuTask extends PieItemTask {
  OpenSubMenuTask() : super(taskType: PieItemTaskType.openSubMenu) {
    _fieldCheck();
  }

  OpenSubMenuTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck(){
    if (arguments.length != 1) {
      arguments = ["0"];
    }
  }

  set subMenuId(int pieMenuId) {
    arguments = [pieMenuId.toString()];
  }

  int get subMenuId => int.parse(arguments[0]);

  @override
  void execute() {
    // TODO: implement execute
  }
}