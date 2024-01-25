import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/pieItemTasks/open_folder_task.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
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
      label: "label-open-folder-task".i18n(),
      onDelete: widget.onDelete,
      children: [
        ListTile(
          leading: Text("label-directory".i18n()),
          title: Text(task.folderPath),
        ),
        TextButton(
          onPressed: () async {
            String? result = await FilePicker.platform.getDirectoryPath();

            if (result != null && context.mounted) {
              setState(() {
                task = task..folderPath = result;
              });
              final state = context.read<PieMenuState>();
              final pieItem = state.activePieItemInstance;
              state.updateTaskIn(pieItem, task);
            } else {
              // User canceled the picker
            }
          },
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.background),
          child: Text("label-pick-folder".i18n()),
        ),
        const Gap(10),
      ],
    );
  }
}
