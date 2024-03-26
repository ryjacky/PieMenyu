import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/collapasable_color_picker.dart';
import 'package:provider/provider.dart';

class ColorSection extends StatelessWidget {
  const ColorSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PieMenuState>();
    final colors =
        context.select<PieMenuState, PieMenuColors>((value) => value.colors);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-colors".tr(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        CollapsableColorPicker(
          title: Text("label-main-color".tr()),
          color: Color(colors.primary),
          onColorChanged: (newColor) {
            state.updatePieMenu(colors: colors..primary = newColor.value);
          },
        ),
        CollapsableColorPicker(
          title: Text("label-secondary-color".tr()),
          color: Color(colors.secondary),
          onColorChanged: (color) {
            state.updatePieMenu(colors: colors..secondary = color.value);
          },
        ),
      ],
    );
  }
}
