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
import 'package:pie_menyu_editor/system/file_icon.dart';
import 'package:pie_menyu_editor/view/widgets/PrimaryButton.dart';
import 'package:pie_menyu_editor/view/widgets/alphanumeric_input_field.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:provider/provider.dart';

import '../pie_menu_state.dart';

class PieItemListTab extends StatefulWidget {
  const PieItemListTab({super.key});

  @override
  State<PieItemListTab> createState() => _PieItemListTabState();
}

class _PieItemListTabState extends State<PieItemListTab> {
  @override
  Widget build(BuildContext context) {
    final pieItems = context
        .watch<PieMenuState>()
        .pieItems;
    final pieMenu = context
        .watch<PieMenuState>()
        .pieMenu;
    return ReorderableListView(
      header: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryButton(
          onPressed: () =>
              context
                  .read<PieMenuState>()
                  .addPieItem(
                  PieItem(displayName: "label-new-pie-item".i18n())),
          label: Text("label-new-pie-item".i18n()),
          icon: FontAwesomeIcons.plus,
        ),
      ),
      children: [
        for (final PieItem pieItem in pieItems)
          SizedBox(
            key: ValueKey(pieItem),
            width: 310,
            child: ListTile(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: MinimalTextField(
                      content: pieItem.displayName,
                      onSubmitted: (String value) {
                        context
                            .read<PieMenuState>()
                            .updatePieItem(pieItem..displayName = value);
                      },
                    ),
                  ),
                  const Gap(10),
                  SizedBox(
                    width: 32,
                    child: Tooltip(
                      message: "tooltip-pie-item-key".i18n(),
                      child: SingleAlphanumericInputField(
                        initialValue: pieMenu.keyToPieItemIdList
                            .where((element) => element.pieItemId == pieItem.id,).firstOrNull?.keyCode ?? "",
                        onSubmitted: (String value) {
                          var keyToPieItemIdList = pieMenu.keyToPieItemIdList;
                          bool updated = false;
                          for (int i = 0; i < keyToPieItemIdList.length; i++) {
                            if (keyToPieItemIdList[i].pieItemId == pieItem.id) {
                              keyToPieItemIdList[i] = keyToPieItemIdList[i]
                                ..keyCode = value;
                              updated = true;
                              break;
                            }
                          }
                          if (!updated) {
                            keyToPieItemIdList = [
                              ...keyToPieItemIdList,
                              PieItemInstanceInfo(
                                pieItemId: pieItem.id,
                                keyCode: value,
                              )
                            ];
                          }
                          context
                              .read<PieMenuState>()
                              .updatePieMenu(pieMenu..keyToPieItemIdList = keyToPieItemIdList);
                        },
                      ),
                    )
                  ),
                ],
              ),
              leading: createAddIconButton(pieItem),
              trailing: createDeleteButton(pieItem),
            ),
          ),
      ],
      onReorder: (oldIndex, newIndex) {
        context.read<PieMenuState>().reorderPieItem(oldIndex, newIndex - 1);
      },
    );
  }

  Future<String?> pickPieItemIconFromFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return FileIcon.getBase64(result.files.single.path!);
    }

    return null;
  }

  Widget createAddIconButton(PieItem pieItem) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(5),
        minimumSize: const Size(50, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        side: BorderSide(
          color: Theme
              .of(context)
              .colorScheme
              .outlineVariant,
          width: 2,
        ),
      ),
      onPressed: () async {
        String? icon = await pickPieItemIconFromFile();
        if (icon != null) {
          context.read<PieMenuState>().putPieItem(pieItem..iconBase64 = icon);
        }
      },
      child: Image.memory(
        width: 32,
        height: 32,
        base64Decode(pieItem.iconBase64),
        errorBuilder: (context, error, stackTrace) =>
        const Icon(FontAwesomeIcons.plus),
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
        child: const Icon(
          FontAwesomeIcons.minus,
          color: Colors.red,
          size: 12,
        ),
        onLongPress: () {
          final result = context.read<PieMenuState>().removePieItem(pieItem);
          if (!result) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red[400],
                content: Text(
                    "message-pie-item-not-deleted-${Random().nextInt(5)}"
                        .i18n()),
                duration: const Duration(seconds: 5),
              ),
            );
          }
        },
      ),
    );
  }
}
