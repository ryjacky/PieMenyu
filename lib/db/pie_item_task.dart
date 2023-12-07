import 'package:isar/isar.dart';

part 'pie_item_task.g.dart';

@collection
class PieItemTask {
  Id id = Isar.autoIncrement;

  @enumerated
  PieItemTaskType taskType = PieItemTaskType.addon;
  int repeat = 1;
  List<String> arguments = [];

  IsarLink<PieItemTask> nextTask = IsarLink<PieItemTask>();

  PieItemTask({
    this.taskType = PieItemTaskType.addon,
    this.repeat = 1,
    this.arguments = const [],
  });
}

enum PieItemTaskType {
  addon,
  delay,
  repeat,
  arguments,
  nextTask,
}