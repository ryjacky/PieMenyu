import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_editor/view/widgets/title_bar.dart';
import 'package:provider/provider.dart';

import 'settings_page_nav_panel.dart';
import 'settings_page_body.dart';
import 'settings_page_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<Database>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingsPageState(db)),
        ],
        child: const Column(
          children: [
            TitleBar(),
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 3, child: SettingsPageNavigationPanel()),
                  Expanded(flex: 7, child: SettingsPageBody()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
