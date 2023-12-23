import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_editor/view/routes/pieMenuEditorPage/pie_menu_editor_page.dart';
import 'package:provider/provider.dart';

import 'pie_menu_editor_page_view_model.dart';

class PieMenuEditorPageRoute extends StatelessWidget {
  final PieMenu pieMenu;

  const PieMenuEditorPageRoute(this.pieMenu, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PieMenuEditorPageViewModel(
            currentPieItemId: 0,
            pieMenu: pieMenu,
          ),
        )
      ],
      child: const PieMenuEditorPage(),
    );
  }
}
