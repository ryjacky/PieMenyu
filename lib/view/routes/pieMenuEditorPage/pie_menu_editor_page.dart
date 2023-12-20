import 'package:flutter/material.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/view/routes/pieMenuEditorPage/pie_menu_editor_page_title_bar.dart';
import 'package:pie_menyu/view/routes/pieMenuEditorPage/pie_menu_editor_page_view_model.dart';
import 'package:pie_menyu/view/routes/pieMenuEditorPage/pie_menu_preview.dart';
import 'package:pie_menyu/view/routes/pieMenuEditorPage/pie_menu_properties.dart';
import 'package:provider/provider.dart';

class PieMenuEditorPage extends StatefulWidget {
  final PieMenu pieMenu;

  const PieMenuEditorPage({super.key, required this.pieMenu});

  @override
  State<PieMenuEditorPage> createState() => _PieMenuEditorPageState();
}

class _PieMenuEditorPageState extends State<PieMenuEditorPage> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PieMenuEditorPageViewModel(
            currentPieItemId: 0,
            pieMenu: widget.pieMenu,
          ),
        ),
      ],
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              const PieMenuEditorPageTitleBar(),
              Expanded(
                child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                              color: Colors.white30,
                              child: const PieMenuPreview()),
                        ),
                        SizedBox(
                            width: 325,
                            child: PieMenuProperties()),
                      ],
                    ),
              ),
            ],
          )),
    );
  }
}
