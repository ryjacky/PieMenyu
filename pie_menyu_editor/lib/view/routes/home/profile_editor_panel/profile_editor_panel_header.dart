import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_editor/view/widgets/flat_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_page_view_model.dart';

class ProfileEditorPanelHeader extends StatefulWidget {
  const ProfileEditorPanelHeader({super.key});

  @override
  State<ProfileEditorPanelHeader> createState() =>
      _ProfileEditorPanelHeaderState();
}

class _ProfileEditorPanelHeaderState extends State<ProfileEditorPanelHeader> {
  @override
  Widget build(BuildContext context) {
    final homePageViewModel = context.read<HomePageViewModel>();
    final activeProfile = context
        .select<HomePageViewModel, Profile>((value) => value.activeProfile);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          activeProfile.name,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Expanded(child: Container()),
        IconButton(
          onPressed: () async {
            bool result = await homePageViewModel.toggleActiveProfile();
            if (!context.mounted) return;
            setState(() {});
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                content: Text((result
                        ? "message-profile-enabled"
                        : "message-profile-disabled")
                    .tr())));

            launchUrl(Uri.parse("piemenyu://reload"));
          },
          icon: Icon(
            activeProfile.enabled ? Icons.pause : Icons.play_arrow_outlined,
            size: 22,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FlatButton(
            onPressed: () => homePageViewModel.createPieMenuIn(activeProfile),
            icon: FontAwesomeIcons.plus,
            label: Text("button-new-pie-menu".tr()),
          ),
        )
      ],
    );
  }
}
