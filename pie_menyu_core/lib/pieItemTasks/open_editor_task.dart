library pie_menyu_core;

import 'package:pie_menyu_core/db/pie_item_task.dart';

import '../executor/executable.dart';

class OpenEditorTask extends PieItemTask with Executable {
  OpenEditorTask() : super(taskType: PieItemTaskType.openEditor);

  OpenEditorTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck() {
    if (arguments.length != 1) {
      arguments = [""];
    }
    taskType = PieItemTaskType.openEditor;
  }

  @override
  Future<void> execute() async {
    // TODO: implement execute
  }
}
