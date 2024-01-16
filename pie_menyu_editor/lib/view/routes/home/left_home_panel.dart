import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_editor/view/widgets/PrimaryButton.dart';
import 'package:pie_menyu_editor/view/widgets/profile_list_item.dart';
import 'package:provider/provider.dart';

import '../settings/settings_page.dart';
import 'home_page_view_model.dart';

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
  int iProfileSelected = 0;

  @override
  Widget build(BuildContext context) {
    final homePageViewModel = context.read<HomePageViewModel>();
    final profiles = context
        .select<HomePageViewModel, List<Profile>>((value) => value.profiles);

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
                    onAccept: (int? pieMenuId) async {
                      final pieMenu = homePageViewModel.pieMenus
                          .where((element) => element.id == pieMenuId)
                          .firstOrNull;

                      if (pieMenu == null) {
                        return;
                      }

                      await homePageViewModel.addPieMenuTo(
                          profiles[index], pieMenu);
                      widget.onProfileSelected(profiles[iProfileSelected].id);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                  homePageViewModel.updateState();
                },
                label: Text("button-settings".i18n()),
                icon: const FaIcon(
                  Icons.settings,
                  size: 24,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
