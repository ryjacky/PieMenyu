import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/profile.dart';
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
import 'package:pie_menyu_core/providers/pie_menu_provider.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import '../system/keyboard/keyboard_event.dart';
import '../system/keyboard/keyboard_provider.dart';
import '../system/window/foreground_window.dart';

class WindowController extends ChangeNotifier {
  static Size windowSize = const Size(1024, 1024);

  final keyboardProvider = KeyboardProvider();
  final pieMenuProvider = PieMenuProvider();
  final executorService = ExecutorService();

  WindowController() {
    keyboardProvider.addListener(() {
      if (keyboardProvider.keyEvent.type == KeyboardEventType.keyDown) {
        if (!executorService.isExecuting && keyboardProvider.keyEvent.hotkey != null) {
          showWindow(keyboardProvider.keyEvent.hotkey!);
        }
      }
      if (keyboardProvider.keyEvent.type == KeyboardEventType.keyUp) {
        executeAfterHideWindow();
      }
    });
  }

  void executeAfterHideWindow() async {
    await windowManager.hide();
    final tasks = pieMenuProvider.pieItems[executorService.activePieItemOrderIndex].tasks;
    await tasks.load();
    for (PieItemTask task in tasks) {
      switch (task.taskType) {
        case PieItemTaskType.sendKey:
          executorService.execute(SendKeyTask.from(task));
        case PieItemTaskType.mouseClick:
          executorService.execute(MouseClickTask.from(task));
        case PieItemTaskType.runFile:
          executorService.execute(RunFileTask.from(task));
        case PieItemTaskType.openSubMenu:
          executorService.execute(OpenSubMenuTask.from(task));
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
          executorService.execute(SendKeyTask.from(task));
      }
    }

    executorService.start();
  }

  void showWindow(HotKey hotKey) async {
    if (await windowManager.isFocused()) {
      return;
    }

    String foregroundApp = ForegroundWindow.get().path;

    List<Profile> profilesOfForegroundApp =
        await DB.getProfilesByExe(foregroundApp);
    Profile? profile = profilesOfForegroundApp.firstOrNull;
    profile ??= (await DB.getProfiles(ids: [1])).firstOrNull;

    if (profile == null) {
      throw Exception("Database possibly corrupted");
    }

    for (HotkeyToPieMenuId hotkeyToPieMenuId in profile.hotkeyToPieMenuIdList) {
      if (hotkeyToPieMenuId.keyCode == hotKey.keyCode) {
        try {
          pieMenuProvider.pieMenu = profile.pieMenus.firstWhere(
              (element) => element.id == hotkeyToPieMenuId.pieMenuId);
          pieMenuProvider.loadPieItems();

          final pieCenterScreenPosition = await screenRetriever.getCursorScreenPoint();

          await windowManager.setPosition(Offset(
              pieCenterScreenPosition.dx - windowSize.width / 2,
              pieCenterScreenPosition.dy - windowSize.height / 2));
          await windowManager.show();
          await windowManager.focus();

          pieMenuProvider.pieCenterScreenPosition = pieCenterScreenPosition;
        } catch (e) {
          dev.log(
              "Pie menu does not exist in profile, id: ${hotkeyToPieMenuId.pieMenuId}");
        }
      }
    }
  }
}
