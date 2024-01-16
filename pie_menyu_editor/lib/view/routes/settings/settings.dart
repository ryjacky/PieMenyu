import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_editor/view/routes/home/home_page_titlebar.dart';
import 'package:pie_menyu_editor/view/routes/home/right_setting_panel.dart';
import 'package:pie_menyu_editor/view/routes/settings/settings_state.dart';
import 'package:provider/provider.dart';

import 'left_settings_panel.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
