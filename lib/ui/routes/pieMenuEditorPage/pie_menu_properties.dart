import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/theme/color_schemes.g.dart';
import 'package:pie_menyu/theme/text_theme.g.dart';
import 'package:pie_menyu/ui/widgets/draggable_number_field.dart';

class PieMenuProperties extends StatefulWidget {
  final PieMenu pieMenu;

  const PieMenuProperties({super.key, required this.pieMenu});

  @override
  State<PieMenuProperties> createState() => _PieMenuPropertiesState();
}

class _PieMenuPropertiesState extends State<PieMenuProperties> {
  final double rowGap = 10;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: textTheme),
      child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: "tab-properties".i18n()),
                  Tab(text: "tab-actions".i18n()),
                ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Enabled"),
                                  Switch(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Open In Screen Center"),
                                  Switch(
                                    // This bool value toggles the switch.
                                    value: widget.pieMenu.openInScreenCenter,
                                    activeColor:
                                        Theme.of(context).colorScheme.primary,
                                    onChanged: (bool value) {
                                      // This is called when the user toggles the switch.
                                      setState(() {
                                        widget.pieMenu.openInScreenCenter =
                                            value;
                                      });
                                    },
                                  )
                                ],
                              ),
                              Gap(rowGap),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              widget.pieMenu.escapeRadius =
                                                  value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Gap(rowGap),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Center Radius"),
                                  SizedBox(
                                    width: 70,
                                    child: DraggableNumberField(
                                      min: 0,
                                      max: 500,
                                      value: widget.pieMenu.centerRadius,
                                      onChanged: (int value) {
                                        setState(() {
                                          widget.pieMenu.centerRadius = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Gap(rowGap),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          widget.pieMenu.centerThickness =
                                              value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Gap(rowGap),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Pie Item Width"),
                                  SizedBox(
                                    width: 70,
                                    child: DraggableNumberField(
                                      min: 0,
                                      max: 500,
                                      value: widget.pieMenu.pieItemWidth,
                                      onChanged: (int value) {
                                        setState(() {
                                          widget.pieMenu.pieItemWidth = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Gap(rowGap),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Gap(rowGap),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          widget.pieMenu.pieItemRoundness =
                                              value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Gap(rowGap),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
          )),
    );
  }
}
