import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_editor/view/routes/home/profile_editor_panel/no_pie_menu_hint.dart';
import 'package:pie_menyu_editor/view/routes/home/profile_editor_panel/pie_menu_table.dart';
import 'package:pie_menyu_editor/view/routes/home/profile_editor_panel/profile_editor_panel_header.dart';
import 'package:provider/provider.dart';

import '../home_page_view_model.dart';

class ProfileEditorPanel extends StatefulWidget {
  const ProfileEditorPanel({super.key});

  @override
  State<ProfileEditorPanel> createState() => _ProfileEditorPanelState();
}

class _ProfileEditorPanelState extends State<ProfileEditorPanel> {
  @override
  Widget build(BuildContext context) {
    final homePageViewModel = context.watch<HomePageViewModel>();
    final activeProfile = context
        .select<HomePageViewModel, Profile>((value) => value.activeProfile);
    final allPieMenuExceptInProfile =
        homePageViewModel.getAllPieMenusExceptIn(activeProfile);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ProfileEditorPanelHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SingleChildScrollView(
                child: homePageViewModel.getPieMenusOf(activeProfile).isNotEmpty
                    ? const PieMenuTable()
                    : const NoPieMenuHint(),
              ),
            ),
          ),
          ExpansionTile(
            shape: Border.all(color: Colors.transparent),
            title: Text("title-add-pie-menu-from-other-profiles".tr()),
            children: [
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      for (PieMenu pm in allPieMenuExceptInProfile)
                        TextButton(
                          onPressed: () {
                            homePageViewModel.addPieMenuTo(activeProfile, pm);
                          },
                          child: Text("${pm.name} (id: ${pm.id})"),
                        )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
