import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/pieItemTasks/open_url_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_text_task.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:provider/provider.dart';

import '../../routes/pieMenuEditorPage/pie_menu_state.dart';
import 'pie_item_task_card.dart';

class SendTextTaskCard extends StatefulWidget {
  final SendTextTask task;
  final int order;
  final VoidCallback? onDelete;

  const SendTextTaskCard(
      {super.key, required this.task, required this.order, this.onDelete});

  @override
  State<SendTextTaskCard> createState() => _SendTextTaskCardState();
}

class _SendTextTaskCardState extends State<SendTextTaskCard> {
  late SendTextTask task;

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
