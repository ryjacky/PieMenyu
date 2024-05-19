import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:mime/mime.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/system/file_icon.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:pie_menyu_editor/view/widgets/single_key_recorder.dart';
import 'package:provider/provider.dart';

class PieItemListItem extends StatefulWidget {
  final PieItemDelegate pieItemDelegate;
  final PieMenuState pieMenuState;
  final bool allowDelete;

  const PieItemListItem({
    super.key,
    required this.pieItemDelegate,
    required this.pieMenuState,
    this.allowDelete = true,
  });

  @override
  State<PieItemListItem> createState() => _PieItemListItemState();
}

class _PieItemListItemState extends State<PieItemListItem> {
  Image? _icon;

  @override
  Widget build(BuildContext context) {
    PieItem? pieItem = widget.pieItemDelegate.pieItem;
    pieItem ??= PieItem(name: "Loading...".tr());

    final pieMenuState = widget.pieMenuState;
    final piInstance = widget.pieItemDelegate;

    _icon = Image.memory(
      width: 28,
      height: 28,
      isAntiAlias: true,
      base64Decode(pieItem.iconBase64),
      errorBuilder: (_, __, ___) => const Icon(Icons.upload_file),
    );

    return Row(
      children: [
        const Gap(6),
        createAddIconButton(pieItem),
        const Gap(6),
        Expanded(
          child: MinimalTextField(
            content: pieItem.name,
            controller: TextEditingController(text: pieItem.name),
            onSubmitted: (String value) {
              pieMenuState.putPieItem(pieItem!..name = value);
            },
          ),
        ),
        const Gap(6),
        SizedBox(
          width: 32,
          child: Tooltip(
            message: "tooltip-pie-item-key".tr(),
            child: SingleKeyRecorder(
              controller: TextEditingController(text: piInstance.keyCode),
              onSubmitted: (String value) {
                pieMenuState.updatePieItemDelegate(piInstance..keyCode = value);
              },
              validator: (String value) {
                final valid = pieMenuState.pieItemDelegates
                    .every((pieItem) => pieItem.keyCode != value);

                if (!valid) {
                  showErrorSnackBar();
                }
                return valid;
              },
            ),
          ),
        ),
        const Gap(6),
        if (widget.allowDelete) createDeleteButton(pieItem),
        const Gap(6),
      ],
    );
  }

  Widget createAddIconButton(PieItem pieItem) {
    final themeColorScheme = Theme.of(context).colorScheme;
    return (button) {
      if (pieItem.iconBase64 == "") return button;

      return Tooltip(
        message: "tooltip-remove-icon".tr(),
        child: button,
        preferBelow: false,
      );
    }(TextButton(
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

        if (pieItem.iconBase64 == "") {
          PlatformFile? result =
              (await FilePicker.platform.pickFiles())?.files.firstOrNull;
          if (result != null && result.path != null) {
            String mimeType = lookupMimeType(result.path!) ?? "";

            if (mimeType.startsWith("image") && !result.path!.contains("svg")) {
              icon = base64Encode(File(result.path!).readAsBytesSync());
            } else {
              icon = await FileIcon.getBase64(result.path!);
            }
          }
        } else {
          icon = "";
        }

        if (icon != null && mounted) {
          context.read<PieMenuState>().putPieItem(pieItem..iconBase64 = icon);
          setState(() {});
        }
      },
      child: _icon!,
    ));
  }

  Widget createDeleteButton(PieItem pieItem) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.red,
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(36, 36),
      ),
      child:
          const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 20),
      onPressed: () {
        final pieMenuState = context.read<PieMenuState>();
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        if (!pieMenuState.removePieItem(pieItem)) {
          scaffoldMessenger.hideCurrentSnackBar();
          scaffoldMessenger.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.fromLTRB(8, 8, 334, 8),
              backgroundColor: Colors.red[400],
              content: Text(
                "message-pie-item-not-deleted-${Random().nextInt(5)}".tr(),
              ),
              duration: const Duration(seconds: 5),
            ),
          );
        } else {
          final pieMenuState = context.read<PieMenuState>();
          pieMenuState.activePieItemDelegate =
              pieMenuState.pieItemDelegates.first;

          scaffoldMessenger.hideCurrentSnackBar();
          scaffoldMessenger.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.fromLTRB(8, 8, 334, 8),
              action: SnackBarAction(
                label: "label-undo".tr(),
                onPressed: () {
                  pieMenuState.undoRemove();
                  scaffoldMessenger.clearSnackBars();
                },
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              content: Text("message-removed-pie-item".tr()),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
    );
  }

  void showErrorSnackBar() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(8, 8, 334, 8),
        backgroundColor: Colors.red[400],
        content: Text("message-slice-key-is-used".tr()),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
