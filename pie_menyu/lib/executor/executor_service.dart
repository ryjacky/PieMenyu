import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';

class ExecutorService extends ChangeNotifier {
  int _activePieItemOrderIndex = 0;
  final List<PieItemTask> _pieItemTasks = [];

  int get activePieItemOrderIndex => _activePieItemOrderIndex;

  set activePieItemOrderIndex(int index) {
    _activePieItemOrderIndex = index;
    notifyListeners();
  }

  void execute(PieItemTask task) {
    _pieItemTasks.add(task);
  }

}