import 'dart:convert';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/system/file_icon.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:pie_menyu_editor/view/widgets/single_key_recorder.dart';
import 'package:provider/provider.dart';

class PieItemListItem extends StatefulWidget {
  final PieItemInstance piInstance;
  final PieMenuState pieMenuState;

  const PieItemListItem(
      {super.key, required this.piInstance, required this.pieMenuState});

  @override
  State<PieItemListItem> createState() => _PieItemListItemState();
}

class _PieItemListItemState extends State<PieItemListItem> {
  Image? _icon;

  @override
  Widget build(BuildContext context) {
    PieItem? pieItem = widget.piInstance.pieItem;
    pieItem ??= PieItem(name: "Loading...".tr());

    final pieMenuState = widget.pieMenuState;
    final piInstance = widget.piInstance;

    _icon ??= createIconWidget(pieItem.iconBase64);

    return Row(
      children: [
        const Gap(6),
        createAddIconButton(pieItem),
        const Gap(6),
        Expanded(
          child: MinimalTextField(
            content: pieItem.name,
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
              initialValue: piInstance.keyCode,
              onSubmitted: (String value) {
                pieMenuState.updatePieItemInstance(piInstance..keyCode = value);
              },
            ),
          ),
        ),
        const Gap(6),
        createDeleteButton(pieItem),
      ],
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
          createIconWidget(icon);
          context.read<PieMenuState>().putPieItem(pieItem..iconBase64 = icon);
        }
      },
      child: _icon!,
    );
  }

  Widget createDeleteButton(PieItem pieItem) {
    return Tooltip(
      message: "tooltip-long-press-to-delete".tr(),
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
                  "message-pie-item-not-deleted-${Random().nextInt(5)}".tr(),
                ),
                duration: const Duration(seconds: 5),
              ),
            );
          }
        },
      ),
    );
  }

  createIconWidget(String iconBase64) {
    return Image.memory(
      width: 28,
      height: 28,
      isAntiAlias: true,
      base64Decode(iconBase64),
      errorBuilder: (_, __, ___) => const Icon(Icons.upload_file),
    );
  }
}
