import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/flutter/navigator.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/pie_menu_page_view_model.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/preview_panel/preview_panel.dart';
import 'package:provider/provider.dart';

import '../../widgets/title_bar.dart';
import 'editor_panel/editor_panel.dart';

class PieMenuEditorPage extends StatefulWidget {
  const PieMenuEditorPage({super.key});

  @override
  State<PieMenuEditorPage> createState() => _PieMenuEditorPageState();
}

class _PieMenuEditorPageState extends State<PieMenuEditorPage> {
  bool changed = false;

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
              onPressed: () {
                Navigator.of(context).popAndClearSnackBar();

                final viewModel = context.read<PieMenuEditorPageViewModel>();
                viewModel.saveState(context.read<PieMenuState>());
              },
              child: const Icon(Icons.arrow_back_rounded, size: 15),
            ),
            title: Text(
              "${"label-editing".tr()}: $pieMenuName",
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: TextButton(
              onPressed: () {
                final viewModel = context.read<PieMenuEditorPageViewModel>();
                viewModel.saveState(context.read<PieMenuState>());
              },
              child: const Icon(Icons.save, size: 15),
            ),
            hidePieMenyuStatus: true,
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
