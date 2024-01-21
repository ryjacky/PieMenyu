import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/editor_panel/properties_tab/font_section.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/editor_panel/properties_tab/shape_section.dart';

import 'behavior_section.dart';
import 'color_section.dart';
import 'icon_section.dart';

class PropertiesTab extends StatefulWidget {
  const PropertiesTab({super.key});

  @override
  State<PropertiesTab> createState() => _PropertiesTabState();
}

class _PropertiesTabState extends State<PropertiesTab> {
  static const double rowGap = 10;

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ColorSection(),
            Gap(rowGap),
            IconSection(),
            Gap(rowGap),
            FontSection(),
            Gap(rowGap),
            BehaviorSection(),
            Gap(rowGap),
            ShapeSection(),
            Gap(rowGap),
          ],
        ),
      ),
    );
  }

}
