import 'package:flutter/material.dart';

import 'executable.dart';

class ExecutorService extends ChangeNotifier {
  int _activePieItemOrderIndex = 0;
  final List<Executable> _pieItemTasks = [];

  int get activePieItemOrderIndex => _activePieItemOrderIndex;

  set activePieItemOrderIndex(int index) {
    _activePieItemOrderIndex = index;
    notifyListeners();
  }

  void execute(Executable task) {
    _pieItemTasks.add(task);
  }

  void start() {
    while (_pieItemTasks.isNotEmpty) {
      _pieItemTasks.removeAt(0).execute();
    }
  }

}