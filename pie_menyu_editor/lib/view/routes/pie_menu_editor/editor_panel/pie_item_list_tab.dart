import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/editor_panel/pie_item_list_item.dart';
import 'package:pie_menyu_editor/view/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class PieItemListTab extends StatefulWidget {
  const PieItemListTab({super.key});

  @override
  State<PieItemListTab> createState() => _PieItemListTabState();
}

class _PieItemListTabState extends State<PieItemListTab> {
  Widget? icon;

  @override
  Widget build(BuildContext context) {
    final pieItemInstances =
        context.select<PieMenuState, List<PieItemDelegate>>(
            (state) => state.pieItemDelegates);
    final pieMenuState = context.watch<PieMenuState>();

    return ReorderableListView(
      buildDefaultDragHandles: false,
      header: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryButton(
          onPressed: () => pieMenuState
              .putPieItem(PieItem(name: "label-new-pie-item".tr())),
          label: Text("label-new-pie-item".tr()),
          icon: FontAwesomeIcons.plus,
        ),
      ),
      onReorder: (oldI, newI) => pieMenuState.reorderPieItem(oldI, newI - 1),
      children: [
        for (final piInstance in pieItemInstances)
          Padding(
            key: ValueKey(piInstance.pieItemId),
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
            child: Row(
              children: [
                ReorderableDragStartListener(
                  index: pieItemInstances.indexOf(piInstance),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeDown,
                    child: Icon(
                      FontAwesomeIcons.gripVertical,
                      size: 15,
                      color: piInstance == pieMenuState.activePieItemDelegate ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Expanded(
                  child: PieItemListItem(
                    piInstance: piInstance,
                    pieMenuState: pieMenuState,
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
