import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/pieItemTasks/send_text_task.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:provider/provider.dart';

import '../../routes/pieMenuEditorPage/pie_menu_state.dart';
import 'pie_item_task_card.dart';

class PasteTextTaskCard extends StatefulWidget {
  final PasteTextTask task;
  final int order;
  final VoidCallback? onDelete;

  const PasteTextTaskCard(
      {super.key, required this.task, required this.order, this.onDelete});

  @override
  State<PasteTextTaskCard> createState() => _PasteTextTaskCardState();
}

class _PasteTextTaskCardState extends State<PasteTextTaskCard> {
  late PasteTextTask task;

  @override
  void initState() {
    task = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<PieMenuState>();

    return PieItemTaskCard(
      label: "label-send-text-task".i18n(),
      onDelete: widget.onDelete,
      children: [
        ListTile(
          leading: Text("label-text".i18n()),
          title: MinimalTextField(
            content: task.text,
            onSubmitted: (value) {
              setState(() {
                task = task..text = value;
              });
              final pieItem = state.activePieItem;
              if (pieItem != null) {
                state.updateTaskIn(pieItem, task);
              }
            },
          ),
        )
      ],
    );
  }
}
