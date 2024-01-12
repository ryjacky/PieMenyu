import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/pieItemTasks/run_file_task.dart';
import 'package:provider/provider.dart';

import '../../routes/pieMenuEditorPage/pie_menu_state.dart';
import 'pie_item_task_card.dart';

class RunFileTaskCard extends StatefulWidget {
  final RunFileTask task;
  final int order;
  final VoidCallback? onDelete;

  const RunFileTaskCard(
      {super.key, required this.task, required this.order, this.onDelete});

  @override
  State<RunFileTaskCard> createState() => _RunFileTaskCardState();
}

class _RunFileTaskCardState extends State<RunFileTaskCard> {
  late RunFileTask task;

  @override
  void initState() {
    task = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PieItemTaskCard(
      label: "label-run-file-task".i18n(),
      onDelete: widget.onDelete,
      children: [
        ListTile(
          leading: Text("label-file-path".i18n()),
          title: Text(task.filePath),
        ),
        TextButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              setState(() {
                task = task..filePath = result.files.single.path!;
              });
              final state = context.read<PieMenuState>();
              final pieItem = state.activePieItem;
              if (pieItem != null) {
                state.updateTaskIn(pieItem, task);
              }
            } else {
              // User canceled the picker
            }
          },
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.background),
          child: Text("label-pick-file".i18n()),
        ),
        const Gap(10),
      ],
    );
  }
}