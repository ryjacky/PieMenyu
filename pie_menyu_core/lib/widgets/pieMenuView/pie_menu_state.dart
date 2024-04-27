import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'dart:developer';

class PieMenuState extends ChangeNotifier {
  // Private Variables -------------------
  final PieMenu _initialPieMenu;
  final Database _db;

  int _nextId = -1;
  PieMenuColors _colors = PieMenuColors();
  PieMenuIconStyle _icon = PieMenuIconStyle();
  PieMenuFont _font = PieMenuFont();
  PieMenuBehavior _behavior = PieMenuBehavior();
  PieMenuShape _shape = PieMenuShape();
  PieItemDelegate _activePieItemDelegate = PieItemDelegate();
  List<PieItemDelegate> _pieItemDelegates = [];

  // Public Variables --------------------
  String name = "Loading...";
  final List<PieItem> toDeletePieItems = [];

  // Getters -----------------------------
  PieMenuColors get colors => _colors;

  PieMenuIconStyle get icon => _icon;

  PieMenuFont get font => _font;

  PieMenuBehavior get behavior => _behavior;

  PieMenuShape get shape => _shape;

  PieItemDelegate get activePieItemDelegate => _activePieItemDelegate;

  List<PieItemDelegate> get pieItemDelegates => _pieItemDelegates
      .where((pieItemDelegate) =>
          !toDeletePieItems.contains(pieItemDelegate.pieItem))
      .toList();

  double get runtimeHeight => math.max(icon.size, font.size + 18);

  PieMenu get pieMenu => PieMenu.from(_initialPieMenu)
    ..pieItemInstances = pieItemDelegates
    ..name = name
    ..iconStyle = _icon
    ..font = _font
    ..colors = _colors
    ..behavior = _behavior
    ..shape = _shape;

  // Setters -----------------------------
  set colors(PieMenuColors colors) {
    _colors = colors;
    notifyListeners();
  }

  set icon(PieMenuIconStyle icon) {
    _icon = icon;
    notifyListeners();
  }

  set font(PieMenuFont font) {
    _font = font;
    notifyListeners();
  }

  set behavior(PieMenuBehavior behavior) {
    _behavior = behavior;
    notifyListeners();
  }

  set shape(PieMenuShape shape) {
    _shape = shape;
    notifyListeners();
  }

  set activePieItemDelegate(PieItemDelegate instance) {
    _activePieItemDelegate = instance;
    notifyListeners();
  }

  PieMenuState.fromPieMenu(this._db, PieMenu pieMenu)
      : _initialPieMenu = pieMenu {
    name = pieMenu.name;
    load();
  }

  load() async {
    shape = PieMenuShape.from(_initialPieMenu.shape);
    colors = PieMenuColors.from(_initialPieMenu.colors);
    icon = PieMenuIconStyle.from(_initialPieMenu.iconStyle);
    font = PieMenuFont.from(_initialPieMenu.font);
    behavior = PieMenuBehavior.from(_initialPieMenu.behavior);

    for (PieItemDelegate pieItemInstance in _initialPieMenu.pieItemInstances) {
      await _db.loadPieItemInstance(pieItemInstance);
    }
    _pieItemDelegates = _initialPieMenu.pieItemInstances
        .map((e) => PieItemDelegate.from(e))
        .toList();
    _activePieItemDelegate = _pieItemDelegates.first;

    notifyListeners();
  }

  updatePieMenu(
      {PieMenuColors? colors,
      PieMenuIconStyle? icon,
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

  addTaskTo(PieItemDelegate pieItemInstance, PieItemTask task) {
    final pieItem = pieItemInstance.pieItem;
    if (pieItem == null) {
      throw Exception("PieItemInstance has no pieItem");
    }

    pieItem.tasks.add(task);
    notifyListeners();
  }

  putPieItem(PieItem pieItem) {
    final instance = _pieItemDelegates
        .where((element) => element.pieItemId == pieItem.id)
        .firstOrNull;

    if (instance == null) {
      log("putPieItem: ${pieItem.id}");
      log("_pieItemInstances: ${_pieItemDelegates.map((e) => e.pieItemId)}");
      pieItem.id = _nextId--;
      _pieItemDelegates
          .add(PieItemDelegate(pieItemId: pieItem.id)..pieItem = pieItem);
    } else {
      instance.pieItem = pieItem;
    }

    notifyListeners();
  }

  bool removePieItem(PieItem pieItem) {
    if (pieItemDelegates.length <= 1) return false;
    toDeletePieItems.add(pieItem);
    notifyListeners();
    return true;
  }

  bool undoRemove() {
    toDeletePieItems.removeLast();
    notifyListeners();
    return true;
  }

  updatePieItemDelegate(PieItemDelegate instance) {
    final index =
        _pieItemDelegates.indexWhere((element) => element == instance);
    if (index == -1) {
      throw Exception("PieItemInstance not found");
    }

    _pieItemDelegates[index] = instance;
    notifyListeners();
  }

  reorderPieItem(int fromIndex, int toIndex) {
    if (fromIndex == toIndex) {
      return;
    }

    if (fromIndex > toIndex) {
      toIndex += 1;
    }

    PieItemDelegate instance = _pieItemDelegates.elementAt(fromIndex);
    _pieItemDelegates.remove(instance);

    for (int i = toIndex; i < _pieItemDelegates.length; i++) {
      _pieItemDelegates.add(instance);

      instance = _pieItemDelegates.elementAt(toIndex);
      _pieItemDelegates.remove(instance);
    }
    _pieItemDelegates.add(instance);

    notifyListeners();
  }

  removeTaskFrom(PieItemDelegate pieItemInstance, PieItemTask pieItemTask) {
    final pieItem = pieItemInstance.pieItem;
    if (pieItem == null) {
      throw Exception("PieItemInstance has no pieItem");
    }

    pieItem.tasks.removeWhere((element) => element == pieItemTask);
    notifyListeners();
  }

  updateTaskIn(PieItemDelegate pieItemInstance, PieItemTask pieItemTask) {
    final pieItem = pieItemInstance.pieItem;
    if (pieItem == null) {
      throw Exception("PieItemInstance has no pieItem");
    }

    final index = pieItem.tasks
        .indexWhere((element) => element.runtimeId == pieItemTask.runtimeId);
    if (index == -1) {
      throw Exception(
          "PieItemTask not found, tasks available: ${pieItem.tasks.map((e) => e.runtimeId)}, finding: ${pieItemTask.runtimeId}");
    }

    pieItem.tasks[index] = pieItemTask;
    notifyListeners();
  }
}
