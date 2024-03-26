import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pie_menyu_editor/view/widgets/back_icon_button.dart';
import 'package:pie_menyu_editor/view/widgets/clickable_text.dart';
import 'package:provider/provider.dart';

import 'settings_page_state.dart';

@protected
class SettingsPageNavigationPanel extends StatelessWidget {
  static const gap = 16.0;

  const SettingsPageNavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsState = context.read<SettingsPageState>();
    final selectedSection = context.select<SettingsPageState, SettingsSection>(
        (value) => value.selectedSection);

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom back button
          const BackIconButton(),
          const Gap(gap),
          // Table of contents
          ClickableText(
            title: 'label-general-settings'.tr(),
            onTap: () =>
                settingsState.selectedSection = SettingsSection.general,
            isSelected: selectedSection == SettingsSection.general,
          ),
          // const Gap(gap),
          // ClickableText(
          //   title: 'label-data'.tr(),
          //   onTap: () => settingsState.selectedSection = SettingsSection.data,
          //   isSelected: selectedSection == SettingsSection.data,
          // ),
          const Gap(gap),
          ClickableText(
            title: 'label-about'.tr(),
            onTap: () => settingsState.selectedSection = SettingsSection.about,
            isSelected: selectedSection == SettingsSection.about,
          ),
        ],
      ),
    );
  }
}
