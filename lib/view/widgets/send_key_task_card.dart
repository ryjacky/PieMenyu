import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu/view/widgets/draggable_number_field.dart';
import 'package:pie_menyu/view/widgets/key_press_recorder.dart';

class SendKeyTaskCard extends StatefulWidget {
  final SendKeyTask sendKeyTask;
  final Function(SendKeyTask)? onSendKeyTaskChange;

  const SendKeyTaskCard(
      {super.key, required this.sendKeyTask, this.onSendKeyTaskChange});

  @override
  State<SendKeyTaskCard> createState() => _SendKeyTaskCardState();
}

class _SendKeyTaskCardState extends State<SendKeyTaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("label-hotkey-task".i18n()),
            trailing: SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("label-repeat".i18n()),
                  const Gap(10),
                  SizedBox(
                    width: 50,
                    child: DraggableNumberField(
                      value: widget.sendKeyTask.repeat,
                      onChanged: (value) {
                        widget.onSendKeyTaskChange
                            ?.call(widget.sendKeyTask..repeat = value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text("label-hotkey".i18n()),
            trailing: SizedBox(
              width: 160,
              child: KeyPressRecorder(
                  initalHotKey: widget.sendKeyTask.hotkey,
                  onHotKeyRecorded: (hotkey) {
                    widget.onSendKeyTaskChange
                        ?.call(widget.sendKeyTask..hotkey = hotkey);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
