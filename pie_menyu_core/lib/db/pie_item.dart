library pie_menyu_core;

import 'package:isar/isar.dart';

import 'pie_item_task.dart';
import 'pie_menu.dart';

part 'pie_item.g.dart';

@collection
class PieItem {
  Id id = Isar.autoIncrement;

  String iconBase64 = '';
  String displayName = '';
  bool enabled = true;

  IsarLinks<PieItemTask> tasks = IsarLinks<PieItemTask>();

  PieItem({
    this.iconBase64 = '',
    this.displayName = '',
    this.enabled = false,
  });

  PieItem.from(PieItem pieItem) {
    iconBase64 = pieItem.iconBase64;
    displayName = pieItem.displayName;
    enabled = pieItem.enabled;
  }
}