import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_editor/system/file_icon.dart';
import 'package:pie_menyu_editor/view/widgets/PrimaryButton.dart';
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
    final pieItems = context.watch<PieMenuState>().pieItems;
    return ReorderableListView(
      header: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryButton(
          onPressed: () => context
              .read<PieMenuState>()
              .addPieItem(PieItem(displayName: "label-new-pie-item".i18n())),
          label: Text("label-new-pie-item".i18n()),
          icon: FontAwesomeIcons.plus,
        ),
      ),
      children: [
        for (final PieItem pieItem in pieItems)
          SizedBox(
            key: ValueKey(pieItem),
            width: 280,
            child: ListTile(
              title: MinimalTextField(
                content: pieItem.displayName,
                onSubmitted: (String value) {
                  context
                      .read<PieMenuState>()
                      .updatePieItem(pieItem..displayName = value);
                },
              ),
              leading: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(5),
                  minimumSize: const Size(50, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 2,
                  ),
                ),
                onPressed: () async {
                  String? icon = await pickPieItemIconFromFile();
                  if (icon != null) {
                    context
                        .read<PieMenuState>()
                        .putPieItem(pieItem..iconBase64 = icon);
                  }
                },
                child: Image.memory(
                  width: 32,
                  height: 32,
                  base64Decode(pieItem.iconBase64),
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(FontAwesomeIcons.plus),
                ),
              ),
            ),
          ),
      ],
      onReorder: (oldIndex, newIndex) {},
    );
  }

  Future<String?> pickPieItemIconFromFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return FileIcon.getBase64(result.files.single.path!);
    }

    return null;
  }
}