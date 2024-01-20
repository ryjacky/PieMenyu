import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:provider/provider.dart';

import 'pie_menu_editor_page.dart';
import 'pie_menu_state.dart';

class PieMenuEditorRoute extends StatelessWidget {
  final PieMenu pieMenu;

  const PieMenuEditorRoute(this.pieMenu, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PieMenuState(pieMenu: pieMenu)),
      ],
      child: const PieMenuEditorPage(),
    );
  }
}
