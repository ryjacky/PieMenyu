import 'dart:convert';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_editor/coreExtended/real_pie_item_instance.dart';
import 'package:pie_menyu_editor/system/file_icon.dart';
import 'package:pie_menyu_editor/view/widgets/primary_button.dart';
import 'package:pie_menyu_editor/view/widgets/single_key_recorder.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:provider/provider.dart';

import '../pie_menu_state.dart';

class PieItemListTab extends StatefulWidget {
  const PieItemListTab({super.key});

  @override
  State<PieItemListTab> createState() => _PieItemListTabState();
}

class _PieItemListTabState extends State<PieItemListTab> {
  static const double gap = 6;

  @override
  Widget build(BuildContext context) {
    final pieItemInstances = context.watch<PieMenuState>().pieItemInstances;
    final pieMenuState = context.watch<PieMenuState>();

    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      header: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryButton(
          onPressed: () => pieMenuState
              .addPieItem(PieItem(displayName: "label-new-pie-item".i18n())),
          label: Text("label-new-pie-item".i18n()),
          icon: FontAwesomeIcons.plus,
        ),
      ),
      itemCount: pieItemInstances.length,
      onReorder: (oldI, newI) => pieMenuState.reorderPieItem(oldI, newI - 1),
      itemBuilder: (BuildContext context, int index) {
        final piInstance = pieItemInstances[index];
        return Padding(
          key: ValueKey(piInstance),
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeDown,
                  child: Icon(
                    FontAwesomeIcons.gripVertical,
                    size: 15,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              const Gap(gap),
              createAddIconButton(piInstance.pieItem),
              const Gap(gap),
              Expanded(
                child: MinimalTextField(
                  content: piInstance.pieItem.displayName,
                  onSubmitted: (String value) {
                    pieMenuState
                        .updatePieItem(piInstance.pieItem..displayName = value);
                  },
                ),
              ),
              const Gap(gap),
              SizedBox(
                width: 32,
                child: Tooltip(
                  message: "tooltip-pie-item-key".i18n(),
                  child: SingleKeyRecorder(
                    initialValue: piInstance.keyCode,
                    onSubmitted: (String value) {
                      pieMenuState
                          .updatePieItemInstance(piInstance..keyCode = value);
                    },
                  ),
                ),
              ),
              const Gap(gap),
              createDeleteButton(piInstance.pieItem),
            ],
          ),
        );
      },
    );
  }

  Widget createAddIconButton(PieItem pieItem) {
    final themeColorScheme = Theme.of(context).colorScheme;
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: themeColorScheme.secondary,
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(45, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        side: BorderSide(color: themeColorScheme.outlineVariant, width: 2),
        backgroundColor: themeColorScheme.surface,
      ),
      onPressed: () async {
        String? icon;

        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          icon = await FileIcon.getBase64(result.files.single.path!);
        }

        if (icon != null && context.mounted) {
          context.read<PieMenuState>().putPieItem(pieItem..iconBase64 = icon);
        }
      },
      child: Image.memory(
        width: 28,
        height: 28,
        isAntiAlias: true,
        base64Decode(pieItem.iconBase64),
        errorBuilder: (_, __, ___) => const Icon(Icons.upload_file),
      ),
    );
  }

  Widget createDeleteButton(PieItem pieItem) {
    return Tooltip(
      message: "tooltip-long-press-to-delete".i18n(),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.red,
          padding: const EdgeInsets.all(5),
          minimumSize: const Size(36, 36),
        ),
        onPressed: () {},
        child: const Icon(FontAwesomeIcons.minus, color: Colors.red, size: 12),
        onLongPress: () {
          final result = context.read<PieMenuState>().removePieItem(pieItem);
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          if (!result) {
            scaffoldMessenger.hideCurrentSnackBar();
            scaffoldMessenger.showSnackBar(
              SnackBar(
                backgroundColor: Colors.red[400],
                content: Text(
                  "message-pie-item-not-deleted-${Random().nextInt(5)}".i18n(),
                ),
                duration: const Duration(seconds: 5),
              ),
            );
          }
        },
      ),
    );
  }
}
