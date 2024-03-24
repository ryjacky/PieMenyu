import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/preview_panel/preview_panel.dart';
import 'package:provider/provider.dart';

import '../../widgets/title_bar.dart';
import 'editor_panel/editor_panel.dart';

class PieMenuEditorPage extends StatelessWidget {
  const PieMenuEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pieMenuName =
        context.select<PieMenuState, String>((value) => value.name);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          TitleBar(
            leading: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back_rounded, size: 15),
            ),
            title: Text(
              "${"label-editing".tr()}: $pieMenuName",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(child: PreviewPanel()),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant),
                    ),
                  ),
                  width: 325,
                  child: const EditorPanel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
