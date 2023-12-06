import 'package:flutter/material.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/ui/routes/pieMenuEditorPage/pie_menu_editor_page_title_bar.dart';
import 'package:pie_menyu/ui/routes/pieMenuEditorPage/pie_menu_preview.dart';
import 'package:pie_menyu/ui/routes/pieMenuEditorPage/pie_menu_properties.dart';

class PieMenuEditorPage extends StatefulWidget {
  final PieMenu pieMenu;
  const PieMenuEditorPage({super.key, required this.pieMenu});

  @override
  State<PieMenuEditorPage> createState() => _PieMenuEditorPageState();
}

class _PieMenuEditorPageState extends State<PieMenuEditorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            const PieMenuEditorPageTitleBar(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: PieMenuPreview()
                  ),
                  Expanded(
                      flex: 4,
                      child: PieMenuProperties(pieMenu: widget.pieMenu,)),
                ],
              ),
            ),
          ],
        ));
  }
}
