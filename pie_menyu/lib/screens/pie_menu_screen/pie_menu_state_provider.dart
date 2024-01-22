import 'package:flutter/material.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';

class PieMenuStateProvider extends ChangeNotifier {
  List<PieMenuState> _pieMenuStates = [];
  List<PieMenuState> get pieMenuStates => _pieMenuStates;
  Map<PieMenuState, Offset> _pieMenuPositions = {};
  Map<PieMenuState, Offset> get pieMenuPositions => _pieMenuPositions;

  PieMenuStateProvider();

  addState(PieMenuState pieMenuState) {
    _pieMenuStates = [..._pieMenuStates, pieMenuState];
    pieMenuState.addListener(() => notifyListeners());
    notifyListeners();
  }

  replaceStates(List<PieMenuState> pieMenuStates) {
    _pieMenuStates = pieMenuStates;
    for (final pieMenuState in pieMenuStates) {
      pieMenuState.addListener(() => notifyListeners());
    }
    notifyListeners();
  }
}