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
  late PieMenu pieMenu;

  @override
  void initState() {
    pieMenu = widget.pieMenu;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            const PieMenuEditorPageTitleBar(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: PieMenuPreview(pieMenu: pieMenu),
                  ),
                  SizedBox(
                      width: 300,
                      child: PieMenuProperties(pieMenu: pieMenu,
                        onChanged: (onChanged) {
                          setState(() {
                            pieMenu = onChanged;
                          });
                        },
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
