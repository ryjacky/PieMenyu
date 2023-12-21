import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_editor/system/file_icon.dart';
import 'package:pie_menyu_editor/view/widgets/PrimaryButton.dart';
import 'package:pie_menyu_editor/view/widgets/draggable_number_field.dart';
import 'package:pie_menyu_editor/view/widgets/expansion_color_picker_tile.dart';
import 'package:pie_menyu_editor/view/widgets/material_3_switch.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:provider/provider.dart';

import 'pie_menu_editor_page_view_model.dart';
import 'pie_menu_property_tab_actions.dart';

class PieMenuProperties extends StatefulWidget {
  const PieMenuProperties({super.key});

  @override
  State<PieMenuProperties> createState() => _PieMenuPropertiesState();
}

class _PieMenuPropertiesState extends State<PieMenuProperties> {
  final double rowGap = 10;

  @override
  Widget build(BuildContext context) {
    final pieItems = context.select<PieMenuEditorPageViewModel, List<PieItem>>(
        (value) => value.pieItems);
    final pieMenu = context.watch<PieMenuEditorPageViewModel>().pieMenu;

    return Column(
      children: [
         Expanded(
          child: DefaultTabController(
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
                                onPressed: context.read<PieMenuEditorPageViewModel>().createPieItemInCurrentPieMenu,
                                label: Text("label-new-pie-item".i18n()),
                                icon: FontAwesomeIcons.plus,
                              ),
                            ),
                            children: [
                              for (final PieItem pieItem in pieItems)
                                SizedBox(
                                  key: ValueKey(pieItem),
                                  width: 280,
                                  child: ListTile(
                                      title: MinimalTextField(
                                        content: pieItem.displayName,
                                        onSubmitted: (String value) {
                                          context
                                              .read<PieMenuEditorPageViewModel>()
                                              .putPieItemInCurrentPieMenu(
                                              pieItem..displayName = value);
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
                                          String? icon =
                                          await pickPieItemIconFromFile();
                                          if (icon != null) {
                                            context
                                                .read<PieMenuEditorPageViewModel>()
                                                .putPieItemInCurrentPieMenu(
                                                pieItem..iconBase64 = icon);
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
                                      color: Color(pieMenu.mainColor),
                                      onColorChanged: (color) {
                                        context
                                            .read<PieMenuEditorPageViewModel>()
                                            .pieMenu = pieMenu
                                          ..mainColor = color.value;
                                      },
                                    ),
                                    ExpansionColorPickerTile(
                                      title: Text("label-secondary-color".i18n()),
                                      color: Color(pieMenu.secondaryColor),
                                      onColorChanged: (color) {
                                        context
                                            .read<PieMenuEditorPageViewModel>()
                                            .pieMenu = pieMenu
                                          ..secondaryColor = color.value;
                                      },
                                    ),
                                    ExpansionColorPickerTile(
                                      title: Text("label-icon-color".i18n()),
                                      color: Color(pieMenu.iconColor),
                                      onColorChanged: (color) {
                                        context
                                            .read<PieMenuEditorPageViewModel>()
                                            .pieMenu = pieMenu
                                          ..iconColor = color.value;
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
                                      value: pieMenu.enabled,
                                      activeColor:
                                      Theme.of(context).colorScheme.primary,
                                      onChanged: (bool value) {
                                        // This is called when the user toggles the switch.
                                        context
                                            .read<PieMenuEditorPageViewModel>()
                                            .pieMenu = pieMenu..enabled = value;
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
                                      value: pieMenu.openInScreenCenter,
                                      activeColor:
                                      Theme.of(context).colorScheme.primary,
                                      onChanged: (bool value) {
                                        context
                                            .read<PieMenuEditorPageViewModel>()
                                            .pieMenu = pieMenu
                                          ..openInScreenCenter = value;
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
                                            value: pieMenu.escapeRadius,
                                            onChanged: (int value) {
                                              context
                                                  .read<PieMenuEditorPageViewModel>()
                                                  .pieMenu = pieMenu
                                                ..escapeRadius = value;
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
                                        value: pieMenu.centerRadius,
                                        onChanged: (int value) {
                                          context
                                              .read<PieMenuEditorPageViewModel>()
                                              .pieMenu = pieMenu
                                            ..centerRadius = value;
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
                                              .read<PieMenuEditorPageViewModel>()
                                              .pieMenu = pieMenu
                                            ..centerThickness = value;
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
                                              .read<PieMenuEditorPageViewModel>()
                                              .pieMenu = pieMenu..iconSize = value;
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
                                              .read<PieMenuEditorPageViewModel>()
                                              .pieMenu = pieMenu
                                            ..pieItemRoundness = value;
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
                                              .read<PieMenuEditorPageViewModel>()
                                              .pieMenu = pieMenu
                                            ..pieItemSpread = value;
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
                        const PieMenuPropertyTabActions(),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: context.read<PieMenuEditorPageViewModel>().save,
                  icon: const Icon(
                      Icons.save_outlined),
                  label: Text("button-save".i18n()),
                ),
              ),
              const Gap(10),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: context.read<PieMenuEditorPageViewModel>().reset,
                  icon: const Icon(Icons.refresh),
                  label:
                  Text("button-reset".i18n()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
