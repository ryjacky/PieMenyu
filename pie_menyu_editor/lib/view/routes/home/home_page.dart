import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:provider/provider.dart';

import '../settings/settings_page.dart';
import 'home_page_view_model.dart';
import 'right_create_profile_panel.dart';
import 'home_page_titlebar.dart';
import 'left_home_panel.dart';
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
  Profile selectedProfile = Profile(
    name: "Loading...",
  );
  List<PieMenu> selectedProfilePieMenus = [];
  RightPanelType currentRightPanelType = RightPanelType.home;

  updateSelectedProfile(profileId) async {
    log("Fetching profile and its pie menus...");

    List<Profile> tempProfileList = await DB.getProfiles(ids: [profileId]);
    await tempProfileList.first.pieMenus.load();

    if (tempProfileList.isEmpty) {
      log("Profile not found, id: $profileId");
      return;
    }

    setState(() {
      currentRightPanelType = RightPanelType.home;
      selectedProfilePieMenus = tempProfileList.first.pieMenus.toList();
      selectedProfile = tempProfileList.first;
      log("RightHomePanel state updated");
    });
  }

  @override
  void initState() {
    super.initState();
    updateSelectedProfile(1);
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
                        onSettingPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            ),
                          );
                        },
                        onCreateProfile: () {
                          setState(() {
                            currentRightPanelType =
                                RightPanelType.pieMenuEditor;
                          });
                        },
                        onProfileSelected: updateSelectedProfile,
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
        return RightHomePanel(profile: selectedProfile);
      default:
    }
  }
}
