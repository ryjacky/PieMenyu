import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/db.dart';
import 'package:pie_menyu/db/profile.dart';
import 'package:pie_menyu/ui/widgets/PrimaryButton.dart';
import 'package:pie_menyu/ui/widgets/profile_list_item.dart';

class LeftHomePanel extends StatefulWidget {
  final VoidCallback onCreateProfile;
  final Function(int profileId) onProfileSelected;

  const LeftHomePanel(
      {super.key,
      required this.onCreateProfile,
      required this.onProfileSelected});

  @override
  State<LeftHomePanel> createState() => _LeftHomePanelState();
}

class _LeftHomePanelState extends State<LeftHomePanel> {
  List<Profile> profiles = [];
  int iProfileSelected = 0;

  fetchState() async {
    log("Fetching state...");

    List<Profile> tempProfiles = await DB.getProfiles();
    log("There is ${tempProfiles.length} profiles");

    setState(() {
      profiles = tempProfiles;

      log("LeftHomePanel state updated");
    });
  }

  @override
  void initState() {
    super.initState();
    fetchState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "title-profiles".i18n(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                PrimaryButton(
                    onPressed: () {
                      widget.onCreateProfile();
                      iProfileSelected = -1;
                    },
                    icon: FontAwesomeIcons.plus,
                    label: Text("button-create".i18n()))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: DragTarget(
                    onAccept: (int? pieMenuId) {
                      if (pieMenuId == null) {
                        return;
                      }

                      DB.addPieMenuToProfile(pieMenuId, profiles[index].id);
                    },
                    builder: (context, List<int?> candidateData, rejectedData) {
                      return ProfileListItem(
                        profile: profiles[index],
                        active: iProfileSelected == index,
                        onPressed: () {
                          widget.onProfileSelected(profiles[index].id);
                          iProfileSelected = index;
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
