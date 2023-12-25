import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:provider/provider.dart';

import '../../routes/pieMenuEditorPage/pie_menu_editor_page_view_model.dart';
import '../keyboard_view.dart';
import 'pie_item_task_card.dart';

class SendKeyTaskCard extends StatelessWidget {
  final SendKeyTask sendKeyTask;
  final int order;

  const SendKeyTaskCard({super.key, required this.sendKeyTask, required this.order});

  @override
  Widget build(BuildContext context) {
    return PieItemTaskCard(
        pieItemTask: sendKeyTask,
        label: "label-mouse-click-task".i18n(),
        children: [
          ListTile(
              leading: Text("label-hotkey".i18n()),
              title: Text(sendKeyTask.hotkeyString),
              trailing: TextButton(
                onPressed: () async {
                  SendKeyTask task = await showKeyboardDialog(context);
                  context
                      .read<PieMenuEditorPageViewModel>()
                      .replacePieItemTaskInCurrentPieItemAt(
                      order, task);
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
          backgroundColor:
          Theme.of(context).colorScheme.secondaryContainer,
          content: SizedBox(
            width: 1000,
            height: 300,
            child: KeyboardView(
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
                  backgroundColor:
                  Theme.of(context).colorScheme.background),
              child: Text("label-cancel".i18n()),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor:
                  Theme.of(context).colorScheme.background),
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
