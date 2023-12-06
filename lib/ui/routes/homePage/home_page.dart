import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pie_menyu/db/db.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/db/profile.dart';
import 'package:pie_menyu/ui/routes/homePage/right_create_profile_panel.dart';

import '../../widgets/HomePageTitleBar.dart';
import 'left_home_panel.dart';
import 'right_home_panel.dart';

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
  bool isCreatingProfile = false;

  updateSelectedProfile(profileId) async {
    log("Fetching profile and its pie menus...");

    List<Profile> tempProfileList = await DB.getProfiles(ids: [profileId]);
    await tempProfileList.first.pieMenus.load();

    if (tempProfileList.isEmpty) {
      log("Profile not found, id: $profileId");
      return;
    }

    setState(() {
      isCreatingProfile = false;
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
        body: Column(
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
                            isCreatingProfile = true;
                          });
                        },
                        onProfileSelected: updateSelectedProfile,
                      )),
                  Expanded(
                      flex: 7,
                      child: isCreatingProfile
                          ? const RightCreateProfilePanel()
                          : RightHomePanel(
                              onEditPieMenu: (a) {},
                              profile: selectedProfile,
                            )),
                ],
              ),
            ),
          ],
        ));
  }
}
