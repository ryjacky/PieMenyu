import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_editor/view/widgets/back_icon_button.dart';
import 'package:pie_menyu_editor/view/widgets/selectable_toc_item.dart';
import 'package:provider/provider.dart';

import 'settings_state.dart';

class LeftSettingsPanel extends StatefulWidget {
  const LeftSettingsPanel({super.key});

  @override
  State<LeftSettingsPanel> createState() => _LeftSettingsPanelState();
}

class _LeftSettingsPanelState extends State<LeftSettingsPanel> {
  @override
  Widget build(BuildContext context) {
    final settingsState = context.read<SettingsState>();
    final selectedSection = context.select<SettingsState, SettingsSection>(
        (value) => value.selectedSection);

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom back button
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 35, 0, 10),
            child: BackIconButton(),
          ),
          // Table of contents
          SelectableTOCItem(
            title: 'label-general-settings'.i18n(),
            onTap: () =>
                settingsState.selectedSection = SettingsSection.general,
            isSelected: selectedSection == SettingsSection.general,
          ),

          SelectableTOCItem(
            title: 'label-about'.i18n(),
            onTap: () => settingsState.selectedSection = SettingsSection.about,
            isSelected: selectedSection == SettingsSection.about,
          ),
        ],
      ),
    );
  }
}
