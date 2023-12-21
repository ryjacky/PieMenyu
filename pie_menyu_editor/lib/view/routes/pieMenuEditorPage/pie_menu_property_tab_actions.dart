import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_editor/view/widgets/icon_button.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:provider/provider.dart';

import 'pie_item_task_list.dart';
import 'pie_menu_editor_page_view_model.dart';

class PieMenuPropertyTabActions extends StatelessWidget {
  const PieMenuPropertyTabActions({super.key});

  final double gap = 6;

  @override
  Widget build(BuildContext context) {
    final currentPieItemId = context.select<PieMenuEditorPageViewModel, int>(
        (value) => value.currentPieItemId);

    return Row(
      children: [
        Expanded(
          flex: 7,
          child: currentPieItemId == 0
              ? Text(
                  "hint-select-pie-item-first".i18n(),
                  textAlign: TextAlign.center,
                )
              : const PieItemTaskList(),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          width: 50,
          child: ListView(children: [
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
              message: "tooltip-add-send-key-task".i18n(),
              child: MonochromeIconButton(
                icon: Icons.keyboard,
                onPressed: () => context
                    .read<PieMenuEditorPageViewModel>()
                    .createTaskInCurrentPieItem(PieItemTaskType.sendKey),
              ),
            ),
            Gap(gap),
            // Tooltip(
            //   message: "tooltip-add-mouse-click-task".i18n(),
            //   child: MonochromeIconButton(
            //     icon: FontAwesomeIcons.handPointer,
            //     onPressed: () => context
            //         .read<PieMenuEditorPageViewModel>()
            //         .createTaskInCurrentPieItem(PieItemTaskType.mouseClick),
            //   ),
            // ),
            // Gap(gap),
            // Tooltip(
            //   message: "tooltip-add-run-file-task".i18n(),
            //   child: MonochromeIconButton(
            //     icon: Icons.file_open,
            //     onPressed: () => context
            //         .read<PieMenuEditorPageViewModel>()
            //         .createTaskInCurrentPieItem(PieItemTaskType.runFile),
            //   ),
            // ),
            // Gap(gap),
            // Tooltip(
            //   message: "tooltip-add-open-sub-menu-task".i18n(),
            //   child: MonochromeIconButton(
            //     icon: Icons.pie_chart,
            //     onPressed: () => context
            //         .read<PieMenuEditorPageViewModel>()
            //         .createTaskInCurrentPieItem(PieItemTaskType.openSubMenu),
            //   ),
            // ),
            // Gap(gap),
            // Tooltip(
            //   message: "tooltip-add-open-folder-task".i18n(),
            //   child: MonochromeIconButton(
            //     icon: Icons.folder,
            //     onPressed: () => context
            //         .read<PieMenuEditorPageViewModel>()
            //         .createTaskInCurrentPieItem(PieItemTaskType.openFolder),
            //   ),
            // ),
            // Gap(gap),
            // Tooltip(
            //   message: "tooltip-add-open-app-task".i18n(),
            //   child: MonochromeIconButton(
            //     icon: Icons.play_arrow_rounded,
            //     onPressed: () => context
            //         .read<PieMenuEditorPageViewModel>()
            //         .createTaskInCurrentPieItem(PieItemTaskType.openApp),
            //   ),
            // ),
            // Gap(gap),
            // Tooltip(
            //   message: "tooltip-add-open-url-task".i18n(),
            //   child: MonochromeIconButton(
            //     icon: Icons.link,
            //     onPressed: () => context
            //         .read<PieMenuEditorPageViewModel>()
            //         .createTaskInCurrentPieItem(PieItemTaskType.openUrl),
            //   ),
            // ),
            // Gap(gap),
            // Tooltip(
            //   message: "tooltip-add-open-editor-task".i18n(),
            //   child: MonochromeIconButton(
            //     icon: Icons.edit_note,
            //     onPressed: () => context
            //         .read<PieMenuEditorPageViewModel>()
            //         .createTaskInCurrentPieItem(PieItemTaskType.openEditor),
            //   ),
            // ),
            // Gap(gap),
            // Tooltip(
            //   message: "tooltip-add-resize-window-task".i18n(),
            //   child: MonochromeIconButton(
            //     icon: Icons.photo_size_select_small,
            //     onPressed: () => context
            //         .read<PieMenuEditorPageViewModel>()
            //         .createTaskInCurrentPieItem(PieItemTaskType.resizeWindow),
            //   ),
            // ),
            // Gap(gap),
            // Tooltip(
            //   message: "tooltip-add-move-window-task".i18n(),
            //   child: MonochromeIconButton(
            //     icon: Icons.move_down,
            //     onPressed: () => context
            //         .read<PieMenuEditorPageViewModel>()
            //         .createTaskInCurrentPieItem(PieItemTaskType.moveWindow),
            //   ),
            // ),
            // Gap(gap),
          ]),
        ),
      ],
    );
  }
}
