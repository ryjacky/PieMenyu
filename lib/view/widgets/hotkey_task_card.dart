import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/pie_item_task.dart';
import 'package:pie_menyu/view/widgets/draggable_number_field.dart';
import 'package:pie_menyu/view/widgets/key_press_recorder.dart';

class HotkeyTaskCard extends StatelessWidget {
  final PieItemTask pieItemTask;

  const HotkeyTaskCard({super.key, required this.pieItemTask});

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
                        value: pieItemTask.repeat, onChanged: (value) {}),
                  ),
                ],
              ),
            )
        ),
        ListTile(
          title: Text("label-hotkey".i18n()),
          trailing: SizedBox(
            width: 160,
            child: KeyPressRecorder(onHotKeyRecorded: (hotkey){}),
          ),
        )
      ],

    ));
  }
}
