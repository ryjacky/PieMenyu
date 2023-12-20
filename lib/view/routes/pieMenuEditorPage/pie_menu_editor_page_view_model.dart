import 'package:flutter/cupertino.dart';
import 'package:pie_menyu/db/pie_item.dart';
import 'package:pie_menyu/db/pie_item_task.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/pieItemTasks/move_window_task.dart';
import 'package:pie_menyu/pieItemTasks/open_app_task.dart';
import 'package:pie_menyu/pieItemTasks/open_editor_task.dart';
import 'package:pie_menyu/pieItemTasks/open_folder_task.dart';
import 'package:pie_menyu/pieItemTasks/open_sub_menu_task.dart';
import 'package:pie_menyu/pieItemTasks/open_url_task.dart';
import 'package:pie_menyu/pieItemTasks/resize_window_task.dart';
import 'package:pie_menyu/pieItemTasks/run_file_task.dart';
import 'package:pie_menyu/pieItemTasks/mouse_click_task.dart';
import 'package:pie_menyu/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu/pieItemTasks/send_text_task.dart';

class PieMenuEditorPageViewModel extends ChangeNotifier {
  int _currentPieItemId;
  final PieMenu _pieMenu;
  Map<int, List<PieItemTask>> _tasksOfPieItem = {};

  PieMenuEditorPageViewModel({
    required int currentPieMenuId,
    required PieMenu pieMenu,
  })  : _currentPieItemId = currentPieMenuId,
        _pieMenu = pieMenu {
    loadPieItemTasks();
  }

  loadPieItemTasks() async {
    await _pieMenu.pieItems.load();
    await Future.value(
        _pieMenu.pieItems.map((pieItem) => pieItem.tasks.load()));

    for (PieItem pieItem in _pieMenu.pieItems) {
      _tasksOfPieItem[pieItem.id] = pieItem.tasks.toList();
    }
  }

  Map<int, List<PieItemTask>> get tasksOfPieItem => _tasksOfPieItem;

  PieMenu get pieMenu => _pieMenu;

  int get currentPieMenuId => _currentPieItemId;

  set currentPieMenuId(int value) {
    _currentPieItemId = value;
    notifyListeners();
  }

  void createTask(PieItemTaskType taskType) {
    PieItemTask? newTask;

    switch (taskType) {
      case PieItemTaskType.sendKey:
        newTask = SendKeyTask();
        break;
      case PieItemTaskType.sendText:
        newTask = SendTextTask();
        break;
      case PieItemTaskType.mouseClick:
        newTask = MouseClickTask();
        break;
      case PieItemTaskType.runFile:
        newTask = RunFileTask();
        break;
      case PieItemTaskType.openSubMenu:
        newTask = OpenSubMenuTask();
        break;
      case PieItemTaskType.openFolder:
        newTask = OpenFolderTask();
        break;
      case PieItemTaskType.openApp:
        newTask = OpenAppTask();
        break;
      case PieItemTaskType.openUrl:
        newTask = OpenUrlTask();
        break;
      case PieItemTaskType.openEditor:
        newTask = OpenEditorTask();
        break;
      case PieItemTaskType.resizeWindow:
        newTask = ResizeWindowTask();
        break;
      case PieItemTaskType.moveWindow:
        newTask = MoveWindowTask();
        break;
    }

    _tasksOfPieItem[_currentPieItemId] = [
      ...(_tasksOfPieItem[_currentPieItemId] ?? []),
      newTask
    ];
    notifyListeners();
  }
}
