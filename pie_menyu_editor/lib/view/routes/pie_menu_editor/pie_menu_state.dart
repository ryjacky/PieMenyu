import 'package:flutter/cupertino.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_editor/coreExtended/real_pie_item_instance.dart';

class PieMenuState extends ChangeNotifier {
  static const deleteId = 0;
  int nextId = -1;

  final PieMenu _pieMenu;
  PieMenu get pieMenu => _pieMenu;

  List<RealPieItemInstance> _pieItemInstances = [];
  List<RealPieItemInstance> get pieItemInstances => _pieItemInstances;
  List<PieItem> get pieItems =>
      _pieItemInstances.map((e) => e.pieItem).toList();

  final Map<int, Set<PieItemTask>> _pieItemTasks = {};
  Map<int, Set<PieItemTask>> get pieItemTasks => _pieItemTasks;

  PieItem? _activePieItem;
  PieItem? get activePieItem => _activePieItem;

  void setActivePieItem(PieItem pieItem) {
    _activePieItem =
        pieItems.where((element) => element.id == pieItem.id).firstOrNull;
    notifyListeners();
  }

  PieMenuState({
    required PieMenu pieMenu,
  }) : _pieMenu = pieMenu {
    load();
  }

  /// Load pie items of current pie menu and their tasks from database
  void load() async {
    final pieItems = await DB.getPieItemsOf(_pieMenu);

    for (PieItem pieItem in pieItems) {
      await pieItem.tasks.load();
      _pieItemTasks[pieItem.id] = pieItem.tasks;
      _pieItemInstances.add(RealPieItemInstance(
          pieMenu.pieItemInstances
                  .where((element) => element.pieItemId == pieItem.id)
                  .firstOrNull ??
              PieItemInstance(pieItemId: pieItem.id),
          pieItem));
    }

    notifyListeners();
  }

  // PieMenu related --------------------------------------------------
  void updatePieMenu(PieMenu pieMenu) {
    _pieMenu.id = pieMenu.id;
    _pieMenu.name = pieMenu.name;
    _pieMenu.enabled = pieMenu.enabled;
    _pieMenu.activationMode = pieMenu.activationMode;
    _pieMenu.openInScreenCenter = pieMenu.openInScreenCenter;
    _pieMenu.mainColor = pieMenu.mainColor;
    _pieMenu.secondaryColor = pieMenu.secondaryColor;
    _pieMenu.iconColor = pieMenu.iconColor;
    _pieMenu.escapeRadius = pieMenu.escapeRadius;
    _pieMenu.centerRadius = pieMenu.centerRadius;
    _pieMenu.centerThickness = pieMenu.centerThickness;
    _pieMenu.iconSize = pieMenu.iconSize;
    _pieMenu.pieItemRoundness = pieMenu.pieItemRoundness;
    _pieMenu.pieItemSpread = pieMenu.pieItemSpread;
    _pieMenu.profiles = pieMenu.profiles;
    _pieMenu.pieItemInstances = pieMenu.pieItemInstances;

    notifyListeners();
  }

  // PieItem related --------------------------------------------------
  bool putPieItem(PieItem pieItem) {
    if (!addPieItem(pieItem)) {
      return updatePieItem(pieItem);
    }

    return true;
  }

  bool updatePieItem(PieItem pieItem) {
    for (PieItem item in pieItems) {
      if (item.id == pieItem.id) {
        item.displayName = pieItem.displayName;
        item.iconBase64 = pieItem.iconBase64;
        item.enabled = pieItem.enabled;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  /// Add a pie item to current pie menu.
  /// Do nothing if a pie item with the same id already exists.
  bool addPieItem(PieItem pieItem) {
    if (pieItems.where((element) => element.id == pieItem.id).isNotEmpty) {
      return false;
    }

    pieItem.id = nextId--;
    _pieItemInstances = [
      ..._pieItemInstances,
      RealPieItemInstance(PieItemInstance(pieItemId: pieItem.id), pieItem)
    ];
    _pieItemTasks[pieItem.id] = {};
    notifyListeners();
    return true;
  }

  // PieItemTask related ----------------------------------------------

  Set<PieItemTask> getTasksOf(PieItem pieItem) {
    final allTasks = _pieItemTasks[pieItem.id];
    if (allTasks == null) {
      return {};
    }

    return allTasks.where((element) => element.id != deleteId).toSet();
  }

  /// Update a task of a pie item.
  /// Do nothing if the pie item or the task does not exist.
  bool updateTaskIn(PieItem item, PieItemTask task) {
    for (PieItemTask pieItemTask in _pieItemTasks[item.id] ?? {}) {
      if (pieItemTask.id == task.id) {
        pieItemTask.arguments = task.arguments;
        pieItemTask.taskType = task.taskType;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  /// Add a task to a pie item.
  /// Do nothing if a task with the same id already exists or the pie item does not exist.
  bool addTaskTo(PieItem pieItem, PieItemTask task) {
    if (_pieItemTasks[pieItem.id] == null ||
        _pieItemTasks[pieItem.id]!
            .where((element) => element.id == task.id)
            .isNotEmpty) {
      return false;
    }

    task.id = nextId--;

    _pieItemTasks[pieItem.id] = {..._pieItemTasks[pieItem.id]!, task};
    notifyListeners();
    return true;
  }

  void removeTaskFrom(PieItem pieItem, PieItemTask pieItemTask) {
    if (_pieItemTasks[pieItem.id] == null) {
      return;
    }

    for (PieItemTask task in _pieItemTasks[pieItem.id]!) {
      if (task.id == pieItemTask.id) {
        task.id = deleteId;
        break;
      }
    }

    notifyListeners();
  }

  void reorderPieItem(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) {
      return;
    }

    if (oldIndex > newIndex) {
      newIndex += 1;
    }

    RealPieItemInstance pieItem = _pieItemInstances.elementAt(oldIndex);
    _pieItemInstances.remove(pieItem);

    for (int i = newIndex; i < _pieItemInstances.length; i++) {
      _pieItemInstances.add(pieItem);

      pieItem = _pieItemInstances.elementAt(newIndex);
      _pieItemInstances.remove(pieItem);
    }
    _pieItemInstances.add(pieItem);

    notifyListeners();
  }

  bool removePieItem(PieItem pieItem) {
    if (_pieItemInstances.length <= 1) {
      return false;
    }

    _pieItemInstances.removeWhere((element) => element.pieItem.id == pieItem.id);
    _pieItemTasks.remove(pieItem.id);
    notifyListeners();
    return true;
  }

  // PieItemInstance related ------------------------------------------
  void updatePieItemInstance(RealPieItemInstance pieItemInstance) {
    for (int i = 0; i < _pieItemInstances.length; i++) {
      if (_pieItemInstances[i].pieItem.id == pieItemInstance.pieItem.id) {
        _pieItemInstances[i] = pieItemInstance;
        break;
      }
    }
    final pieItemInstances = _pieItemInstances.map((e) => PieItemInstance(
          pieItemId: e.pieItem.id,
          keyCode: e.keyCode,
        ));
    _pieMenu.pieItemInstances = pieItemInstances.toList();
    notifyListeners();

  }
}
