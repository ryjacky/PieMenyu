import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu/hotkey/system_key_event.dart';
import 'package:pie_menyu/window/pie_menyu_window_manager.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/executor/executor_service.dart';
import 'package:pie_menyu_core/pieItemTasks/mouse_click_task.dart';
import 'package:pie_menyu_core/pieItemTasks/move_window_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_app_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_editor_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_folder_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_sub_menu_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_url_task.dart';
import 'package:pie_menyu_core/pieItemTasks/resize_window_task.dart';
import 'package:pie_menyu_core/pieItemTasks/run_file_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_text_task.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';

import 'pie_menu_state_provider.dart';

class PieMenuScreenViewModel extends ChangeNotifier {
  PieMenuStateProvider pieMenuStateProvider;
  PieMenyuWindow pieMenyuWindow;
  ExecutorService executorService;
  SystemKeyEvent systemKeyEvent;
  Database db;

  PieMenuScreenViewModel(
    this.executorService,
    this.pieMenyuWindow,
    this.pieMenuStateProvider,
    this.systemKeyEvent,
    this.db,
  );

  bool systemKeyEventListener(HotKey hotKey) {
    final pieMenuStates = pieMenuStateProvider.pieMenuStates;
    if (pieMenuStates.lastOrNull == null ||
        pieMenuStates.firstOrNull?.behavior.activationMode !=
            ActivationMode.onRelease) return false;

    tryActivate(pieMenuStates.last, ActivationMode.onRelease);
    return true;
  }

  tryActivate(
    PieMenuState state,
    ActivationMode mode,
  ) async {
    log("ActivationMode: $mode", name: "PieMenuScreen tryActivate()");

    final pieMenuStates = pieMenuStateProvider.pieMenuStates;
    PieItem? activePieItem = state.activePieItemDelegate.pieItem;

    if (state != pieMenuStates.lastOrNull || activePieItem == null) return;

    final mainMenuState = pieMenuStates[0];
    final bool isSubMenuItem = activePieItem.tasks.firstOrNull?.taskType ==
        PieItemTaskType.openSubMenu;

    log("isSubMenuItem: $isSubMenuItem");

    final activationMode = isSubMenuItem
        ? mainMenuState.behavior.subMenuActivationMode
        : mainMenuState.behavior.activationMode;

    if (mode == ActivationMode.onRelease) clearStateAndHide();

    if (activationMode == mode) {
      if (isSubMenuItem) {
        log("Opening sub menu", name: "PieMenuScreen tryActivate()");
        openSubMenu(activePieItem);
      } else {
        log("Executing tasks", name: "PieMenuScreen tryActivate()");
        if (mainMenuState == state) executorService.cancelAll();

        clearStateAndHide();

        addToExecutorQueue(executorService, activePieItem.tasks);
        await hotKeyManager.unregisterAll();
        await executorService.start();
        await systemKeyEvent.registerHotkey();
      }
    }
  }

  void clearStateAndHide() {
    pieMenuStateProvider.clearStates();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      await pieMenyuWindow.hide();
    });
  }

  bool screenKeyEventHandler(KeyEvent event) {
    final pieMenuStates = pieMenuStateProvider.pieMenuStates;
    // Handles slice hotkey
    if (event is KeyUpEvent) {
      final lastPieMenuState = pieMenuStates.lastOrNull;
      if (lastPieMenuState == null) {
        pieMenyuWindow.hide();
        return false;
      }

      PieItemDelegate? instanceOfKey = lastPieMenuState.pieItemDelegates
          .where((instance) =>
              instance.keyCode.toUpperCase() == event.character?.toUpperCase())
          .firstOrNull;
      if (instanceOfKey == null) {
        if (!_isModifierKey(event.logicalKey)) pieMenyuWindow.hide();

        return false;
      }

      lastPieMenuState.activePieItemDelegate = instanceOfKey;

      tryActivate(lastPieMenuState, ActivationMode.onRelease);
      return true;
    }

    return false;
  }

  bool _isModifierKey(LogicalKeyboardKey logicalKey) {
    return [
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.controlRight,
      LogicalKeyboardKey.controlLeft,
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.shiftRight,
      LogicalKeyboardKey.shiftLeft,
      LogicalKeyboardKey.alt,
      LogicalKeyboardKey.altRight,
      LogicalKeyboardKey.altLeft,
      LogicalKeyboardKey.meta,
      LogicalKeyboardKey.metaRight,
      LogicalKeyboardKey.metaLeft,
    ].contains(logicalKey);
  }

  void addToExecutorQueue(
      ExecutorService executorService, List<PieItemTask> tasks) {
    for (PieItemTask task in tasks) {
      switch (task.taskType) {
        case PieItemTaskType.sendKey:
          executorService.execute(SendKeyTask.from(task));
        case PieItemTaskType.mouseClick:
          executorService.execute(MouseClickTask.from(task));
        case PieItemTaskType.runFile:
          executorService.execute(RunFileTask.from(task));
        case PieItemTaskType.openFolder:
          executorService.execute(OpenFolderTask.from(task));
        case PieItemTaskType.openApp:
          executorService.execute(OpenAppTask.from(task));
        case PieItemTaskType.openUrl:
          executorService.execute(OpenUrlTask.from(task));
        case PieItemTaskType.openEditor:
          executorService.execute(OpenEditorTask.from(task));
        case PieItemTaskType.resizeWindow:
          executorService.execute(ResizeWindowTask.from(task));
        case PieItemTaskType.moveWindow:
          executorService.execute(MoveWindowTask.from(task));
        case PieItemTaskType.sendText:
          executorService.execute(PasteTextTask.from(task));
        case PieItemTaskType.openSubMenu:
          break;
      }
    }
  }

  void openSubMenu(PieItem activePieItem) async {
    final tasks = activePieItem.tasks;
    if (tasks.length != 1) return;

    final openSubMenuTask = OpenSubMenuTask.from(tasks.first);
    final pieMenu =
        (await db.getPieMenus(ids: [openSubMenuTask.subMenuId])).firstOrNull;

    if (pieMenu == null) return;

    final pieMenuState = PieMenuState.fromPieMenu(db, pieMenu);
    pieMenuStateProvider.addState(pieMenuState);
  }
}
