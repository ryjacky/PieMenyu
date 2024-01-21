import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/collapasable_color_picker.dart';
import 'package:pie_menyu_editor/view/widgets/draggable_number_field.dart';
import 'package:provider/provider.dart';

class FontSection extends StatelessWidget {
  const FontSection({super.key});
  final fonts = const [
    "Amatic SC",
    "Caveat",
    "Comfortaa",
    "Roboto",
    "Lora",
    "Montserrat",
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.read<PieMenuState>();
    final font = context.select<PieMenuState, PieMenuFont>((value) => value.font);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-font".i18n(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        CollapsableColorPicker(
          title: Text("label-font-color".i18n()),
          color: Color(font.color),
          onColorChanged: (color) {
            state.updatePieMenu(font: font..color = color.value);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
                child: Text("Font Family")),
            DropdownMenu(
              menuHeight: 300,
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                constraints: BoxConstraints.tight(const Size.fromHeight(40)),
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              initialSelection: font.fontFamily,
              dropdownMenuEntries: fonts
                  .map((e) => DropdownMenuEntry(value: e, label: e))
                  .toList(),
              onSelected: (String? value) {
                if (value == null) return;
                state.updatePieMenu(font: font..fontFamily = value);
              },
            ),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42.0, 0, 0, 0),
              child: Text("Font Size"),
            ),
            SizedBox(
              width: 70,
              child: DraggableNumberField(
                min: 0,
                max: 22,
                value: font.size,
                onChanged: (double value) {
                  state.updatePieMenu(font: font..size = value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
