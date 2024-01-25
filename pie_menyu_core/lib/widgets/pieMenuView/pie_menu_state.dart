import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'dart:developer';

class PieMenuState extends ChangeNotifier {
  int _nextId = -1;
  String name = "Loading...";

  PieMenuColors _colors = PieMenuColors();

  PieMenuColors get colors => _colors;

  set colors(PieMenuColors colors) {
    _colors = colors;
    notifyListeners();
  }

  PieMenuIcon _icon = PieMenuIcon();

  PieMenuIcon get icon => _icon;

  set icon(PieMenuIcon icon) {
    _icon = icon;
    notifyListeners();
  }

  PieMenuFont _font = PieMenuFont();

  PieMenuFont get font => _font;

  set font(PieMenuFont font) {
    _font = font;
    notifyListeners();
  }

  PieMenuBehavior _behavior = PieMenuBehavior();

  PieMenuBehavior get behavior => _behavior;

  set behavior(PieMenuBehavior behavior) {
    _behavior = behavior;
    notifyListeners();
  }

  PieMenuShape _shape = PieMenuShape();

  PieMenuShape get shape => _shape;

  set shape(PieMenuShape shape) {
    _shape = shape;
    notifyListeners();
  }

  PieItemInstance _activePieItemInstance = PieItemInstance();

  PieItemInstance get activePieItemInstance => _activePieItemInstance;

  set activePieItemInstance(PieItemInstance instance) {
    _activePieItemInstance = instance;
    notifyListeners();
  }

  List<PieItemInstance> _pieItemInstances = [];

  List<PieItemInstance> get pieItemInstances => _pieItemInstances;

  final PieMenu _initialPieMenu;

  PieMenu get pieMenu => PieMenu.from(_initialPieMenu)
    ..pieItemInstances = _pieItemInstances
    ..name = name
    ..icon = _icon
    ..font = _font
    ..colors = _colors
    ..behavior = _behavior
    ..shape = _shape;

  final Database _db;

  PieMenuState(this._db, PieMenu pieMenu) : _initialPieMenu = pieMenu {
    name = pieMenu.name;
    load();
  }

  load() async {
    shape = PieMenuShape.from(_initialPieMenu.shape);
    colors = PieMenuColors.from(_initialPieMenu.colors);
    icon = PieMenuIcon.from(_initialPieMenu.icon);
    font = PieMenuFont.from(_initialPieMenu.font);
    behavior = PieMenuBehavior.from(_initialPieMenu.behavior);

    for (PieItemInstance pieItemInstance in _initialPieMenu.pieItemInstances) {
      await _db.loadPieItemInstance(pieItemInstance);
    }
    _pieItemInstances = _initialPieMenu.pieItemInstances
        .map((e) => PieItemInstance.from(e))
        .toList();
    _activePieItemInstance = _pieItemInstances.first;

    notifyListeners();
  }

  updatePieMenu(
      {PieMenuColors? colors,
      PieMenuIcon? icon,
      PieMenuFont? font,
      PieMenuBehavior? behavior,
      PieMenuShape? shape}) {
    if (colors != null) {
      _colors = colors;
    }
    if (icon != null) {
      _icon = icon;
    }
    if (font != null) {
      _font = font;
    }
    if (behavior != null) {
      _behavior = behavior;
    }
    if (shape != null) {
      _shape = shape;
    }
    notifyListeners();
  }

  addTaskTo(PieItemInstance pieItemInstance, PieItemTask task) {
    final pieItem = pieItemInstance.pieItem;
    if (pieItem == null) {
      throw Exception("PieItemInstance has no pieItem");
    }

    pieItem.tasks.add(task);
    notifyListeners();
  }

  putPieItem(PieItem pieItem) {
    final instance = _pieItemInstances
        .where((element) => element.pieItemId == pieItem.id)
        .firstOrNull;

    if (instance == null) {
      log("putPieItem: ${pieItem.id}");
      log("_pieItemInstances: ${_pieItemInstances.map((e) => e.pieItemId)}");
      pieItem.id = _nextId--;
      _pieItemInstances
          .add(PieItemInstance(pieItemId: pieItem.id)..pieItem = pieItem);
    } else {
      instance.pieItem = pieItem;
    }

    notifyListeners();
  }

  bool removePieItem(PieItem pieItem) {
    if (_pieItemInstances.length <= 1) return false;
    _pieItemInstances.removeWhere((element) => element.pieItemId == pieItem.id);
    notifyListeners();
    return true;
  }

  updatePieItemInstance(PieItemInstance instance) {
    final index =
        _pieItemInstances.indexWhere((element) => element == instance);
    if (index == -1) {
      throw Exception("PieItemInstance not found");
    }

    _pieItemInstances[index] = instance;
    notifyListeners();
  }

  reorderPieItem(int fromIndex, int toIndex) {
    if (fromIndex == toIndex) {
      return;
    }

    if (fromIndex > toIndex) {
      toIndex += 1;
    }

    PieItemInstance instance = _pieItemInstances.elementAt(fromIndex);
    _pieItemInstances.remove(instance);

    for (int i = toIndex; i < _pieItemInstances.length; i++) {
      _pieItemInstances.add(instance);

      instance = _pieItemInstances.elementAt(toIndex);
      _pieItemInstances.remove(instance);
    }
    _pieItemInstances.add(instance);

    notifyListeners();
  }

  removeTaskFrom(PieItemInstance pieItemInstance, PieItemTask pieItemTask) {
    final pieItem = pieItemInstance.pieItem;
    if (pieItem == null) {
      throw Exception("PieItemInstance has no pieItem");
    }

    pieItem.tasks.removeWhere((element) => element == pieItemTask);
    notifyListeners();
  }

  updateTaskIn(PieItemInstance pieItemInstance, PieItemTask pieItemTask) {
    final pieItem = pieItemInstance.pieItem;
    if (pieItem == null) {
      throw Exception("PieItemInstance has no pieItem");
    }

    final index = pieItem.tasks.indexWhere((element) => element.runtimeId == pieItemTask.runtimeId);
    if (index == -1) {
      throw Exception("PieItemTask not found, tasks available: ${pieItem.tasks.map((e) => e.runtimeId)}, finding: ${pieItemTask.runtimeId}");
    }

    pieItem.tasks[index] = pieItemTask;
    notifyListeners();
  }
}
