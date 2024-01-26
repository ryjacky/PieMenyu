import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
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

import 'pie_item_task_list.dart';

class ActionsTab extends StatelessWidget {
  const ActionsTab({super.key});

  final double gap = 6;

  @override
  Widget build(BuildContext context) {
    final activePieItemInstance = context.select<PieMenuState, PieItemInstance>(
        (state) => state.activePieItemInstance);

    if (activePieItemInstance.pieItem == null) {
      throw Exception("activePieItem is null");
    }

    final pieMenuState = context.read<PieMenuState>();

    return Row(
      children: [
        const Expanded(
          flex: 7,
          child: PieItemTaskList(),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          width: 50,
          child: buildAddTaskButtonListView(
              pieMenuState, activePieItemInstance),
        ),
      ],
    );
  }

  buildAddTaskButtonListView(
    PieMenuState pieMenuState,
    PieItemInstance activePieItemInstance,
  ) {
    return ListView(children: [
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white70,
          size: 20,
        ),
      ),
      const Divider(
        indent: 7,
        endIndent: 7,
      ),
      Tooltip(
        message: "tooltip-add-send-key-task".tr(),
        child: SingleColorIconButton(
          icon: Icons.keyboard,
          onPressed: () {
            pieMenuState.addTaskTo(activePieItemInstance, SendKeyTask());
          },
        ),
      ),
      Gap(gap),
      Tooltip(
        message: "tooltip-add-mouse-click-task".tr(),
        child: SingleColorIconButton(
          icon: FontAwesomeIcons.handPointer,
          onPressed: () {
            pieMenuState.addTaskTo(activePieItemInstance, MouseClickTask());
          },
        ),
      ),
      Gap(gap),
      Tooltip(
        message: "tooltip-add-run-file-task".tr(),
        child: SingleColorIconButton(
          icon: Icons.file_open,
          onPressed: () {
            pieMenuState.addTaskTo(activePieItemInstance, RunFileTask());
          },
        ),
      ),
      Gap(gap),
      Tooltip(
        message: "tooltip-add-open-sub-menu-task".tr(),
        child: SingleColorIconButton(
          icon: Icons.pie_chart,
          onPressed: () {
            pieMenuState.addTaskTo(activePieItemInstance, OpenSubMenuTask());
          },
        ),
      ),
      Gap(gap),
      Tooltip(
        message: "tooltip-add-open-folder-task".tr(),
        child: SingleColorIconButton(
          icon: Icons.folder,
          onPressed: () {
            pieMenuState.addTaskTo(activePieItemInstance, OpenFolderTask());
          },
        ),
      ),
      Gap(gap),
      Tooltip(
        message: "tooltip-add-open-app-task".tr(),
        child: SingleColorIconButton(
          icon: Icons.play_arrow_rounded,
          onPressed: () {
            pieMenuState.addTaskTo(activePieItemInstance, OpenAppTask());
          },
        ),
      ),
      Gap(gap),
      Tooltip(
        message: "tooltip-add-open-url-task".tr(),
        child: SingleColorIconButton(
          icon: Icons.link,
          onPressed: () {
            pieMenuState.addTaskTo(activePieItemInstance, OpenUrlTask());
          },
        ),
      ),
      Gap(gap),
      Tooltip(
        message: "tooltip-paste-text-task".tr(),
        child: SingleColorIconButton(
          icon: Icons.text_fields,
          onPressed: () {
            pieMenuState.addTaskTo(activePieItemInstance, PasteTextTask());
          },
        ),
      ),
      // Gap(gap),
      // Tooltip(
      //   message: "tooltip-add-open-editor-task".tr(),
      //   child: MonochromeIconButton(
      //     icon: Icons.edit_note,
      //     onPressed: () => context
      //         .read<PieMenuEditorPageViewModel>()
      //         .createTaskInCurrentPieItem(PieItemTaskType.openEditor),
      //   ),
      // ),
      // Gap(gap),
      // Tooltip(
      //   message: "tooltip-add-resize-window-task".tr(),
      //   child: MonochromeIconButton(
      //     icon: Icons.photo_size_select_small,
      //     onPressed: () => context
      //         .read<PieMenuEditorPageViewModel>()
      //         .createTaskInCurrentPieItem(PieItemTaskType.resizeWindow),
      //   ),
      // ),
      // Gap(gap),
      // Tooltip(
      //   message: "tooltip-add-move-window-task".tr(),
      //   child: MonochromeIconButton(
      //     icon: Icons.move_down,
      //     onPressed: () => context
      //         .read<PieMenuEditorPageViewModel>()
      //         .createTaskInCurrentPieItem(PieItemTaskType.moveWindow),
      //   ),
      // ),
      // Gap(gap),
    ]);
  }
}
