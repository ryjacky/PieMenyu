library pie_menyu_core;

import 'package:isar/isar.dart';

part 'pie_item_task.g.dart';

@embedded
class PieItemTask {
  @enumerated
  PieItemTaskType taskType = PieItemTaskType.sendKey;
  int repeat = 1;
  List<String> arguments = [];

  @ignore
  int runtimeId = -1;

  PieItemTask({
    this.taskType = PieItemTaskType.sendKey,
    this.repeat = 1,
    this.arguments = const [],
  });

  PieItemTask.from(PieItemTask pieItemTask) {
    repeat = pieItemTask.repeat;
    arguments = pieItemTask.arguments;
    taskType = pieItemTask.taskType;
    runtimeId = pieItemTask.runtimeId;
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