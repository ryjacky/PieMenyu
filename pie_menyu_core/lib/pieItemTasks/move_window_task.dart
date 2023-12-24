library pie_menyu_core;
import 'package:pie_menyu_core/db/pie_item_task.dart';

import '../executor/executable.dart';

class MoveWindowTask extends PieItemTask with Executable {
  MoveWindowTask() : super(taskType: PieItemTaskType.moveWindow){
    _fieldCheck();
  }

  MoveWindowTask.from(PieItemTask pieItemTask) : super.from(pieItemTask){
    _fieldCheck();
  }

  _fieldCheck(){
    if (arguments.length != 2) {
      arguments = ["", ""];
    }
  }

  set x(int value) {
    arguments[0] = value.toString();
  }

  int get x => int.parse(arguments[0]);

  set y(int value) {
    arguments[1] = value.toString();
  }

  int get y => int.parse(arguments[1]);

  @override
  Future<void> execute() async {
    // TODO: implement execute
  }
}