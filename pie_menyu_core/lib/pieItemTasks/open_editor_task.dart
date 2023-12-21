library pie_menyu_core;

import 'package:pie_menyu_core/db/pie_item_task.dart';

class OpenEditorTask extends PieItemTask {
  OpenEditorTask() : super(taskType: PieItemTaskType.openEditor);

  OpenEditorTask.from(PieItemTask pieItemTask) : super.from(pieItemTask);

}