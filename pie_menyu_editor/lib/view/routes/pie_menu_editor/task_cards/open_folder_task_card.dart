import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pie_menyu_core/pieItemTasks/open_folder_task.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/file_picker_droppable.dart';
import 'package:provider/provider.dart';

import 'pie_item_task_card.dart';

class OpenFolderTaskCard extends StatefulWidget {
  final OpenFolderTask task;
  final int order;
  final VoidCallback? onDelete;

  const OpenFolderTaskCard(
      {super.key, required this.task, required this.order, this.onDelete});

  @override
  State<OpenFolderTaskCard> createState() => _OpenFolderTaskCardState();
}

class _OpenFolderTaskCardState extends State<OpenFolderTaskCard> {
  late OpenFolderTask task;

  @override
  void initState() {
    task = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PieItemTaskCard(
      label: "label-open-folder-task".tr(),
      onDelete: widget.onDelete,
      children: [
        Container(
          width: 300,
          padding: const EdgeInsets.all(8.0),
          child: FilePickerDroppable(
            path: task.folderPath.isEmpty ? null : task.folderPath,
            isDirectory: true,
            onPicked: (path) {
              setState(() {
                final state = context.read<PieMenuState>();
                final pieItem = state.activePieItemInstance;
                state.updateTaskIn(pieItem, task..folderPath = path);
              });
            },
          ),
        ),
      ],
    );
  }
}
