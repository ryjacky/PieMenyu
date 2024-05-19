import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_editor/view/routes/home/left_panel/profile_list_item.dart';
import 'package:provider/provider.dart';

import '../home_page_view_model.dart';

class ProfileListView extends StatefulWidget {
  const ProfileListView({super.key});

  @override
  State<ProfileListView> createState() => _ProfileListViewState();
}

class _ProfileListViewState extends State<ProfileListView> {
  @override
  Widget build(BuildContext context) {
    final homePageViewModel = context.read<HomePageViewModel>();
    final profiles = context
        .select<HomePageViewModel, List<Profile>>((value) => value.profiles);

    return ListView(
      children: [
        for (final profile in profiles)
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: DragTarget(
              onAccept: (int? pieMenuId) async {
                final pieMenu = homePageViewModel.pieMenus
                    .where((element) => element.id == pieMenuId)
                    .firstOrNull;

                if (pieMenu == null) {
                  return;
                }

                homePageViewModel.activeProfile = profile;
                await homePageViewModel.addPieMenuTo(profile, pieMenu);
              },
              builder: (_, __, ___) {
                return ProfileListItem(
                  profile: profile,
                  onPressed: () => homePageViewModel.activeProfile = profile,
                );
              },
            ),
          )
      ],
    );
  }
}
