import 'package:isar/isar.dart';
import 'package:pie_menyu/db/pie_item_task.dart';
import 'package:pie_menyu/db/pie_menu.dart';

part 'pie_item.g.dart';

@collection
class PieItem {
  Id id = Isar.autoIncrement;

  @Backlink(to: 'pieItems')
  IsarLinks<PieMenu> pieMenus = IsarLinks<PieMenu>();

  IsarLink<PieItemTask> beginningTask = IsarLink<PieItemTask>();

  PieItem({
    String iconBase64 = '',
    String displayName = '',
    bool enabled = false,
  });
}