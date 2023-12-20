import 'package:pie_menyu/db/pie_item_task.dart';

class MoveWindowTask extends PieItemTask {
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
}