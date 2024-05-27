import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mime/mime.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/system/file_icon.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:pie_menyu_editor/view/widgets/single_key_recorder.dart';
import 'package:provider/provider.dart';

class PieItemEdit extends StatefulWidget {
  final PieItemDelegate pieItemDelegate;
  final PieMenuState pieMenuState;
  final bool allowDelete;

  const PieItemEdit({
    super.key,
    required this.pieItemDelegate,
    required this.pieMenuState,
    this.allowDelete = true,
  });

  @override
  State<PieItemEdit> createState() => _PieItemEditState();
}

class _PieItemEditState extends State<PieItemEdit> {
  Widget? _icon;

  static const List<IconData> icons = [
    Icons.paste,
    Icons.save,
    Icons.settings,
    Icons.search,
    Icons.share,
    Icons.star,
    Icons.brush,
    Icons.camera,
    Icons.cloud,
    Icons.delete,
    Icons.edit,
    Icons.email,
    Icons.favorite,
    Icons.home,
    Icons.image,
    Icons.info,
    Icons.link,
    Icons.menu,
    Icons.notifications,
    Icons.people,
    Icons.phone,
    Icons.print,
    Icons.imagesearch_roller,
    Icons.looks_one,
    Icons.looks_two,
    Icons.looks_3,
    Icons.looks_4,
    Icons.looks_5,
    Icons.looks_6,
    Icons.web,
    Icons.work,
    Icons.water_drop,
    Icons.layers,
    Icons.blur_on,
    Icons.filter,
    Icons.pin_end,
    Icons.format_color_fill,
    Icons.text_format,
    Icons.view_in_ar,
    Icons.select_all,
    Icons.mouse,
    Icons.keyboard,
    Icons.add_a_photo,
    Icons.fiber_smart_record,
    Icons.public,
    Icons.save,
    Icons.copy,
    Icons.auto_fix_high,
    Icons.volume_up,
    Icons.volume_down,
    Icons.volume_off,
    Icons.play_circle,
    Icons.pause_circle,
    Icons.stop_circle,
    Icons.skip_next,
    Icons.skip_previous,
    Icons.replay,
    Icons.animation,
    Icons.deblur,
    Icons.folder_copy,
    Icons.folder_open,
    Icons.file_open,
  ];

  @override
  Widget build(BuildContext context) {
    PieItem? pieItem = widget.pieItemDelegate.pieItem;
    pieItem ??= PieItem(name: "Loading...".tr());

    final pieMenuState = widget.pieMenuState;
    final piInstance = widget.pieItemDelegate;

    // Check if the icon is an IconData or a base64 string and display it accordingly
    // If the icon is not set, display a default icon
    if (pieItem.iconDataCode != null) {
      _icon = Icon(
        IconData(pieItem.iconDataCode!, fontFamily: 'MaterialIcons'),
        size: 20,
      );
    } else if (pieItem.iconBase64 != null) {
      _icon = Image.memory(
        base64Decode(pieItem.iconBase64!),
        width: 20,
        height: 20,
        errorBuilder: (context, object, error) {
          return const Icon(Icons.upload_file, size: 25);
        },
      );
    } else {
      _icon = const Icon(Icons.upload_file, size: 25);
    }

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
                  showSnackBar("message-slice-key-is-used", Colors.red[400]!);
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
    return Tooltip(
      enableTapToDismiss: false,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: themeColorScheme.surface,
        border: Border.all(color: themeColorScheme.outlineVariant, width: 1),
      ),
      richMessage: WidgetSpan(
        child: SizedBox(
          width: 300,
          height: 300,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 8,
            children: [
              _buildIconButton(
                Icons.upload_file,
                onPressed: () => pickIcon(pieItem),
              ),
              _buildIconButton(
                Icons.remove_circle_outline_rounded,
                fgColor: Colors.red,
                onPressed: () => setState(() {
                  context
                      .read<PieMenuState>()
                      .putPieItem(pieItem..iconBase64 = null);
                }),
              ),
              const VerticalDivider(indent: 7, endIndent: 7),
              for (var icon in icons)
                _buildIconButton(
                  icon,
                  onPressed: () => setState(() {
                    context
                        .read<PieMenuState>()
                        .putPieItem(pieItem..iconDataCode = icon.codePoint);
                  }),
                  fgColor: themeColorScheme.secondary,
                )
            ],
          ),
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: themeColorScheme.secondary,
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(45, 45),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          side: BorderSide(color: themeColorScheme.outlineVariant, width: 2),
          backgroundColor: themeColorScheme.surface,
        ),
        onPressed: () => pickIcon(pieItem),
        child: _icon!,
      ),
    );
  }

  IconButton _buildIconButton(
    IconData iconData, {
    required Function() onPressed,
    Color? fgColor,
  }) {
    return IconButton(
      icon: Icon(iconData, color: fgColor),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: fgColor,
        padding: const EdgeInsets.all(5),
        minimumSize: const Size(0, 0),
      ),
    );
  }

  void showSnackBar(String message, Color backgroundColor,
      {SnackBarAction? action}) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(8, 8, 334, 8),
        action: action,
        backgroundColor: backgroundColor,
        content: Text(message.tr()),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  Widget createDeleteButton(PieItem pieItem) {
    return _buildIconButton(
      Icons.delete_outline_rounded,
      fgColor: Colors.red,
      onPressed: () {
        final pieMenuState = context.read<PieMenuState>();
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        if (!pieMenuState.removePieItem(pieItem)) {
          showSnackBar(
            "message-pie-item-not-deleted-${Random().nextInt(5)}",
            Colors.red[400]!,
          );
        } else {
          final pieMenuState = context.read<PieMenuState>();
          pieMenuState.activePieItemDelegate =
              pieMenuState.pieItemDelegates.first;

          showSnackBar(
            "message-removed-pie-item",
            Theme.of(context).colorScheme.primary,
            action: SnackBarAction(
              label: "label-undo".tr(),
              onPressed: () {
                pieMenuState.undoRemove();
                scaffoldMessenger.clearSnackBars();
              },
            ),
          );
        }
      },
    );
  }

  pickIcon(PieItem pieItem) async {
    String? icon;

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

    if (icon != null && mounted) {
      setState(() {
        context.read<PieMenuState>().putPieItem(pieItem..iconBase64 = icon);
      });
    }
  }
}
