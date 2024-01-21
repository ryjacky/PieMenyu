library pie_menyu_core;

import 'package:isar/isar.dart';

import 'pie_item_task.dart';

part 'pie_item.g.dart';

@collection
class PieItem {
  Id id = Isar.autoIncrement;

  String iconBase64 = '';
  String name = '';

  List<PieItemTask> tasks = [];

  PieItem({this.iconBase64 = '', this.name = ''});

  PieItem.from(PieItem pieItem) {
    id = pieItem.id;
    iconBase64 = pieItem.iconBase64;
    name = pieItem.name;
    tasks = pieItem.tasks.toList();
  }
}
