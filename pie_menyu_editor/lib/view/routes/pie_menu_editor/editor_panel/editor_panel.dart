import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'actions_tab.dart';
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
}
