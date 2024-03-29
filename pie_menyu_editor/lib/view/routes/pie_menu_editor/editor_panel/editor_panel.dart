import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:provider/provider.dart';

import 'actions_tab.dart';
import 'editor_panel_view_model.dart';
import 'pie_item_list_tab.dart';
import 'properties_tab/properties_tab.dart';

class EditorPanel extends StatefulWidget {
  const EditorPanel({super.key});

  @override
  State<EditorPanel> createState() => _EditorPanelState();
}

class _EditorPanelState extends State<EditorPanel> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditorPanelViewModel>();
    return Column(
      children: [
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: "tab-pie-items".i18n()),
                    Tab(text: "tab-properties".i18n()),
                    Tab(text: "tab-actions".i18n()),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      PieItemListTab(),
                      PropertiesTab(),
                      ActionsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    viewModel.saveState(context.read<PieMenuState>());
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: Text("button-save".i18n()),
                ),
              ),
              const Gap(10),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0x1AFF9300),
                  ),
                  onPressed: () {
                    context.read<PieMenuState>().load();
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Color(0xFFC47C00),
                  ),
                  label: Text(
                    "button-reset".i18n(),
                    style: const TextStyle(color: Color(0xFFC47C00)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void newHotkeyTask() {}
}
