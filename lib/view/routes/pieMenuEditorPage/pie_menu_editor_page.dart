import 'package:flutter/material.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/view/routes/pieMenuEditorPage/pie_menu_editor_page_title_bar.dart';
import 'package:pie_menyu/view/controller/pie_menu_controller.dart';
import 'package:pie_menyu/view/routes/pieMenuEditorPage/pie_menu_preview.dart';
import 'package:pie_menyu/view/routes/pieMenuEditorPage/pie_menu_properties.dart';

class PieMenuEditorPage extends StatefulWidget {
  final PieMenu pieMenu;
  const PieMenuEditorPage({super.key, required this.pieMenu});

  @override
  State<PieMenuEditorPage> createState() => _PieMenuEditorPageState();
}

class _PieMenuEditorPageState extends State<PieMenuEditorPage> {
  final pieMenuController = PieMenuController(PieMenu());

  @override
  void initState() {
    super.initState();
    pieMenuController.update(widget.pieMenu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            const PieMenuEditorPageTitleBar(),
            ValueListenableBuilder(
              valueListenable: pieMenuController,
              builder: (context, value, child) => Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: PieMenuPreview(pieMenu: value),
                    ),
                    SizedBox(
                        width: 300,
                        child: PieMenuProperties(
                          controller: pieMenuController
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
