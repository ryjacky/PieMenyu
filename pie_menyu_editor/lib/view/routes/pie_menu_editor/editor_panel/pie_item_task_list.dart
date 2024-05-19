import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/pieItemTasks/mouse_click_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_app_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_folder_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_sub_menu_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_url_task.dart';
import 'package:pie_menyu_core/pieItemTasks/run_file_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_text_task.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/pie_menu_page_view_model.dart';
import 'package:provider/provider.dart';

import '../task_cards/mouse_click_task_card.dart';
import '../task_cards/open_app_task_card.dart';
import '../task_cards/open_folder_task_card.dart';
import '../task_cards/open_sub_menu_task_card.dart';
import '../task_cards/open_url_task_card.dart';
import '../task_cards/run_file_task_card.dart';
import '../task_cards/send_key_task_card.dart';
import '../task_cards/send_text_task_card.dart';

class PieItemTaskList extends StatefulWidget {
  const PieItemTaskList({super.key});

  @override
  State<PieItemTaskList> createState() => _PieItemTaskListState();
}

class _PieItemTaskListState extends State<PieItemTaskList> {
  @override
  Widget build(BuildContext context) {
    final pieItemDelegate = context.watch<PieMenuState>().activePieItemDelegate;
    final toDelete = context.select<PieMenuEditorPageViewModel, PieItemTask?>(
      (viewModel) => viewModel.toDelete?.key,
    );

    if (pieItemDelegate.pieItem == null) {
      throw Exception("pieItem is null");
    }

    final pieItemTasks =
        pieItemDelegate.pieItem!.tasks.where((element) => element != toDelete);

    return ListView(
      children: [

        for (int i = 0; i < pieItemTasks.length; i++)
          getTaskCard(pieItemTasks.elementAt(i), i),
      ],
    );
  }

  getTaskCard(PieItemTask pieItemTask, int order) {
    switch (pieItemTask.taskType) {
      case PieItemTaskType.sendKey:
        return SendKeyTaskCard(
          sendKeyTask: SendKeyTask.from(pieItemTask),
          order: order,
          onDelete: () => removeTask(pieItemTask),
        );
      case PieItemTaskType.mouseClick:
        final mouseClickTask = MouseClickTask.from(pieItemTask);
        return MouseClickTaskCard(
          mouseClickTask: mouseClickTask,
          order: order,
          onDelete: () => removeTask(pieItemTask),
        );
      case PieItemTaskType.runFile:
        final runFileTask = RunFileTask.from(pieItemTask);
        return RunFileTaskCard(
          task: runFileTask,
          order: order,
          onDelete: () => removeTask(pieItemTask),
        );
      case PieItemTaskType.openSubMenu:
        final openSubMenuTask = OpenSubMenuTask.from(pieItemTask);
        return OpenSubMenuTaskCard(
          task: openSubMenuTask,
          order: order,
          onDelete: () => removeTask(pieItemTask),
        );
      case PieItemTaskType.openFolder:
        final task = OpenFolderTask.from(pieItemTask);
        return OpenFolderTaskCard(
          task: task,
          order: order,
          onDelete: () => removeTask(pieItemTask),
        );
      case PieItemTaskType.openApp:
        final task = OpenAppTask.from(pieItemTask);
        return OpenAppTaskCard(
          task: task,
          order: order,
          onDelete: () => removeTask(pieItemTask),
        );
      case PieItemTaskType.openUrl:
        final task = OpenUrlTask.from(pieItemTask);
        return OpenUrlTaskCard(
          task: task,
          order: order,
          onDelete: () => removeTask(pieItemTask),
        );
      case PieItemTaskType.openEditor:
      // TODO: Handle this case.
      case PieItemTaskType.sendText:
        final task = PasteTextTask.from(pieItemTask);
        return PasteTextTaskCard(
          task: task,
          order: order,
          onDelete: () => removeTask(pieItemTask),
        );
      case PieItemTaskType.resizeWindow:
      // TODO: Handle this case.
      case PieItemTaskType.moveWindow:
      // TODO: Handle this case.
    }
  }

  removeTask(PieItemTask task) {
    final state = context.read<PieMenuState>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final viewModel = context.read<PieMenuEditorPageViewModel>();

    if (viewModel.toDelete != null) {
      viewModel.lazyDeleteTimer?.cancel();
      state.removeTaskFrom(viewModel.toDelete!.value, viewModel.toDelete!.key);
    }

    viewModel.toDelete = MapEntry(task, state.activePieItemDelegate);
    viewModel.lazyDeleteTimer = Timer(const Duration(seconds: 5), () {
      if (viewModel.toDelete == null) return;
      state.removeTaskFrom(viewModel.toDelete!.value, viewModel.toDelete!.key);
      viewModel.toDelete = null;
    });

    // Allow delete up to a single level.
    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text("message-task-deleted".tr()),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: "label-undo".tr(),
          onPressed: () {
            viewModel.lazyDeleteTimer?.cancel();
            viewModel.toDelete = null;
            scaffoldMessenger.clearSnackBars();
          },
        ),
      ),
    );
  }
}
