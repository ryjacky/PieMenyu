import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pie_menyu_core/pieItemTasks/send_text_task.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:provider/provider.dart';

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
      label: "label-paste-text-task".tr(),
      onDelete: widget.onDelete,
      children: [
        ListTile(
          leading: Text("label-text".tr()),
          title: MinimalTextField(
            content: task.text,
            onSubmitted: (value) {
              setState(() {
                task = task..text = value;
              });
              final pieItem = state.activePieItemInstance;
              state.updateTaskIn(pieItem, task);
            },
          ),
        )
      ],
    );
  }
}
