import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_view.dart';
import 'package:provider/provider.dart';

import '../../widgets/title_bar.dart';
import 'editor_panel/editor_panel.dart';

class PieMenuEditorPage extends StatefulWidget {
  const PieMenuEditorPage({super.key});

  @override
  State<PieMenuEditorPage> createState() => _PieMenuEditorPageState();
}

class _PieMenuEditorPageState extends State<PieMenuEditorPage> {
  @override
  Widget build(BuildContext context) {
    final pieMenuState = context.watch<PieMenuState>();

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
              "${"label-editing".tr()}: ${pieMenuState.name}",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white30,
                    child: PieMenuView(
                      state: pieMenuState,
                      onTap: (instance) {
                        pieMenuState.activePieItemInstance = instance;
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 325, child: EditorPanel()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
