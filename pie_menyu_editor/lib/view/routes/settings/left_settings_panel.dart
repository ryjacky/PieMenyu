import 'package:flutter/material.dart';
import 'package:pie_menyu_editor/view/widgets/back-button.dart';
import 'package:pie_menyu_editor/view/widgets/selectable_toc_item.dart';

class LeftSettingsPanel extends StatefulWidget {
  const LeftSettingsPanel({super.key});

  @override
  State<LeftSettingsPanel> createState() => _LeftSettingsPanelState();
}

class _LeftSettingsPanelState extends State<LeftSettingsPanel> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom back button
          const CustomBackButton(),
          // Table of contents
          SelectableTOCItem(
            title: 'Global settings',
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            }, isSelected: true,
          ),

          SelectableTOCItem(
            title: 'About',
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            }, isSelected: false,
          ),
        ],
      ),
    );
  }
}
