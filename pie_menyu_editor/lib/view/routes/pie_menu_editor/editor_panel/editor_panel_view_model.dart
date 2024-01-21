import 'package:flutter/cupertino.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';

class EditorPanelViewModel extends ChangeNotifier {
  Database _db;
  EditorPanelViewModel(this._db);

  void saveState(PieMenuState state) {
    _db.save(state);
  }
}