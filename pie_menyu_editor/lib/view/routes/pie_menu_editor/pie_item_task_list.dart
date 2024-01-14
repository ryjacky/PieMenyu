import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/pieItemTasks/mouse_click_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_app_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_folder_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_sub_menu_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_url_task.dart';
import 'package:pie_menyu_core/pieItemTasks/run_file_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_text_task.dart';
import 'package:pie_menyu_editor/view/widgets/pieItemTask/open_app_task_card.dart';
import 'package:pie_menyu_editor/view/widgets/pieItemTask/open_folder_task_card.dart';
import 'package:pie_menyu_editor/view/widgets/pieItemTask/open_sub_menu_task_card.dart';
import 'package:pie_menyu_editor/view/widgets/pieItemTask/send_key_task_card.dart';
import 'package:provider/provider.dart';

import '../../widgets/pieItemTask/mouse_click_task_card.dart';
import '../../widgets/pieItemTask/open_url_task_card.dart';
import '../../widgets/pieItemTask/run_file_task_card.dart';
import '../../widgets/pieItemTask/send_text_task_card.dart';
import 'pie_menu_state.dart';

class PieItemTaskList extends StatefulWidget {
  const PieItemTaskList({super.key});

  @override
  State<PieItemTaskList> createState() => _PieItemTaskListState();
}

class _PieItemTaskListState extends State<PieItemTaskList> {
  @override
  Widget build(BuildContext context) {
    final state = context.read<PieMenuState>();
    final Set<PieItemTask> pieItemTasks =
        context.select<PieMenuState, Set<PieItemTask>>((viewModel) =>
            viewModel.getTasksOf(state.activePieItem ?? PieItem()));

    return Theme(
      data: ThemeData(
          useMaterial3: true,
          colorScheme: Theme.of(context).colorScheme,
          textTheme: Theme.of(context).textTheme),
      child: ListView(
        children: [
          for (int i = 0; i < pieItemTasks.length; i++)
            getTaskCard(pieItemTasks.elementAt(i), i),
        ],
      ),
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
    final pieItem = state.activePieItem;
    if (pieItem != null) {
      state.removeTaskFrom(pieItem, task);
    }
  }
}