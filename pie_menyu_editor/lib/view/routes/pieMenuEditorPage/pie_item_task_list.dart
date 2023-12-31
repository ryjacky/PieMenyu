import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/pieItemTasks/mouse_click_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_sub_menu_task.dart';
import 'package:pie_menyu_core/pieItemTasks/run_file_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu_editor/view/routes/pieMenuEditorPage/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/pieItemTask/open_sub_menu_task_card.dart';
import 'package:pie_menyu_editor/view/widgets/pieItemTask/send_key_task_card.dart';
import 'package:provider/provider.dart';

import '../../widgets/pieItemTask/mouse_click_task_card.dart';
import '../../widgets/pieItemTask/run_file_task_card.dart';

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
        context.select<PieMenuState, Set<PieItemTask>>(
            (viewModel) => viewModel.getTasksOf(state.activePieItem ?? PieItem()));

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
          onDelete: () {
            final state = context.read<PieMenuState>();
            final pieItem = state.activePieItem;
            if (pieItem != null) {
              state.removeTaskFrom(pieItem, pieItemTask);
            }
          },
        );
      case PieItemTaskType.mouseClick:
        final mouseClickTask = MouseClickTask.from(pieItemTask);
        return MouseClickTaskCard(
          mouseClickTask: mouseClickTask,
          order: order,
          onDelete: () {
            final state = context.read<PieMenuState>();
            final pieItem = state.activePieItem;
            if (pieItem != null) {
              state.removeTaskFrom(pieItem, pieItemTask);
            }
          },
        );
      case PieItemTaskType.runFile:
        final runFileTask = RunFileTask.from(pieItemTask);
        return RunFileTaskCard(
          task: runFileTask,
          order: order,
          onDelete: () {
            final state = context.read<PieMenuState>();
            final pieItem = state.activePieItem;
            if (pieItem != null) {
              state.removeTaskFrom(pieItem, pieItemTask);
            }
          },
        );
      case PieItemTaskType.openSubMenu:
        final openSubMenuTask = OpenSubMenuTask.from(pieItemTask);
        return OpenSubMenuTaskCard(
          task: openSubMenuTask,
          order: order,
          onDelete: () {
            final state = context.read<PieMenuState>();
            final pieItem = state.activePieItem;
            if (pieItem != null) {
              state.removeTaskFrom(pieItem, pieItemTask);
            }
          },
        );
      case PieItemTaskType.openFolder:
      // TODO: Handle this case.
      case PieItemTaskType.openApp:
      // TODO: Handle this case.
      case PieItemTaskType.openUrl:
      // TODO: Handle this case.
      case PieItemTaskType.openEditor:
      // TODO: Handle this case.
      case PieItemTaskType.resizeWindow:
      // TODO: Handle this case.
      case PieItemTaskType.moveWindow:
      // TODO: Handle this case.
      case PieItemTaskType.sendText:
      // TODO: Handle this case.
    }
  }
}
