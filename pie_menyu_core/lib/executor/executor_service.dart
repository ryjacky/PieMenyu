import 'package:flutter/material.dart';

import 'executable.dart';

class ExecutorService extends ChangeNotifier {
  final List<Executable> _pieItemTasks = [];

  bool _isExecuting = false;
  /// Should not be access through a provider
  int activePieItemOrderIndex = 0;

  bool get isExecuting => _isExecuting;

  void execute(Executable task) {
    _pieItemTasks.add(task);
  }

  Future<void> start() async {
    _isExecuting = true;
    notifyListeners();

    while (_pieItemTasks.isNotEmpty) {
      await _pieItemTasks.removeAt(0).execute();
    }

    _isExecuting = false;
    notifyListeners();
  }

  void cancelAll(){
    _pieItemTasks.clear();
  }

}