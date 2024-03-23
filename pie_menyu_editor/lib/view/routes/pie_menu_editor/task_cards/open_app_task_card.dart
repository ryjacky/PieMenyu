import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pie_menyu_core/pieItemTasks/open_app_task.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/file_picker_droppable.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:provider/provider.dart';

import 'pie_item_task_card.dart';


class OpenAppTaskCard extends StatefulWidget {
  final OpenAppTask task;
  final int order;
  final VoidCallback? onDelete;

  const OpenAppTaskCard(
      {super.key, required this.task, required this.order, this.onDelete});

  @override
  State<OpenAppTaskCard> createState() => _OpenAppTaskCardState();
}

class _OpenAppTaskCardState extends State<OpenAppTaskCard> {
  late OpenAppTask task;

  @override
  void initState() {
    task = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<PieMenuState>();

    return PieItemTaskCard(
      label: "label-open-app-task".tr(),
      onDelete: widget.onDelete,
      children: [
        ListTile(
          leading: Text("label-window-title".tr()),
          title: Tooltip(
            message: "tooltip-always-launch-if-empty-window-title".tr(),
            child: MinimalTextField(
              content: task.windowTitle,
              onSubmitted: (value) {
                setState(() {
                  task = task..windowTitle = value;
                });
                final pieItem = state.activePieItemDelegate;
                state.updateTaskIn(pieItem, task);
              },
            ),
          ),
        ),
        Container(
          width: 300,
          padding: const EdgeInsets.all(8.0),
          child: FilePickerDroppable(
            path: task.appPath.isEmpty ? null : task.appPath,
            isDirectory: false,
            allowedExtension: const ["exe"],
            onPicked: (path) {
              setState(() {
                final state = context.read<PieMenuState>();
                final pieItem = state.activePieItemDelegate;
                state.updateTaskIn(pieItem, task..appPath = path);
              });
            },
          ),
        ),
        const Gap(10),
      ],
    );
  }
}
