import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_editor/view/widgets/draggable_number_field.dart';
import 'package:pie_menyu_editor/view/widgets/expansion_color_picker_tile.dart';
import 'package:provider/provider.dart';

import '../pie_menu_state.dart';

class PropertiesTab extends StatefulWidget {
  const PropertiesTab({super.key});

  @override
  State<PropertiesTab> createState() => _PropertiesTabState();
}

class _PropertiesTabState extends State<PropertiesTab> {
  final double rowGap = 10;
  final fonts = [
    "Amatic SC",
    "Caveat",
    "Comfortaa",
    "Roboto",
    "Lora",
    "Montserrat",
  ];

  @override
  Widget build(BuildContext context) {
    final pieMenu = context.watch<PieMenuState>().pieMenu;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getColorsSection(pieMenu),
            Gap(rowGap),
            getIconSection(pieMenu),
            Gap(rowGap),
            getFontSection(pieMenu),
            Gap(rowGap),
            getBehaviorSection(pieMenu),
            Gap(rowGap),
            getShapeSection(pieMenu),
            Gap(rowGap),
          ],
        ),
      ),
    );
  }

  Widget getColorsSection(PieMenu pieMenu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-colors".i18n(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
      ],
    );
  }

  Widget getIconSection(PieMenu pieMenu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-icon".i18n(), style: const TextStyle(fontWeight: FontWeight.bold)),
        ExpansionColorPickerTile(
          title: Text("label-icon-color".i18n()),
          color: Color(pieMenu.iconColor),
          onColorChanged: (color) {
            context
                .read<PieMenuState>()
                .updatePieMenu(pieMenu..iconColor = color.value);
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
      ],
    );
  }

  Widget getFontSection(PieMenu pieMenu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-font".i18n(), style: const TextStyle(fontWeight: FontWeight.bold)),
        ExpansionColorPickerTile(
          title: Text("label-font-color".i18n()),
          color: Color(pieMenu.fontColor),
          onColorChanged: (color) {
            context
                .read<PieMenuState>()
                .updatePieMenu(pieMenu..fontColor = color.value);
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
              initialSelection: pieMenu.fontName,
              dropdownMenuEntries: fonts
                  .map((e) => DropdownMenuEntry(value: e, label: e))
                  .toList(),
              onSelected: (String? value) {
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
            const Padding(
              padding: EdgeInsets.fromLTRB(42.0, 0, 0, 0),
              child: Text("Font Size"),
            ),
            SizedBox(
              width: 70,
              child: DraggableNumberField(
                min: 0,
                max: 22,
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
      ],
    );
  }

  Widget getBehaviorSection(PieMenu pieMenu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-behavior".i18n(), style: const TextStyle(fontWeight: FontWeight.bold)),
        Gap(rowGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Open In Screen Center"),
            ),
            Switch(
              // This bool value toggles the switch.
              value: pieMenu.openInScreenCenter,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (bool value) {
                context
                    .read<PieMenuState>()
                    .updatePieMenu(pieMenu..openInScreenCenter = value);
              },
            ),
          ],
        ),
        Gap(rowGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Escape Radius"),
            ),
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
      ],
    );
  }

  Widget getShapeSection(PieMenu pieMenu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-shape".i18n(), style: const TextStyle(fontWeight: FontWeight.bold)),
        Gap(rowGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Center Radius"),
            ),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Center Thickness"),
            ),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Pie Item Roundness"),
            ),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Pie Item Spread"),
            ),
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
      ],
    );
  }
}
