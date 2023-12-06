import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class PieMenuProperties extends StatefulWidget {
  const PieMenuProperties({super.key});

  @override
  State<PieMenuProperties> createState() => _PieMenuPropertiesState();
}

class _PieMenuPropertiesState extends State<PieMenuProperties> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                  const Placeholder(),
                  const Placeholder(),
                ],
              ),
            ),
          ],
        ));
  }
}
