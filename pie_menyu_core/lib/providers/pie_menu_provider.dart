import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';

class PieMenuProvider extends ChangeNotifier {
  PieMenu _pieMenu = PieMenu();
  List<PieItem> _pieItems = [];

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

}