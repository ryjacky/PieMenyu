import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_editor/view/widgets/draggable_number_field.dart';
import 'package:pie_menyu_editor/view/widgets/collapasable_color_picker.dart';
import 'package:provider/provider.dart';

import '../pie_menu_state.dart';

class PropertiesTab extends StatefulWidget {
  const PropertiesTab({super.key});

  @override
  State<PropertiesTab> createState() => _PropertiesTabState();
}

class _PropertiesTabState extends State<PropertiesTab> {
  static const double rowGap = 10;
  final fonts = [
    "Amatic SC",
    "Caveat",
    "Comfortaa",
    "Roboto",
    "Lora",
    "Montserrat",
  ];

  PieMenuState? pieMenuState;

  @override
  Widget build(BuildContext context) {
    final pieMenu = context.watch<PieMenuState>().pieMenu;
    pieMenuState = context.read<PieMenuState>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getColorsSection(pieMenu),
            const Gap(rowGap),
            getIconSection(pieMenu),
            const Gap(rowGap),
            getFontSection(pieMenu),
            const Gap(rowGap),
            getBehaviorSection(pieMenu),
            const Gap(rowGap),
            getShapeSection(pieMenu),
            const Gap(rowGap),
          ],
        ),
      ),
    );
  }

  Widget getColorsSection(PieMenu pieMenu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-colors".i18n(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        CollapsableColorPicker(
          title: Text("label-main-color".i18n()),
          color: Color(pieMenu.mainColor),
          onColorChanged: (color) {
            pieMenuState?.updatePieMenu(pieMenu..mainColor = color.value);
          },
        ),
        CollapsableColorPicker(
          title: Text("label-secondary-color".i18n()),
          color: Color(pieMenu.secondaryColor),
          onColorChanged: (color) {
            pieMenuState?.updatePieMenu(pieMenu..secondaryColor = color.value);
          },
        ),
      ],
    );
  }

  Widget getIconSection(PieMenu pieMenu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-icon".i18n(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        CollapsableColorPicker(
          title: Text("label-icon-color".i18n()),
          color: Color(pieMenu.iconColor),
          onColorChanged: (color) {
            pieMenuState?.updatePieMenu(pieMenu..iconColor = color.value);
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
        Text("label-font".i18n(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        CollapsableColorPicker(
          title: Text("label-font-color".i18n()),
          color: Color(pieMenu.fontColor),
          onColorChanged: (color) {
            pieMenuState?.updatePieMenu(pieMenu..fontColor = color.value);
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
                pieMenuState?.updatePieMenu(pieMenu..fontName = value);
              },
            ),
          ],
        ),
        const Gap(rowGap),
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
                  pieMenuState?.updatePieMenu(pieMenu..fontSize = value);
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
        Text("label-behavior".i18n(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const Gap(rowGap),
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
                pieMenuState
                    ?.updatePieMenu(pieMenu..openInScreenCenter = value);
              },
            ),
          ],
        ),
        const Gap(rowGap),
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
                  pieMenuState?.updatePieMenu(pieMenu..escapeRadius = value);
                },
              ),
            ),
          ],
        ),
        const Gap(rowGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Tooltip(
                message: "tooltip-activation-mode-hint".i18n(),
                child: const Icon(
                  Icons.help_outline,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            Text("label-activation-mode".i18n()),
            DropdownMenu<ActivationMode>(
              menuHeight: 300,
              width: 120,
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                constraints: BoxConstraints.tight(const Size(120, 40)),
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              initialSelection: pieMenu.activationMode,
              dropdownMenuEntries: [
                DropdownMenuEntry(
                    value: ActivationMode.onRelease,
                    label: "label-release".i18n()),
                DropdownMenuEntry(
                    value: ActivationMode.onClick, label: "label-click".i18n()),
                DropdownMenuEntry(
                    value: ActivationMode.onHover, label: "label-hover".i18n()),
              ],
              onSelected: (ActivationMode? value) {
                if (value == null) return;
                pieMenuState?.updatePieMenu(pieMenu..activationMode = value);
              },
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
        Text("label-shape".i18n(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const Gap(rowGap),
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
                  pieMenuState?.updatePieMenu(pieMenu..centerRadius = value);
                },
              ),
            ),
          ],
        ),
        const Gap(rowGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Pie Item Offset"),
            ),
            SizedBox(
              width: 70,
              child: DraggableNumberField(
                min: 0,
                max: 360,
                value: pieMenu.pieItemOffset,
                onChanged: (int value) {
                  pieMenuState?.updatePieMenu(pieMenu..pieItemOffset = value);
                },
              ),
            ),
          ],
        ),
        const Gap(rowGap),
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
                  pieMenuState?.updatePieMenu(pieMenu..centerThickness = value);
                },
              ),
            ),
          ],
        ),
        const Gap(rowGap),
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
                  pieMenuState
                      ?.updatePieMenu(pieMenu..pieItemRoundness = value);
                },
              ),
            ),
          ],
        ),
        const Gap(rowGap),
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
                  pieMenuState?.updatePieMenu(pieMenu..pieItemSpread = value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
