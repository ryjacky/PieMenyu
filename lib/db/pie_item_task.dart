import 'package:isar/isar.dart';

part 'pie_item_task.g.dart';

@collection
class PieItemTask {
  Id id = Isar.autoIncrement;

  @enumerated
  PieItemTaskType taskType = PieItemTaskType.sendKey;
  int repeat = 1;
  List<String> arguments = [];

  IsarLink<PieItemTask> nextTask = IsarLink<PieItemTask>();

  PieItemTask({
    this.taskType = PieItemTaskType.sendKey,
    this.repeat = 1,
    this.arguments = const [],
  });
}

enum PieItemTaskType {
  sendKey,
  mouseClick,
  runFile,
  openMenu,
  openFolder,
  openApp,
  openUrl,
  openEditor,
  resizeWindow,
  moveWindow,
}