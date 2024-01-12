import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/pieItemTasks/open_app_task.dart';
import 'package:pie_menyu_core/pieItemTasks/run_file_task.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:provider/provider.dart';

import '../../routes/pieMenuEditorPage/pie_menu_state.dart';
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
      label: "label-open-app-task".i18n(),
      onDelete: widget.onDelete,
      children: [
        ListTile(
          leading: Text("label-window-title".i18n()),
          title: MinimalTextField(
            content: task.windowTitle,
            onSubmitted: (value) {
              setState(() {
                task = task..windowTitle = value;
              });
              final pieItem = state.activePieItem;
              if (pieItem != null) {
                state.updateTaskIn(pieItem, task);
              }
            },
          ),
        ),
        ListTile(
          leading: Text("label-exe".i18n()),
          title: Text(task.appPath),
        ),
        TextButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: [
                "exe",
              ],
            );

            if (result != null) {
              setState(() {
                task = task..appPath = result.files.single.path!;
              });
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
          child: Text("label-pick-app".i18n()),
        ),
        const Gap(10),
      ],
    );
  }
}
