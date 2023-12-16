import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/db.dart';
import 'package:pie_menyu/db/pie_item.dart';
import 'package:pie_menyu/view/controller/pie_menu_controller.dart';
import 'package:pie_menyu/view/widgets/PrimaryButton.dart';
import 'package:pie_menyu/view/widgets/draggable_number_field.dart';
import 'package:pie_menyu/view/widgets/material_3_switch.dart';
import 'package:pie_menyu/view/widgets/minimal_text_field.dart';

class PieMenuProperties extends StatefulWidget {
  final PieMenuController controller;

  const PieMenuProperties(
      {super.key, required this.controller});

  @override
  State<PieMenuProperties> createState() => _PieMenuPropertiesState();
}

class _PieMenuPropertiesState extends State<PieMenuProperties> {
  final double rowGap = 10;

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
                        for (PieItem pieItem
                            in widget.controller.value.pieItems)
                          SizedBox(
                            key: ValueKey(pieItem),
                            width: 280,
                            child: ListTile(
                                title: MinimalTextField(
                                  content: pieItem.displayName,
                                  onSubmitted: (String value) {
                                    widget.controller
                                        .updateProperties(name: value);
                                  },
                                ),
                                leading: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(2),
                                    minimumSize: const Size(45, 45),
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
                                  onPressed: () {},
                                  child: Image.memory(
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
                                  widget.controller
                                      .updateProperties(enabled: value);
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
                                value: widget
                                    .controller.value.openInScreenCenter,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  widget.controller.updateProperties(
                                      openInScreenCenter: value);
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
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Main Color"),
                              SizedBox(
                                  width: 10, height: 10, child: Placeholder()),
                            ],
                          ),
                          Gap(rowGap),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Secondary Color"),
                              SizedBox(
                                  width: 10, height: 10, child: Placeholder()),
                            ],
                          ),
                          Gap(rowGap),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Icon Color"),
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
                                      value: widget
                                          .controller.value.escapeRadius,
                                      onChanged: (int value) {
                                        widget.controller.updateProperties(
                                            escapeRadius: value);
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
                                  value:
                                      widget.controller.value.centerRadius,
                                  onChanged: (int value) {
                                    widget.controller
                                        .updateProperties(centerRadius: value);
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
                                  value: widget
                                      .controller.value.centerThickness,
                                  onChanged: (int value) {
                                    widget.controller.updateProperties(
                                        centerThickness: value);
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
                                    widget.controller.updateProperties(
                                        iconSize: value);
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
                                    widget.controller.updateProperties(
                                        pieItemRoundness: value);
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
                                    widget.controller.updateProperties(
                                        pieItemSpread: value);
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
                  const Placeholder(),
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
}
