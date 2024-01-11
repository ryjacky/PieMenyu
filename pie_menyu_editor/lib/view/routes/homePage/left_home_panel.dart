import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_editor/view/routes/homePage/home_page_view_model.dart';
import 'package:pie_menyu_editor/view/widgets/PrimaryButton.dart';
import 'package:pie_menyu_editor/view/widgets/profile_list_item.dart';
import 'package:provider/provider.dart';

class LeftHomePanel extends StatefulWidget {
  final VoidCallback onCreateProfile;
  final Function(int profileId) onProfileSelected;
  final Function()? onSettingPressed;

  const LeftHomePanel(
      {super.key,
      required this.onCreateProfile,
      required this.onProfileSelected,
      this.onSettingPressed});

  @override
  State<LeftHomePanel> createState() => _LeftHomePanelState();
}

class _LeftHomePanelState extends State<LeftHomePanel> {
  int iProfileSelected = 0;

  @override
  Widget build(BuildContext context) {
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
                      if (pieMenuId == null) {
                        return;
                      }

                      await DB.addPieMenuToProfile(
                          pieMenuId, profiles[index].id);
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
              TextButton(
                  onPressed: () {
                    widget.onSettingPressed?.call();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    minimumSize: const Size(0, 0),
                  ),
                  child: const FaIcon(FontAwesomeIcons.gear))
            ],
          )
        ],
      ),
    );
  }
}
