import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/ui/widgets/draggable_number_field.dart';
import 'package:pie_menyu/ui/widgets/material_3_switch.dart';

class PieMenuProperties extends StatefulWidget {
  final PieMenu pieMenu;
  final Function(PieMenu) onChanged;

  const PieMenuProperties({super.key, required this.pieMenu, required this.onChanged});

  @override
  State<PieMenuProperties> createState() => _PieMenuPropertiesState();
}

class _PieMenuPropertiesState extends State<PieMenuProperties> {
  final double rowGap = 10;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Theme(
              data: ThemeData(
                  useMaterial3: true,
                  colorScheme: Theme.of(context).colorScheme,
                  textTheme: Theme.of(context).textTheme),
              child: TabBar(
                tabs: [
                  Tab(text: "tab-properties".i18n()),
                  Tab(text: "tab-actions".i18n()),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
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
                                value: widget.pieMenu.enabled,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    widget.pieMenu.enabled = value;
                                  });
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
                                value: widget.pieMenu.openInScreenCenter,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    widget.pieMenu.openInScreenCenter = value;
                                  });
                                  widget.onChanged(widget.pieMenu);
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
                                  width: 10,
                                  height: 10,
                                  child: Placeholder()),
                            ],
                          ),
                          Gap(rowGap),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Main Color"),
                              SizedBox(
                                  width: 10,
                                  height: 10,
                                  child: Placeholder()),
                            ],
                          ),
                          Gap(rowGap),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Secondary Color"),
                              SizedBox(
                                  width: 10,
                                  height: 10,
                                  child: Placeholder()),
                            ],
                          ),
                          Gap(rowGap),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Icon Color"),
                              SizedBox(
                                  width: 10,
                                  height: 10,
                                  child: Placeholder()),
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
                                  const Expanded(
                                      child: Text("Escape Radius")),
                                  SizedBox(
                                    width: 70,
                                    child: DraggableNumberField(
                                      min: 0,
                                      max: 500,
                                      value: widget.pieMenu.escapeRadius,
                                      onChanged: (int value) {
                                        setState(() {
                                          widget.pieMenu.escapeRadius = value;
                                        });
                                        widget.onChanged(widget.pieMenu);
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
                                  value: widget.pieMenu.centerRadius,
                                  onChanged: (int value) {
                                    widget.pieMenu.centerRadius = value;
                                    widget.onChanged(widget.pieMenu);
                                    setState(() {});
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
                                  value: widget.pieMenu.centerThickness,
                                  onChanged: (int value) {
                                    setState(() {
                                      widget.pieMenu.centerThickness = value;
                                    });
                                    widget.onChanged(widget.pieMenu);
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
                                  value: widget.pieMenu.iconSize,
                                  onChanged: (int value) {
                                    setState(() {
                                      widget.pieMenu.iconSize = value;
                                    });
                                    widget.onChanged(widget.pieMenu);
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
                                  value: widget.pieMenu.pieItemRoundness,
                                  onChanged: (int value) {
                                    setState(() {
                                      widget.pieMenu.pieItemRoundness = value;
                                    });
                                    widget.onChanged(widget.pieMenu);
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
                                  value: widget.pieMenu.pieItemSpread,
                                  onChanged: (int value) {
                                    setState(() {
                                      widget.pieMenu.pieItemSpread = value;
                                    });
                                    widget.onChanged(widget.pieMenu);
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
}
