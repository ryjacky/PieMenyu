import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/pie_menu_state.dart';
import 'package:provider/provider.dart';

import '../keyboard_view.dart';
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
        label: "label-send-key-task".i18n(),
        onDelete: onDelete,
        children: [
          ListTile(
              leading: Text("label-hotkey".i18n()),
              title: Text(sendKeyTask.hotkeyStrings.join("+")),
              trailing: TextButton(
                onPressed: () async {
                  SendKeyTask? task = await showKeyboardDialog(context);
                  if (task != null) {
                    final state = context.read<PieMenuState>();
                    final pieItem = state.activePieItem;
                    if (pieItem != null) {
                      state.updateTaskIn(pieItem, task);
                    }
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.background),
                child: Text("label-change".i18n()),
              )),
        ]);
  }

  showKeyboardDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Theme(
        data: ThemeData(
            useMaterial3: true,
            colorScheme: Theme.of(context).colorScheme,
            textTheme: Theme.of(context).textTheme),
        child: AlertDialog(
          scrollable: true,
          contentPadding: const EdgeInsets.all(20),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          content: SizedBox(
            width: 1000,
            height: 300,
            child: KeyboardView(
              initialKeys: sendKeyTask.hotkeyStrings,
              onKeyPressed: (String key) {
                if (key == "Ctrl") {
                  sendKeyTask.ctrl = !sendKeyTask.ctrl;
                } else if (key == "Shift") {
                  sendKeyTask.shift = !sendKeyTask.shift;
                } else if (key == "Alt") {
                  sendKeyTask.alt = !sendKeyTask.alt;
                } else {
                  sendKeyTask.key = key;
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.background),
              child: Text("label-cancel".i18n()),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.background),
              onPressed: () {
                Navigator.pop(context, sendKeyTask);
              },
              child: Text("label-ok".i18n()),
            ),
          ],
        ),
      ),
    );
  }
}
