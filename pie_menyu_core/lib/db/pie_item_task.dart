library pie_menyu_core;

import 'package:isar/isar.dart';

part 'pie_item_task.g.dart';

@collection
class PieItemTask {
  Id id = Isar.autoIncrement;

  @enumerated
  PieItemTaskType taskType = PieItemTaskType.sendKey;
  int repeat = 1;
  List<String> arguments = [];

  PieItemTask({
    this.taskType = PieItemTaskType.sendKey,
    this.repeat = 1,
    this.arguments = const [],
  });

  PieItemTask.from(PieItemTask pieItemTask) {
    repeat = pieItemTask.repeat;
    arguments = pieItemTask.arguments;
    id = pieItemTask.id;
  }

}

enum PieItemTaskType {
  sendKey,
  mouseClick,
  runFile,
  openSubMenu,
  openFolder,
  openApp,
  openUrl,
  openEditor,
  resizeWindow,
  moveWindow,
  sendText,
}