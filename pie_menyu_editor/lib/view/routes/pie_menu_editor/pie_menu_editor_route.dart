import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/pie_menu_page_view_model.dart';
import 'package:provider/provider.dart';

import 'pie_menu_editor_page.dart';

class PieMenuEditorRoute extends StatelessWidget {
  final PieMenu pieMenu;

  const PieMenuEditorRoute(this.pieMenu, {super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<Database>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PieMenuState.fromPieMenu(db, pieMenu)),
        ChangeNotifierProvider(create: (_) => PieMenuEditorPageViewModel(db)),

      ],
      child: const PieMenuEditorPage(),
    );
  }
}
