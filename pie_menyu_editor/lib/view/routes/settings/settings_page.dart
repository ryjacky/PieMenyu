import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_editor/view/routes/settings/right_setting_panel.dart';
import 'package:pie_menyu_editor/view/routes/settings/settings_state.dart';
import 'package:pie_menyu_editor/view/widgets/title_bar.dart';
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
    final db = context.read<Database>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingsState(db)),
        ],
        child: const Column(
          children: [
            TitleBar(),
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
