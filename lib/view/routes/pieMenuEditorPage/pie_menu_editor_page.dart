import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/db.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/view/controller/pie_menu_controller.dart';
import 'package:pie_menyu/view/routes/pieMenuEditorPage/pie_menu_editor_page_title_bar.dart';
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
    pieMenuController.value = widget.pieMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            const PieMenuEditorPageTitleBar(),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: pieMenuController,
                  builder: (context, value, child) => Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: PieMenuPreview(pieMenu: value),
                          ),
                          SizedBox(
                              width: 325,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: PieMenuProperties(
                                        controller: pieMenuController),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            onPressed: savePieMenu,
                                            icon: const Icon(Icons.save_outlined),
                                            label: Text("button-save".i18n()),
                                          ),
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.orange,
                                            ),
                                            onPressed: resetPieMenu,
                                            icon: const Icon(Icons.refresh),
                                            label: Text("button-reset".i18n()),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )),
            ),
          ],
        ));
  }

  savePieMenu() {
    DB.putPieMenu(pieMenuController.value);
  }

  resetPieMenu() {}
}
