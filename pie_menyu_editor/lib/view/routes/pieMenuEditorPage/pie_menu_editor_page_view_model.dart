import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/pieItemTasks/mouse_click_task.dart';
import 'package:pie_menyu_core/pieItemTasks/move_window_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_app_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_editor_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_folder_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_sub_menu_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_url_task.dart';
import 'package:pie_menyu_core/pieItemTasks/resize_window_task.dart';
import 'package:pie_menyu_core/pieItemTasks/run_file_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_text_task.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';

class PieMenuEditorPageViewModel extends ChangeNotifier {
  int _currentPieItemOrderIndex;

  PieMenu _pieMenu;
  List<PieItem> _pieItems = [];
  final Map<int, List<PieItemTask>> _tasksOfPieItem = {};

  PieMenuEditorPageViewModel({
    required int currentPieItemOrderIndex,
    required PieMenu pieMenu,
  })  : _currentPieItemOrderIndex = currentPieItemOrderIndex,
        _pieMenu = pieMenu {
    loadPieItemTasks();
  }

  loadPieItemTasks() async {
    await _pieMenu.pieItems.load();
    _pieItems = _pieMenu.pieItems.toList();

    // Load tasks of each pie item
    await Future.wait(_pieMenu.pieItems.map((pieItem) => pieItem.tasks.load()));

    for (PieItem pieItem in _pieMenu.pieItems) {
      _tasksOfPieItem[pieItem.id] = pieItem.tasks.toList();
    }

    notifyListeners();
  }

  List<PieItem> get pieItems => _pieItems;

  void putPieItemInCurrentPieMenu(PieItem pieItem) {
    bool pieItemExisted = _pieItems.any((element) => element.id == pieItem.id);

    if (pieItem.id == Isar.autoIncrement || !pieItemExisted) {
      _pieItems = [..._pieItems, pieItem];
    } else {
      _pieItems =
          _pieItems.map((e) => e.id == pieItem.id ? pieItem : e).toList();
    }

    notifyListeners();
  }

  Map<int, List<PieItemTask>> get tasksOfPieItem => _tasksOfPieItem;

  PieMenu get pieMenu => _pieMenu;

  set pieMenu(PieMenu value) {
    _pieMenu = value;
    notifyListeners();
  }

  int get pieItemOrderIndex => _currentPieItemOrderIndex;

  set pieItemOrderIndex(int value) {
    _currentPieItemOrderIndex = value;
    notifyListeners();
  }

  void createTaskInCurrentPieItem(PieItemTaskType taskType) {
    PieItemTask? newTask;

    switch (taskType) {
      case PieItemTaskType.sendKey:
        newTask = PieItemTask();
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

    _tasksOfPieItem[_currentPieItemOrderIndex] = [
      ...(_tasksOfPieItem[_currentPieItemOrderIndex] ?? []),
      newTask
    ];
    notifyListeners();
  }

  Future<void> save() async {
    for (PieItem pieItem in _pieItems) {
      final pieItemTasks = tasksOfPieItem[pieItem.id];
      if (pieItemTasks != null) {
        await DB.putPieItemTasks(pieItemTasks);
        await DB.addTasksToPieItem(pieItemTasks, pieItem);
      }
      await DB.putPieItem(pieItem);
    }

    await DB.addPieItemsToPieMenu(_pieItems, _pieMenu);
    await DB.putPieMenu(_pieMenu);
  }

  void reset() {}

  void createPieItemInCurrentPieMenu() async {
    _pieItems = [
      ..._pieItems,
      PieItem(
        displayName: "label-new-pie-item".i18n()
      )
    ];

    notifyListeners();
  }

  void putPieItemTaskInCurrentPieItem(PieItemTask pieItemTask) {
    bool pieItemTaskExisted = _tasksOfPieItem[_currentPieItemOrderIndex]!
        .any((element) => element.id == pieItemTask.id);

    if (pieItemTask.id == Isar.autoIncrement || !pieItemTaskExisted) {
      _tasksOfPieItem[_currentPieItemOrderIndex] = [
        ...(_tasksOfPieItem[_currentPieItemOrderIndex] ?? []),
        pieItemTask
      ];
    } else {
      _tasksOfPieItem[_currentPieItemOrderIndex] = _tasksOfPieItem[_currentPieItemOrderIndex]!
          .map((e) => e.id == pieItemTask.id ? pieItemTask : e)
          .toList();
    }
    notifyListeners();
  }
}
