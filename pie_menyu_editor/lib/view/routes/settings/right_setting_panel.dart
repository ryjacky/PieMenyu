import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_editor/view/widgets/material_3_switch.dart';
import 'package:pie_menyu_editor/view/widgets/setting_list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RightSettingPanel extends StatefulWidget {
  const RightSettingPanel({super.key});

  @override
  State<RightSettingPanel> createState() => _RightSettingPanelState();
}

class _RightSettingPanelState extends State<RightSettingPanel> {
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "label-setting".i18n(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListView(
                  children: [
                    SettingListTile(
                      title: "setting-launch-at-startup".i18n(),
                      subtitle: "setting-launch-at-startup-description".i18n(),
                      tileColor: Theme.of(context).colorScheme.surface,
                      trailing: Material3Switch(
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
                    const Gap(20),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
