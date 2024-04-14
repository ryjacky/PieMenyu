import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
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
                    Tab(text: "label-pie-items".tr()),
                    Tab(text: "label-properties".tr()),
                    Tab(text: "label-tasks".tr()),
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
      ],
    );
  }

  void newHotkeyTask() {}
}
