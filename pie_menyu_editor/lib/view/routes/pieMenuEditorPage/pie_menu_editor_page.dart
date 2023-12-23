import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/widgets/pie_menu_view.dart';
import 'package:pie_menyu_editor/view/routes/pieMenuEditorPage/pie_menu_editor_page_title_bar.dart';
import 'package:pie_menyu_editor/view/routes/pieMenuEditorPage/pie_menu_editor_page_view_model.dart';
import 'package:pie_menyu_editor/view/routes/pieMenuEditorPage/pie_menu_properties.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:provider/provider.dart';

class PieMenuEditorPage extends StatefulWidget {
  const PieMenuEditorPage({super.key});

  @override
  State<PieMenuEditorPage> createState() => _PieMenuEditorPageState();
}

class _PieMenuEditorPageState extends State<PieMenuEditorPage> {


  @override
  Widget build(BuildContext context) {
    final pieItemOrderIndex = context.select<PieMenuEditorPageViewModel, int>(
        (value) => value.pieItemOrderIndex);
    final pieMenu = context.watch<PieMenuEditorPageViewModel>().pieMenu;
    final pieItems = context.select<PieMenuEditorPageViewModel, List<PieItem>>(
        (value) => value.pieItems);

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
                  child: Container(
                    color: Colors.white30,
                    child: PieMenuView(
                      pieItemOrderIndex: pieItemOrderIndex,
                      pieMenu: pieMenu,
                      pieItems: pieItems,
                      onPieItemClicked: (pieItemOrderIndex) {
                        context
                            .read<PieMenuEditorPageViewModel>()
                            .pieItemOrderIndex = pieItemOrderIndex;
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 325, child: PieMenuProperties()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
