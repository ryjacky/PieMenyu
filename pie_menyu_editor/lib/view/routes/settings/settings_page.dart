import 'package:flutter/material.dart';
import 'package:pie_menyu_editor/view/routes/home/home_page_titlebar.dart';
import 'package:pie_menyu_editor/view/routes/settings/right_setting_panel.dart';
import 'package:pie_menyu_editor/view/routes/settings/settings_state.dart';
import 'package:provider/provider.dart';

import 'left_settings_panel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingsState()),
        ],
        child: const Column(
          children: [
            HomePageTitleBar(),
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 3, child: LeftSettingsPanel()),
                  Expanded(flex: 7, child: RightSettingPanel()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
