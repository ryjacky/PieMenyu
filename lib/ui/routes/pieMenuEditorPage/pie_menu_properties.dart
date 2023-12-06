import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/theme/color_schemes.g.dart';
import 'package:pie_menyu/theme/text_theme.g.dart';

class PieMenuProperties extends StatefulWidget {
  final PieMenu pieMenu;

  const PieMenuProperties({super.key, required this.pieMenu});

  @override
  State<PieMenuProperties> createState() => _PieMenuPropertiesState();
}

class _PieMenuPropertiesState extends State<PieMenuProperties> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: textTheme
      ),
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
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
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
                                    activeColor: Theme.of(context).colorScheme.primary,
                                    onChanged: (bool value) {
                                      // This is called when the user toggles the switch.
                                      setState(() {
                                        widget.pieMenu.enabled = value;
                                      });
                                    },
                                  )
                                ],
                              ),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Open In Screen Center"),
                                  Switch(
                                    // This bool value toggles the switch.
                                    value: widget.pieMenu.openInScreenCenter,
                                    activeColor: Theme.of(context).colorScheme.primary,
                                    onChanged: (bool value) {
                                      // This is called when the user toggles the switch.
                                      setState(() {
                                        widget.pieMenu.openInScreenCenter = value;
                                      });
                                    },
                                  )
                                ],
                              ),
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
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Escape Radius"),
                                  SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Placeholder()),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Center Radius"),
                                  SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Placeholder()),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Center Thickness"),
                                  SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Placeholder()),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Pie Item Width"),
                                  SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Placeholder()),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Icon Size"),
                                  SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Placeholder()),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Pie Item Roundness"),
                                  SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Placeholder()),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Pie Item Spread"),
                                  SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Placeholder()),
                                ],
                              ),
                            ],
                          ),
                        )),
                    const Placeholder(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
