import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/pieItemTasks/open_sub_menu_task.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/compact_dropdown_menu.dart';
import 'package:provider/provider.dart';

import 'pie_item_task_card.dart';

class OpenSubMenuTaskCard extends StatefulWidget {
  final OpenSubMenuTask task;
  final int order;
  final VoidCallback? onDelete;

  const OpenSubMenuTaskCard({
    super.key,
    required this.task,
    required this.order,
    this.onDelete,
  });

  @override
  State<OpenSubMenuTaskCard> createState() => _OpenSubMenuTaskCardState();
}

class _OpenSubMenuTaskCardState extends State<OpenSubMenuTaskCard> {
  List<PieMenu> allPieMenus = [];

  @override
  void initState() {
    context.read<Database>().getPieMenus().then((value) {
      if (allPieMenus.length != value.length) {
        setState(() {
          allPieMenus = value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PieItemTaskCard(
      label: "label-open-sub-menu-task".tr(),
      onDelete: widget.onDelete,
      children: [
        ListTile(
          leading: Text("label-menu".tr()),
          trailing: CompactDropdownMenu<PieMenu>(
            width: 150,
            initialSelection: allPieMenus
                .where((pieMenu) => pieMenu.id == widget.task.subMenuId)
                .firstOrNull,
            dropdownMenuEntries: [
              for (final pieMenu in allPieMenus)
                DropdownMenuEntry(value: pieMenu, label: "${pieMenu.name}\n(id: ${pieMenu.id})"),
            ],
            onSelected: (pieMenu) {
              if (pieMenu == null) return;

              widget.task.subMenuId = pieMenu.id;

              final state = context.read<PieMenuState>();
              final pieItem = state.activePieItemDelegate;
              state.updateTaskIn(pieItem, widget.task);
            },
          ),
        ),
        const Gap(5)
      ],
    );
  }
}
