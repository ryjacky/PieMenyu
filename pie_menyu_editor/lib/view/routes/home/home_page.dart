import 'package:flutter/material.dart';
import 'package:pie_menyu_editor/view/widgets/title_bar.dart';
import 'package:provider/provider.dart';

import 'home_page_view_model.dart';
import 'left_panel/left_panel.dart';
import 'profile_editor_panel/profile_editor_panel.dart';
import 'right_panels/create_profile_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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