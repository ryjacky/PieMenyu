import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pie_menyu_editor/view/routes/settings_page/settings_page_state.dart';
import 'package:pie_menyu_editor/view/widgets/compact_dropdown_menu.dart';
import 'package:pie_menyu_editor/view/widgets/setting_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

@protected
class SettingsPageBody extends StatefulWidget {
  const SettingsPageBody({super.key});

  @override
  State<SettingsPageBody> createState() => _SettingsPageBodyState();
}

class _SettingsPageBodyState extends State<SettingsPageBody> {
  final GlobalKey generalSectionKey = GlobalKey();
  final GlobalKey dataSectionKey = GlobalKey();
  final GlobalKey aboutSectionKey = GlobalKey();
  final GlobalKey languageSectionKey = GlobalKey();

  final double gap = 20;

  bool isLaunchAtStartup = false;

  @override
  void initState() {
    loadSettings();

    super.initState();
  }

  loadSettings() async {
    isLaunchAtStartup = await launchAtStartup.isEnabled();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<SettingsPageState>();

    final selectedSection = context.select<SettingsPageState, SettingsSection>(
        (value) => value.selectedSection);

    switch (selectedSection) {
      case SettingsSection.general:
        scrollTo(generalSectionKey);
      case SettingsSection.about:
        scrollTo(aboutSectionKey);
      case SettingsSection.data:
        scrollTo(dataSectionKey);
      case SettingsSection.language:
        scrollTo(languageSectionKey);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...buildGeneralSettingsSection(),
              Gap(gap),
              ...buildLanguageSection(),
              Gap(gap),
              ...buildDataSection(state),
              Gap(gap),
              ...buildAboutSection(),
            ],
          ),
        ),
      ),
    );
  }

  bool scrollTo(GlobalKey generalSectionKey) {
    if (generalSectionKey.currentContext == null) return false;

    Scrollable.ensureVisible(
      generalSectionKey.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    return true;
  }

  List<Widget> buildAboutSection() {
    return [
      Padding(
        key: aboutSectionKey,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Text(
          "label-about".tr(),
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      SettingListTile(
        title: "about-view-on-github".tr(),
        subtitle: "about-view-on-github-description".tr(),
        tileColor: Theme.of(context).colorScheme.surface,
        trailing: TextButton(
          onPressed: () =>
              launchUrl(Uri.parse("https://github.com/ryjacky/PieMenyu")),
          child: Text("label-view-on-github".tr()),
        ),
      ),
      Gap(gap),
      SettingListTile(
        title: "label-check-ahp".tr(),
        subtitle: "description-check-ahp".tr(),
        tileColor: Theme.of(context).colorScheme.surface,
        trailing: TextButton(
          onPressed: () =>
              launchUrl(Uri.parse("https://github.com/dumbeau/AutoHotPie")),
          child: Text("label-view-on-github".tr()),
        ),
      ),
    ];
  }

  List<Widget> buildDataSection(SettingsPageState state) {
    return [
      Padding(
        key: dataSectionKey,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Text(
          "label-data".tr(),
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      SettingListTile(
        title: "label-export-data".tr(),
        subtitle: "description-export-data".tr(),
        tileColor: Theme.of(context).colorScheme.surface,
        trailing: TextButton(
          onPressed: state.exportDataThenShowDir,
          child: Text("label-export".tr()),
        ),
      ),
      Gap(gap),
      SettingListTile(
        title: "label-import-data".tr(),
        subtitle: "description-import-data".tr(),
        tileColor: Theme.of(context).colorScheme.surface,
        trailing: TextButton(
          onPressed: () async {
            await state.importData();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  content: Text("message-data-imported".tr()),
                ),
              );
            }
          },
          child: Text("label-import".tr()),
        ),
      ),
    ];
  }

  List<Widget> buildGeneralSettingsSection() {
    return [
      Padding(
        key: generalSectionKey,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Text(
          "label-general-settings".tr(),
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      SettingListTile(
        title: "setting-launch-at-startup".tr(),
        subtitle: "setting-launch-at-startup-description".tr(),
        tileColor: Theme.of(context).colorScheme.surface,
        trailing: Switch(
          value: isLaunchAtStartup,
          onChanged: (value) {
            if (value) {
              launchAtStartup.enable();
            } else {
              launchAtStartup.disable();
            }
            setState(() {
              isLaunchAtStartup = value;
            });
          },
        ),
      ),
    ];
  }

  List<Widget> buildLanguageSection() {
    return [
      Padding(
        key: languageSectionKey,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Text(
          "label-language".tr(),
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      SettingListTile(
        title: "label-language".tr(),
        subtitle: "description-language-setting".tr(),
        tileColor: Theme.of(context).colorScheme.surface,
        trailing: CompactDropdownMenu<String>(
          initialSelection: context.locale.languageCode,
          onSelected: (value) {
            if (value == null) return;
            context.setLocale(Locale(value));
          },
          dropdownMenuEntries: const [
            DropdownMenuEntry(
              label: "English",
              value: "en",
            ),
            DropdownMenuEntry(
              label: "日本語",
              value: "ja",
            ),
          ],
        ),
      ),
    ];
  }
}
