import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:provider/provider.dart';

import 'home_page_titlebar.dart';
import 'home_page_view_model.dart';
import 'left_home_panel.dart';
import 'right_create_profile_panel.dart';
import 'right_home_panel.dart';

enum RightPanelType {
  home,
  setting,
  pieMenuEditor,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PieMenu> selectedProfilePieMenus = [];
  RightPanelType currentRightPanelType = RightPanelType.home;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => HomePageViewModel()),
          ],
          child: Column(
            children: [
              const HomePageTitleBar(),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: LeftHomePanel(
                        onCreateProfile: () {
                          setState(() {
                            currentRightPanelType =
                                RightPanelType.pieMenuEditor;
                          });
                        },
                      ),
                    ),
                    Expanded(flex: 7, child: getRightPanel()),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  getRightPanel() {
    switch (currentRightPanelType) {
      case RightPanelType.pieMenuEditor:
        return const RightCreateProfilePanel();
      case RightPanelType.home:
        return RightHomePanel();
      default:
    }
  }
}
