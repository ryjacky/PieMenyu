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
  Map<int, int> selectedProfilePieMenuLinkedCounts = {};

  updateSelectedProfile(profileId) async {
    if (isCreatingProfile) {
      setState(() {
        isCreatingProfile = false;
      });
    }

    log("Fetching profile and its pie menus...");

    List<dynamic> result = await Future.wait([
      DB.getProfiles(ids: [profileId]),
      DB.getProfilePieMenuIds(profileId),
    ]);

    List<Profile> tempProfileList = result[0];
    List<int> tempProfilePieMenuIds = result[1];

    if (tempProfileList.isEmpty) {
      log("Profile not found, id: $profileId");
      return;
    }

    List<int> countList = await Future.wait(
        tempProfilePieMenuIds.map((pieMenuId) => DB.getPieMenuLinkedCount(pieMenuId)));
    Map<int, int> tempSelectedProfilePieMenuLinkedCounts = {};
    for (int i = 0; i < tempProfilePieMenuIds.length; i++) {
      tempSelectedProfilePieMenuLinkedCounts[tempProfilePieMenuIds[i]] = countList[i];
    }

    List<PieMenu> tempProfilePieMenus = await DB.getPieMenus(ids: tempProfilePieMenuIds);

    setState(() {
      selectedProfilePieMenuLinkedCounts = tempSelectedProfilePieMenuLinkedCounts;
      selectedProfilePieMenus = tempProfilePieMenus;
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
                          ? RightCreateProfilePanel()
                          : RightHomePanel(
                              pieMenuLinkedCounts: selectedProfilePieMenuLinkedCounts,
                              profile: selectedProfile,
                              pieMenus: selectedProfilePieMenus,
                            )),
                ],
              ),
            ),
          ],
        ));
  }
}
