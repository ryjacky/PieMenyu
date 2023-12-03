import 'package:isar/isar.dart';
import 'package:pie_menyu/db/pie_menu.dart';

part 'pie_item.g.dart';

@collection
class PieItem {
  Id id = Isar.autoIncrement;

  @Backlink(to: 'pieItems')
  IsarLinks<PieMenu> pieMenus = IsarLinks<PieMenu>();

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
