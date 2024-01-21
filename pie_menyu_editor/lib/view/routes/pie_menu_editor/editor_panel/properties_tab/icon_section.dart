import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/collapasable_color_picker.dart';
import 'package:pie_menyu_editor/view/widgets/draggable_number_field.dart';
import 'package:provider/provider.dart';

class IconSection extends StatelessWidget {
  const IconSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PieMenuState>();
    final icon = context.select<PieMenuState, PieMenuIcon>((value) => value.icon);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-icon".i18n(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        CollapsableColorPicker(
          title: Text("label-icon-color".i18n()),
          color: Color(icon.color),
          onColorChanged: (color) {
            state.updatePieMenu(icon: icon..color = color.value);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Icon Size"),
            ),
            SizedBox(
              width: 70,
              child: DraggableNumberField(
                min: 0,
                max: 64,
                value: icon.size,
                onChanged: (double value) {
                  state.updatePieMenu(icon: icon..size = value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
