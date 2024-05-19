import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/pieItemTasks/mouse_click_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_app_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_folder_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_sub_menu_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_url_task.dart';
import 'package:pie_menyu_core/pieItemTasks/run_file_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_text_task.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/single_icon_button.dart';
import 'package:provider/provider.dart';

import 'pie_item_list_item.dart';
import 'pie_item_task_list.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    final activePieItemDelegate = context.select<PieMenuState, PieItemDelegate>(
        (state) => state.activePieItemDelegate);

    final pieMenuState = context.read<PieMenuState>();

    return activePieItemDelegate.pieItem == null
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                child: PieItemListItem(
                  pieItemDelegate: activePieItemDelegate,
                  pieMenuState: context.read<PieMenuState>(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                child: Text(
                  "label-add-task".tr(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: 310,
                height: 100,
                child: buildAddTaskButtonListView(
                    pieMenuState, activePieItemDelegate),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: PieItemTaskList(),
              )),
            ],
          );
  }

  buildAddTaskButtonListView(
    PieMenuState pieMenuState,
    PieItemDelegate activePieItemDelegate,
  ) {
    return GridView.count(
      crossAxisCount: 6,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      children: [
        Tooltip(
          preferBelow: false,
          message: "tooltip-add-send-key-task".tr(),
          child: SingleColorIconButton(
            icon: Icons.keyboard,
            onPressed: () {
              pieMenuState.addTaskTo(activePieItemDelegate, SendKeyTask());
            },
          ),
        ),
        Tooltip(
          preferBelow: false,
          message: "tooltip-add-mouse-click-task".tr(),
          child: SingleColorIconButton(
            icon: FontAwesomeIcons.handPointer,
            onPressed: () {
              pieMenuState.addTaskTo(activePieItemDelegate, MouseClickTask());
            },
          ),
        ),
        Tooltip(
          preferBelow: false,
          message: "tooltip-add-run-file-task".tr(),
          child: SingleColorIconButton(
            icon: Icons.file_open,
            onPressed: () {
              pieMenuState.addTaskTo(activePieItemDelegate, RunFileTask());
            },
          ),
        ),
        Tooltip(
          preferBelow: false,
          message: "tooltip-add-open-sub-menu-task".tr(),
          child: SingleColorIconButton(
            icon: Icons.pie_chart,
            onPressed: () {
              pieMenuState.addTaskTo(activePieItemDelegate, OpenSubMenuTask());
            },
          ),
        ),
        Tooltip(
          preferBelow: false,
          message: "tooltip-add-open-folder-task".tr(),
          child: SingleColorIconButton(
            icon: Icons.folder,
            onPressed: () {
              pieMenuState.addTaskTo(activePieItemDelegate, OpenFolderTask());
            },
          ),
        ),
        Tooltip(
          preferBelow: false,
          message: "tooltip-add-open-app-task".tr(),
          child: SingleColorIconButton(
            icon: Icons.play_arrow_rounded,
            onPressed: () {
              pieMenuState.addTaskTo(activePieItemDelegate, OpenAppTask());
            },
          ),
        ),
        Tooltip(
          preferBelow: false,
          message: "tooltip-add-open-url-task".tr(),
          child: SingleColorIconButton(
            icon: Icons.link,
            onPressed: () {
              pieMenuState.addTaskTo(activePieItemDelegate, OpenUrlTask());
            },
          ),
        ),
        Tooltip(
          preferBelow: false,
          message: "tooltip-paste-text-task".tr(),
          child: SingleColorIconButton(
            icon: Icons.text_fields,
            onPressed: () {
              pieMenuState.addTaskTo(activePieItemDelegate, PasteTextTask());
            },
          ),
        )
      ],
    );
  }
}
