import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/db.dart';

class PieMenuProvider extends ChangeNotifier {
  PieMenu _pieMenu = PieMenu();
  List<PieItem> _pieItems = [];
  Offset _pieCenterScreenPosition = Offset.zero;
  
  Offset get pieCenterScreenPosition => _pieCenterScreenPosition;
  
  set pieCenterScreenPosition(Offset value) {
    _pieCenterScreenPosition = value;
    notifyListeners();
  }
  
  PieMenu get pieMenu => _pieMenu;

  set pieMenu(PieMenu value) {
    _pieMenu = value;

    notifyListeners();
  }

  List<PieItem> get pieItems => _pieItems;

  set pieItems(List<PieItem> value) {
    _pieItems = value;
    notifyListeners();
  }

  /// Load pie items of current pie menu from database
  void loadPieItems() async {
    _pieItems = await DB.getPieItemsOf(_pieMenu);
    notifyListeners();
  }

}