import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_editor/view/widgets/draggable_number_field.dart';
import 'package:pie_menyu_editor/view/widgets/expansion_color_picker_tile.dart';
import 'package:pie_menyu_editor/view/widgets/material_3_switch.dart';
import 'package:provider/provider.dart';

import '../pie_menu_state.dart';

class PropertiesTab extends StatefulWidget {
  const PropertiesTab({super.key});

  @override
  State<PropertiesTab> createState() => _PropertiesTabState();
}

class _PropertiesTabState extends State<PropertiesTab> {
  final double rowGap = 10;
  final List<DropdownMenuItem<String>> fontsDropdownItem = [
    "Amatic SC",
    "Caveat",
    "Comfortaa",
    "Roboto",
    "Lora",
    "Montserrat",
  ]
      .map(
        (fontName) => DropdownMenuItem<String>(
          value: fontName,
          child: Text(fontName, style: GoogleFonts.getFont(fontName)),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    final pieMenu = context.watch<PieMenuState>().pieMenu;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("label-colors".i18n()),
                ExpansionColorPickerTile(
                  title: Text("label-main-color".i18n()),
                  color: Color(pieMenu.mainColor),
                  onColorChanged: (color) {
                    context
                        .read<PieMenuState>()
                        .updatePieMenu(pieMenu..mainColor = color.value);
                  },
                ),
                ExpansionColorPickerTile(
                  title: Text("label-secondary-color".i18n()),
                  color: Color(pieMenu.secondaryColor),
                  onColorChanged: (color) {
                    context
                        .read<PieMenuState>()
                        .updatePieMenu(pieMenu..secondaryColor = color.value);
                  },
                ),
                ExpansionColorPickerTile(
                  title: Text("label-icon-color".i18n()),
                  color: Color(pieMenu.iconColor),
                  onColorChanged: (color) {
                    context
                        .read<PieMenuState>()
                        .updatePieMenu(pieMenu..iconColor = color.value);
                  },
                ),
                ExpansionColorPickerTile(
                  title: Text("label-font-color".i18n()),
                  color: Color(pieMenu.fontColor),
                  onColorChanged: (color) {
                    context
                        .read<PieMenuState>()
                        .updatePieMenu(pieMenu..fontColor = color.value);
                  },
                ),
              ],
            ),
            Gap(rowGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Enabled"),
                Switch(
                  // This bool value toggles the switch.
                  value: pieMenu.enabled,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    context
                        .read<PieMenuState>()
                        .updatePieMenu(pieMenu..enabled = value);
                  },
                )
              ],
            ),
            Gap(rowGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Open In Screen Center"),
                Switch(
                  // This bool value toggles the switch.
                  value: pieMenu.openInScreenCenter,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (bool value) {
                    context
                        .read<PieMenuState>()
                        .updatePieMenu(pieMenu..openInScreenCenter = value);
                  },
                )
              ],
            ),
            Gap(rowGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: Text("Font Family")),
                DropdownButton<String>(
                  items: fontsDropdownItem,
                  value: pieMenu.fontName,
                  onChanged: (String? value) {
                    if (value == null) return;
                    context
                        .read<PieMenuState>()
                        .updatePieMenu(pieMenu..fontName = value);
                  },
                ),
              ],
            ),
            Gap(rowGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: Text("Escape Radius")),
                SizedBox(
                  width: 70,
                  child: DraggableNumberField(
                    min: 0,
                    max: 500,
                    value: pieMenu.escapeRadius,
                    onChanged: (int value) {
                      context
                          .read<PieMenuState>()
                          .updatePieMenu(pieMenu..escapeRadius = value);
                    },
                  ),
                ),
              ],
            ),
            Gap(rowGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Center Radius"),
                SizedBox(
                  width: 70,
                  child: DraggableNumberField(
                    min: 0,
                    max: 500,
                    value: pieMenu.centerRadius,
                    onChanged: (int value) {
                      context
                          .read<PieMenuState>()
                          .updatePieMenu(pieMenu..centerRadius = value);
                    },
                  ),
                ),
              ],
            ),
            Gap(rowGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Center Thickness"),
                SizedBox(
                  width: 70,
                  child: DraggableNumberField(
                    min: 0,
                    max: 500,
                    value: pieMenu.centerThickness,
                    onChanged: (int value) {
                      context
                          .read<PieMenuState>()
                          .updatePieMenu(pieMenu..centerThickness = value);
                    },
                  ),
                ),
              ],
            ),
            Gap(rowGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Icon Size"),
                SizedBox(
                  width: 70,
                  child: DraggableNumberField(
                    min: 0,
                    max: 500,
                    value: pieMenu.iconSize,
                    onChanged: (int value) {
                      context
                          .read<PieMenuState>()
                          .updatePieMenu(pieMenu..iconSize = value);
                    },
                  ),
                ),
              ],
            ),
            Gap(rowGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Font Size"),
                SizedBox(
                  width: 70,
                  child: DraggableNumberField(
                    min: 0,
                    max: 500,
                    value: pieMenu.fontSize,
                    onChanged: (int value) {
                      context
                          .read<PieMenuState>()
                          .updatePieMenu(pieMenu..fontSize = value);
                    },
                  ),
                ),
              ],
            ),
            Gap(rowGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pie Item Roundness"),
                SizedBox(
                  width: 70,
                  child: DraggableNumberField(
                    min: 0,
                    max: 500,
                    value: pieMenu.pieItemRoundness,
                    onChanged: (int value) {
                      context
                          .read<PieMenuState>()
                          .updatePieMenu(pieMenu..pieItemRoundness = value);
                    },
                  ),
                ),
              ],
            ),
            Gap(rowGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pie Item Spread"),
                SizedBox(
                  width: 70,
                  child: DraggableNumberField(
                    min: 0,
                    max: 500,
                    value: pieMenu.pieItemSpread,
                    onChanged: (int value) {
                      context
                          .read<PieMenuState>()
                          .updatePieMenu(pieMenu..pieItemSpread = value);
                    },
                  ),
                ),
              ],
            ),
            Gap(rowGap),
          ],
        ),
      ),
    );
  }
}
