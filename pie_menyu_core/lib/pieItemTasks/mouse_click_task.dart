library pie_menyu_core;
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/executor/executable.dart';

class MouseClickTask extends PieItemTask with Executable {
  MouseClickTask() : super(taskType: PieItemTaskType.mouseClick){
    _fieldCheck();
  }

  MouseClickTask.from(PieItemTask pieItemTask) : super.from(pieItemTask){
    _fieldCheck();
  }

  _fieldCheck(){
    if (arguments.length != 3) {
      arguments = ["", "", ""];
    }
  }

  set mouseButton(MouseButton value) {
    arguments[0] = value.name;
  }

  MouseButton get mouseButton {
    return MouseButton.values
        .firstWhere((element) => element.name == arguments[0]);
  }

  set x(int value) {
    arguments[1] = value.toString();
  }

  int get x {
    return int.tryParse(arguments[1]) ?? 0;
  }

  set y(int value) {
    arguments[2] = value.toString();
  }

  int get y {
    return int.tryParse(arguments[2]) ?? 0;
  }

  @override
  Future<void> execute() async {
    // TODO: implement execute
  }
}

enum MouseButton {
  left,
  right,
  middle,
  fourth,
}
