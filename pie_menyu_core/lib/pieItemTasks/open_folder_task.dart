library pie_menyu_core;

import 'package:pie_menyu_core/db/pie_item_task.dart';

class OpenFolderTask extends PieItemTask {
  OpenFolderTask() : super(taskType: PieItemTaskType.openFolder) {
    _fieldCheck();
  }

  OpenFolderTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck(){
    if (arguments.length != 1) {
      arguments = [""];
    }
  }

  set folderPath(String value) {
    arguments = [value];
  }

  String get folderPath => arguments[0];
}