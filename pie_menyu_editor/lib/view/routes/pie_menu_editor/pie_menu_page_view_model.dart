import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';

class PieMenuEditorPageViewModel extends ChangeNotifier {
  final Database _db;

  bool _isDragging = false;
  bool get isDragging => _isDragging;
  set isDragging(bool value) {
    _isDragging = value;
    notifyListeners();
  }

  /// Users will only be able to undo up to one level. See implementation of [removeTask] for details.
  MapEntry<PieItemTask, PieItemDelegate>? _toDelete;

  MapEntry<PieItemTask, PieItemDelegate>? get toDelete => _toDelete;

  Timer? lazyDeleteTimer;

  set toDelete(MapEntry<PieItemTask, PieItemDelegate>? value) {
    _toDelete = value;
    notifyListeners();
  }

  PieMenuEditorPageViewModel(this._db);

  void saveState(PieMenuState state) {
    if (toDelete != null) {
      lazyDeleteTimer?.cancel();
      state.removeTaskFrom(toDelete!.value, toDelete!.key);
    }

    _db.save(state);
  }
}
