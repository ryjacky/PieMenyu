import 'package:flutter/material.dart';

import 'executable.dart';

class ExecutorService extends ChangeNotifier {
  final List<Executable> _pieItemTasks = [];

  bool _isExecuting = false;
  int _activePieItemOrderIndex = 0;

  bool get isExecuting => _isExecuting;
  
  int get activePieItemOrderIndex => _activePieItemOrderIndex;

  set activePieItemOrderIndex(int index) {
    _activePieItemOrderIndex = index;
  }

  void execute(Executable task) {
    _pieItemTasks.add(task);
  }

  void start() async {
    _isExecuting = true;
    notifyListeners();

    while (_pieItemTasks.isNotEmpty) {
      await _pieItemTasks.removeAt(0).execute();
    }

    _isExecuting = false;
    notifyListeners();
  }

}