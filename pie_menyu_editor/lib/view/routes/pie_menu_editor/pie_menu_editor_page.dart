import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_view.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_item_order_index_controller.dart';
import 'package:provider/provider.dart';

import 'pie_menu_editor_page_title_bar.dart';
import 'editor_panel/editor_panel.dart';
import 'pie_menu_state.dart';

class PieMenuEditorPage extends StatefulWidget {
  const PieMenuEditorPage({super.key});

  @override
  State<PieMenuEditorPage> createState() => _PieMenuEditorPageState();
}

class _PieMenuEditorPageState extends State<PieMenuEditorPage> {
  @override
  Widget build(BuildContext context) {
    final pieItemOrderIndex = 0;
    final pieMenu = context.watch<PieMenuState>().pieMenu;
    final pieItems = context.select<PieMenuState, List<PieItem>>(
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
                      pieItemOrderIndexController: PieItemOrderIndexController(pieItemOrderIndex),
                      pieMenu: pieMenu,
                      pieItems: pieItems.toList(),
                      onPieItemClicked: (pieItemIndex) {
                        context.read<PieMenuState>().setActivePieItem(
                            pieItems.elementAt(pieItemIndex));
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 325, child: EditorPanel()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
