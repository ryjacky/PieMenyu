import 'package:isar/isar.dart';

part 'pie_item.g.dart';

@collection
class PieItem {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  PieItem({
    String iconBase64 = '',
    String displayName = '',
    bool enabled = false,
    List<PieItemTask> pieItemTasks = const [],
  });
}

@embedded
class PieItemTask {
  String addonId = "";
  int delay = 1;
  int repeat = 1;
  List<PieItemTaskArgument> arguments = [];
}

@embedded
class PieItemTaskArgument {
  String name = "";
  String value = "";
}
