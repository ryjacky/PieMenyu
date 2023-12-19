import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/db.dart';
import 'package:pie_menyu/db/pie_item.dart';
import 'package:pie_menyu/db/pie_item_task.dart';
import 'package:pie_menyu/system/file_icon.dart';
import 'package:pie_menyu/view/controller/pie_menu_controller.dart';
import 'package:pie_menyu/view/widgets/PrimaryButton.dart';
import 'package:pie_menyu/view/widgets/draggable_number_field.dart';
import 'package:pie_menyu/view/widgets/expansion_color_picker_tile.dart';
import 'package:pie_menyu/view/widgets/icon_button.dart';
import 'package:pie_menyu/view/widgets/material_3_switch.dart';
import 'package:pie_menyu/view/widgets/minimal_text_field.dart';
import 'package:pie_menyu/view/widgets/hotkey_task_card.dart';

class PieMenuProperties extends StatefulWidget {
  final PieMenuController controller;

  const PieMenuProperties({super.key, required this.controller});

  @override
  State<PieMenuProperties> createState() => _PieMenuPropertiesState();
}

class _PieMenuPropertiesState extends State<PieMenuProperties> {
  final double rowGap = 10;
  final double buttonGap = 6;
  List<PieItemTask> pieItemTasks = [PieItemTask()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Theme(
              data: ThemeData(
                  useMaterial3: true,
                  colorScheme: Theme.of(context).colorScheme,
                  textTheme: Theme.of(context).textTheme),
              child: TabBar(
                tabs: [
                  Tab(text: "tab-pie-items".i18n()),
                  Tab(text: "tab-properties".i18n()),
                  Tab(text: "tab-actions".i18n()),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ReorderableListView(
                      header: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PrimaryButton(
                          onPressed: createPieItem,
                          label: Text("label-new-pie-item".i18n()),
                          icon: FontAwesomeIcons.plus,
                        ),
                      ),
                      children: [
                        for (final PieItem pieItem
                            in widget.controller.value.pieItems)
                          SizedBox(
                            key: ValueKey(pieItem),
                            width: 280,
                            child: ListTile(
                                title: MinimalTextField(
                                  content: pieItem.displayName,
                                  onSubmitted: (String value) {
                                    widget.controller.updatePieItem(pieItem,
                                        displayName: value);
                                  },
                                ),
                                leading: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(5),
                                    minimumSize: const Size(50, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant,
                                      width: 2,
                                    ),
                                  ),
                                  onPressed: () async {
                                    String? icon = await pickPieItemIconFromFile();
                                    if (icon != null) {
                                      widget.controller.updatePieItem(pieItem,
                                          iconBase64: icon);
                                    }
                                  },
                                  child: Image.memory(
                                    width: 32,
                                    height: 32,
                                    base64Decode(pieItem.iconBase64),
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(FontAwesomeIcons.plus),
                                  ),
                                )),
                          ),
                      ],
                      onReorder: (oldIndex, newIndex) {}),
                  SingleChildScrollView(
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
                                color: Color(widget.controller.value.mainColor),
                                onColorChanged: (color) {
                                  widget.controller
                                      .update(mainColor: color.value);
                                },
                              ),
                              ExpansionColorPickerTile(
                                title: Text("label-secondary-color".i18n()),
                                color: Color(
                                    widget.controller.value.secondaryColor),
                                onColorChanged: (color) {
                                  widget.controller
                                      .update(secondaryColor: color.value);
                                },
                              ),
                              ExpansionColorPickerTile(
                                title: Text("label-icon-color".i18n()),
                                color: Color(widget.controller.value.iconColor),
                                onColorChanged: (color) {
                                  widget.controller
                                      .update(iconColor: color.value);
                                },
                              ),
                            ],
                          ),
                          Gap(rowGap),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Enabled"),
                              Material3Switch(
                                // This bool value toggles the switch.
                                value: widget.controller.value.enabled,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  widget.controller.update(enabled: value);
                                },
                              )
                            ],
                          ),
                          Gap(rowGap),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Open In Screen Center"),
                              Material3Switch(
                                // This bool value toggles the switch.
                                value:
                                    widget.controller.value.openInScreenCenter,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  widget.controller
                                      .update(openInScreenCenter: value);
                                },
                              )
                            ],
                          ),
                          Gap(rowGap),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Activation Mode"),
                              SizedBox(
                                  width: 10, height: 10, child: Placeholder()),
                            ],
                          ),
                          Gap(rowGap),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(child: Text("Escape Radius")),
                                  SizedBox(
                                    width: 70,
                                    child: DraggableNumberField(
                                      min: 0,
                                      max: 500,
                                      value:
                                          widget.controller.value.escapeRadius,
                                      onChanged: (int value) {
                                        widget.controller
                                            .update(escapeRadius: value);
                                      },
                                    ),
                                  ),
                                ],
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
                                  value: widget.controller.value.centerRadius,
                                  onChanged: (int value) {
                                    widget.controller
                                        .update(centerRadius: value);
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
                                  value:
                                      widget.controller.value.centerThickness,
                                  onChanged: (int value) {
                                    widget.controller
                                        .update(centerThickness: value);
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
                                  value: widget.controller.value.iconSize,
                                  onChanged: (int value) {
                                    widget.controller.update(iconSize: value);
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
                                  value:
                                      widget.controller.value.pieItemRoundness,
                                  onChanged: (int value) {
                                    widget.controller
                                        .update(pieItemRoundness: value);
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
                                  value: widget.controller.value.pieItemSpread,
                                  onChanged: (int value) {
                                    widget.controller
                                        .update(pieItemSpread: value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Gap(rowGap),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: ListView(
                          children: [
                            for (final PieItemTask pieItemTask in pieItemTasks)
                              HotkeyTaskCard(pieItemTask: pieItemTask),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        width: 50,
                        child: ListView(children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: const FaIcon(
                              FontAwesomeIcons.plus,
                              color: Colors.white70,
                              size: 20,
                            ),
                          ),
                          const Divider(
                            indent: 7,
                            endIndent: 7,
                          ),
                          Tooltip(
                            message: "tooltip-add-send-key-action".i18n(),
                            child: MonochromeIconButton(
                                icon: Icons.keyboard,
                                onPressed: newHotkeyTask),
                          ),
                          Gap(buttonGap),
                          Tooltip(
                            message: "tooltip-add-mouse-click-action".i18n(),
                            child: MonochromeIconButton(
                                icon: FontAwesomeIcons.handPointer,
                                onPressed: newHotkeyTask),
                          ),
                          Gap(buttonGap),
                          Tooltip(
                            message: "tooltip-add-run-file-action".i18n(),
                            child: MonochromeIconButton(
                                icon: Icons.file_open,
                                onPressed: newHotkeyTask),
                          ),
                          Gap(buttonGap),
                          Tooltip(
                            message:
                                "tooltip-add-open-sub-menu-action".i18n(),
                            child: MonochromeIconButton(
                                icon: Icons.pie_chart,
                                onPressed: newHotkeyTask),
                          ),
                          Gap(buttonGap),
                          Tooltip(
                            message: "tooltip-add-open-folder-action".i18n(),
                            child: MonochromeIconButton(
                                icon: Icons.folder, onPressed: newHotkeyTask),
                          ),
                          Gap(buttonGap),
                          Tooltip(
                            message: "tooltip-add-open-app-action".i18n(),
                            child: MonochromeIconButton(
                                icon: Icons.play_arrow_rounded,
                                onPressed: newHotkeyTask),
                          ),
                          Gap(buttonGap),
                          Tooltip(
                            message: "tooltip-add-open-url-action".i18n(),
                            child: MonochromeIconButton(
                                icon: Icons.link, onPressed: newHotkeyTask),
                          ),
                          Gap(buttonGap),
                          Tooltip(
                            message: "tooltip-add-open-editor-action".i18n(),
                            child: MonochromeIconButton(
                                icon: Icons.edit_note,
                                onPressed: newHotkeyTask),
                          ),
                          Gap(buttonGap),
                          Tooltip(
                            message:
                                "tooltip-add-resize-window-action".i18n(),
                            child: MonochromeIconButton(
                                icon: Icons.photo_size_select_small,
                                onPressed: newHotkeyTask),
                          ),
                          Gap(buttonGap),
                          Tooltip(
                            message: "tooltip-add-move-window-action".i18n(),
                            child: MonochromeIconButton(
                                icon: Icons.move_down,
                                onPressed: newHotkeyTask),
                          ),
                          Gap(buttonGap),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  createPieItem() async {
    final PieItem newPieItem =
        PieItem(displayName: "label-new-pie-item".i18n());
    await DB.putPieItem(newPieItem);
    widget.controller.addPieItem(newPieItem);

    setState(() {});
    // updateParameterThenSetState();
  }

  Future<String?> pickPieItemIconFromFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return FileIcon.getBase64(result.files.single.path!);
    }

    return null;
  }

  void newHotkeyTask() {}
}
