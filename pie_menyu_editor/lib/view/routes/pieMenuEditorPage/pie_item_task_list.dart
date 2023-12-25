import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/pieItemTasks/mouse_click_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu_editor/view/widgets/draggable_number_field.dart';
import 'package:pie_menyu_editor/view/widgets/pieItemTask/pie_item_task_card.dart';
import 'package:pie_menyu_editor/view/widgets/pieItemTask/send_key_task_card.dart';
import 'package:provider/provider.dart';

import 'pie_menu_editor_page_view_model.dart';

class PieItemTaskList extends StatefulWidget {
  const PieItemTaskList({super.key});

  @override
  State<PieItemTaskList> createState() => _PieItemTaskListState();
}

class _PieItemTaskListState extends State<PieItemTaskList> {
  @override
  Widget build(BuildContext context) {
    final List<PieItemTask> pieItemTasks =
        context.select<PieMenuEditorPageViewModel, List<PieItemTask>>(
            (viewModel) => viewModel.currentPieItemTasks);

    return Theme(
      data: ThemeData(
          useMaterial3: true,
          colorScheme: Theme.of(context).colorScheme,
          textTheme: Theme.of(context).textTheme),
      child: ListView(
        children: [
          for (int i = 0; i < pieItemTasks.length; i++)
            getTaskCard(pieItemTasks[i], i),
        ],
      ),
    );
  }

  getTaskCard(PieItemTask pieItemTask, int order) {
    switch (pieItemTask.taskType) {
      case PieItemTaskType.sendKey:
        return SendKeyTaskCard(sendKeyTask: SendKeyTask.from(pieItemTask), order: order);
      case PieItemTaskType.mouseClick:
        final mouseClickTask = MouseClickTask.from(pieItemTask);
        return PieItemTaskCard(
            pieItemTask: mouseClickTask,
            label: "label-mouse-click-task".i18n(),
            children: [
              ListTile(
                title: Text("label-x".i18n()),
                trailing: SizedBox(
                  width: 160,
                  child: DraggableNumberField(
                    value: mouseClickTask.x,
                    onChanged: (value) {
                      context
                          .read<PieMenuEditorPageViewModel>()
                          .putPieItemTaskInCurrentPieItem(
                              mouseClickTask..x = value);
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text("label-y".i18n()),
                trailing: SizedBox(
                  width: 160,
                  child: DraggableNumberField(
                    value: mouseClickTask.y,
                    onChanged: (value) {
                      context
                          .read<PieMenuEditorPageViewModel>()
                          .putPieItemTaskInCurrentPieItem(
                              mouseClickTask..y = value);
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text("label-mouse-button".i18n()),
                trailing: SizedBox(
                  width: 160,
                  child: DraggableNumberField(
                    value: mouseClickTask.y,
                    onChanged: (value) {
                      context
                          .read<PieMenuEditorPageViewModel>()
                          .putPieItemTaskInCurrentPieItem(
                              mouseClickTask..x = value);
                    },
                  ),
                ),
              )
            ]);
      case PieItemTaskType.runFile:
      // TODO: Handle this case.
      case PieItemTaskType.openSubMenu:
      // TODO: Handle this case.
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
