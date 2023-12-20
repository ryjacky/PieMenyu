import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/db.dart';
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

  PieMenu _pieMenu;
  List<PieItem> _pieItems = [];
  final Map<int, List<PieItemTask>> _tasksOfPieItem = {};

  PieMenuEditorPageViewModel({
    required int currentPieItemId,
    required PieMenu pieMenu,
  })  : _currentPieItemId = currentPieItemId,
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

  int get currentPieItemId => _currentPieItemId;

  set currentPieItemId(int value) {
    _currentPieItemId = value;
    notifyListeners();
  }

  void createTaskInCurrentPieItem(PieItemTaskType taskType) {
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
}
