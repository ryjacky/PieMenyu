import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_editor/view/widgets/title_bar.dart';
import 'package:provider/provider.dart';

import 'home_page_view_model.dart';
import 'left_panel/left_panel.dart';
import 'right_panels/create_profile_panel.dart';
import 'right_panels/profile_editor_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PieMenu> selectedProfilePieMenus = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final creatingProfile = context
        .select<HomePageViewModel, bool>((value) => value.creatingProfile);
    return Column(
      children: [
        const TitleBar(),
        Expanded(
          child: Row(
            children: [
              const Expanded(flex: 3, child: LeftPanel()),
              Expanded(
                  flex: 7,
                  child: creatingProfile
                      ? const CreateProfilePanel()
                      : const ProfileEditorPanel()),
            ],
          ),
        ),
      ],
    );
  }
}
