import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_editor/view/widgets/back_icon_button.dart';
import 'package:pie_menyu_editor/view/widgets/clickable_text.dart';
import 'package:provider/provider.dart';

import 'settings_state.dart';

class LeftSettingsPanel extends StatefulWidget {
  const LeftSettingsPanel({super.key});

  @override
  State<LeftSettingsPanel> createState() => _LeftSettingsPanelState();
}

class _LeftSettingsPanelState extends State<LeftSettingsPanel> {
  final gap = 16.0;

  @override
  Widget build(BuildContext context) {
    final settingsState = context.read<SettingsState>();
    final selectedSection = context.select<SettingsState, SettingsSection>(
        (value) => value.selectedSection);

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom back button
          const BackIconButton(),
          Gap(gap),
          // Table of contents
          ClickableText(
            title: 'label-general-settings'.i18n(),
            onTap: () =>
                settingsState.selectedSection = SettingsSection.general,
            isSelected: selectedSection == SettingsSection.general,
          ),
          Gap(gap),
          ClickableText(
            title: 'label-data'.i18n(),
            onTap: () => settingsState.selectedSection = SettingsSection.data,
            isSelected: selectedSection == SettingsSection.data,
          ),
          Gap(gap),
          ClickableText(
            title: 'label-about'.i18n(),
            onTap: () => settingsState.selectedSection = SettingsSection.about,
            isSelected: selectedSection == SettingsSection.about,
          ),
        ],
      ),
    );
  }
}
