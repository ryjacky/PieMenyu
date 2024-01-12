import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/pieItemTasks/open_url_task.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:provider/provider.dart';

import '../../routes/pieMenuEditorPage/pie_menu_state.dart';
import 'pie_item_task_card.dart';

class OpenUrlTaskCard extends StatefulWidget {
  final OpenUrlTask task;
  final int order;
  final VoidCallback? onDelete;

  const OpenUrlTaskCard(
      {super.key, required this.task, required this.order, this.onDelete});

  @override
  State<OpenUrlTaskCard> createState() => _OpenUrlTaskCardState();
}

class _OpenUrlTaskCardState extends State<OpenUrlTaskCard> {
  late OpenUrlTask task;

  @override
  void initState() {
    task = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<PieMenuState>();

    return PieItemTaskCard(
      label: "label-open-url-task".i18n(),
      onDelete: widget.onDelete,
      children: [
        ListTile(
          leading: Text("label-url".i18n()),
          title: MinimalTextField(
            content: task.url,
            onSubmitted: (value) {
              setState(() {
                task = task..url = value;
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
