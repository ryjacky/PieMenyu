import 'package:pie_menyu/db/pie_item_task.dart';

class OpenUrlTask extends PieItemTask {
  OpenUrlTask() : super(taskType: PieItemTaskType.openUrl) {
    _fieldCheck();
  }

  OpenUrlTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck(){
    if (arguments.length != 1) {
      arguments = [""];
    }
  }

  set url(String value) {
    arguments = [value];
  }

  String get url => arguments[0];
}