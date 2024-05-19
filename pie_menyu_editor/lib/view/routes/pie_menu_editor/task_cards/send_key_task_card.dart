import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/keyboard_key_selector.dart';
import 'package:provider/provider.dart';

import 'pie_item_task_card.dart';

class SendKeyTaskCard extends StatelessWidget {
  final SendKeyTask sendKeyTask;
  final int order;
  final VoidCallback? onDelete;

  const SendKeyTaskCard(
      {super.key,
      required this.sendKeyTask,
      required this.order,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PieItemTaskCard(
        label: "label-send-key-task".tr(),
        onDelete: onDelete,
        children: [
          ListTile(
              leading: Text("label-hotkey".tr()),
              title: Text(sendKeyTask.hotkeyStrings.join("+")),
              trailing: TextButton(
                onPressed: () async {
                  SendKeyTask? task = await showKeyboardDialog(context);
                  if (task != null && context.mounted) {
                    final state = context.read<PieMenuState>();
                    final pieItem = state.activePieItemDelegate;
                    state.updateTaskIn(pieItem, task);
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.background),
                child: Text("label-change".tr()),
              )),
        ]);
  }

  showKeyboardDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        contentPadding: const EdgeInsets.all(20),
        backgroundColor: Theme.of(context).colorScheme.background,
        content: SizedBox(
            width: 1000,
            height: 300,
            child: KeyboardKeySelector(
              onChange: (task){
                sendKeyTask.ctrl = task.ctrl;
                sendKeyTask.shift = task.shift;
                sendKeyTask.alt = task.alt;
                sendKeyTask.key = task.key;
              },
            )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.background),
            child: Text("label-cancel".tr()),
          ),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.background),
            onPressed: () {
              Navigator.pop(context, sendKeyTask);
            },
            child: Text("label-ok".tr()),
          ),
        ],
      ),
    );
  }
}
