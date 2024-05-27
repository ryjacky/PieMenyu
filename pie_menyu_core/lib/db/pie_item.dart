library pie_menyu_core;

import 'package:isar/isar.dart';

import 'pie_item_task.dart';

part 'pie_item.g.dart';

@collection
class PieItem {
  Id id = Isar.autoIncrement;

  String? _iconBase64;

  String? get iconBase64 => _iconBase64;

  set iconBase64(String? icon) {
    _iconBase64 = icon;
    _iconDataCode = null;
  }

  int? _iconDataCode;

  int? get iconDataCode => _iconDataCode;

  set iconDataCode(int? code) {
    _iconDataCode = code;
    _iconBase64 = null;
  }

  String name = '';

  List<PieItemTask> tasks = [];

  PieItem({String? iconBase64, this.name = '', int? iconDataCode}) {
    if (iconBase64 != null && iconDataCode != null) throw Exception("Only provide iconBase64 or iconDataCode but neither of them!");
    _iconBase64 = iconBase64;
    _iconDataCode = iconDataCode;
  }

  PieItem.from(PieItem pieItem) {
    if (iconBase64 != null && iconDataCode != null) throw Exception("Only provide iconBase64 or iconDataCode but neither of them!");

    id = pieItem.id;
    _iconDataCode = pieItem.iconDataCode;
    _iconBase64 = pieItem.iconBase64;
    name = pieItem.name;
    tasks = pieItem.tasks.toList();
  }
}
