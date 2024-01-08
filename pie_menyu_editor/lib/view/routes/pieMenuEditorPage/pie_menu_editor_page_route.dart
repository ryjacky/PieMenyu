import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_editor/view/routes/pieMenuEditorPage/pie_menu_editor_page.dart';
import 'package:pie_menyu_editor/view/routes/pieMenuEditorPage/pie_menu_state.dart';
import 'package:provider/provider.dart';

class PieMenuEditorPageRoute extends StatelessWidget {
  final PieMenu pieMenu;

  const PieMenuEditorPageRoute(this.pieMenu, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PieMenuState(
          pieMenu: pieMenu,
        )
        ),
      ],
      child: const PieMenuEditorPage(),
    );
  }
}
