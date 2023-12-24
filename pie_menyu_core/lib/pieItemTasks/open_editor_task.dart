library pie_menyu_core;

import 'package:pie_menyu_core/db/pie_item_task.dart';

import '../executor/executable.dart';

class OpenEditorTask extends PieItemTask with Executable {
  OpenEditorTask() : super(taskType: PieItemTaskType.openEditor);

  OpenEditorTask.from(PieItemTask pieItemTask) : super.from(pieItemTask);

  @override
  void execute() {
    // TODO: implement execute
  }
}
