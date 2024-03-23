import 'package:flutter/cupertino.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';

class EditorPanelViewModel extends ChangeNotifier {
  final Database _db;

  /// Users will only be able to undo up to one level. See implementation of [removeTask] for details.
  MapEntry<PieItemTask, PieItemDelegate>? _toDelete;

  MapEntry<PieItemTask, PieItemDelegate>? get toDelete => _toDelete;

  set toDelete(MapEntry<PieItemTask, PieItemDelegate>? value) {
    _toDelete = value;
    notifyListeners();
  }

  EditorPanelViewModel(this._db);

  void saveState(PieMenuState state) {
    _db.save(state);
  }
}
