import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_editor/view/routes/settings/settings_state.dart';
import 'package:pie_menyu_editor/view/widgets/setting_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RightSettingPanel extends StatefulWidget {
  const RightSettingPanel({super.key});

  @override
  State<RightSettingPanel> createState() => _RightSettingPanelState();
}

class _RightSettingPanelState extends State<RightSettingPanel> {
  final GlobalKey generalSectionKey = GlobalKey();
  final GlobalKey aboutSectionKey = GlobalKey();

  final double gap = 20;

  bool isLaunchAtStartup = false;

  SharedPreferences? prefs;

  @override
  void initState() {
    loadSettings();

    super.initState();
  }

  loadSettings() async {
    isLaunchAtStartup = await launchAtStartup.isEnabled();
    prefs = await SharedPreferences.getInstance();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectedSection = context.select<SettingsState, SettingsSection>(
        (value) => value.selectedSection);

    switch (selectedSection) {
      case SettingsSection.general:
        scrollTo(generalSectionKey);
      case SettingsSection.about:
        scrollTo(aboutSectionKey);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                key: generalSectionKey,
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(
                  "label-setting".i18n(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              SettingListTile(
                title: "setting-launch-at-startup".i18n(),
                subtitle: "setting-launch-at-startup-description".i18n(),
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
          "label-about".i18n(),
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      SettingListTile(
        title: "about-view-on-github".i18n(),
        subtitle: "about-view-on-github-description".i18n(),
        tileColor: Theme.of(context).colorScheme.surface,
        trailing: TextButton(
          onPressed: () =>
              launchUrl(Uri.parse("https://github.com/ryjacky/PieMenyu")),
          child: Text("label-view-on-github".i18n()),
        ),
      ),
      Gap(gap),
      SettingListTile(
        title: "label-check-ahp".i18n(),
        subtitle: "description-check-ahp".i18n(),
        tileColor: Theme.of(context).colorScheme.surface,
        trailing: TextButton(
          onPressed: () =>
              launchUrl(Uri.parse("https://github.com/dumbeau/AutoHotPie")),
          child: Text("label-view-on-github".i18n()),
        ),
      ),
    ];
  }
}
