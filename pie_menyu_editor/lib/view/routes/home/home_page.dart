import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_menyu_editor/view/widgets/title_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_page_view_model.dart';
import 'left_panel/left_panel.dart';
import 'profile_editor_panel/profile_editor_panel.dart';
import 'right_panels/create_profile_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool pieMenyuStatus = context.select<HomePageViewModel, bool>((value) => value.pieMenyuStatus);

    return Column(
      children: [
        TitleBar(trailing: Row(
          // Should align to center vertically, but CrossAxisAlignment.start
          // "looks" more centered
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "label-pie-menyu-status".tr(),
              style: const TextStyle(color: Colors.grey),
            ),
            Transform.scale(
              scale: 0.6,
              child: Switch(
                value: pieMenyuStatus,
                onChanged: (bool value) {
                  context.read<HomePageViewModel>().pieMenyuStatus = value;
                  launchUrl(Uri.parse(
                      "piemenyu://${value ? "start" : "stop"}"));
                },
              ),
            ),
          ],
        ),),
        Expanded(
          child: Row(
            children: [
              const Expanded(flex: 3, child: LeftPanel()),
              Expanded(
                flex: 7,
                child: createRightPanel(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget createRightPanel(BuildContext context) {
    final creatingProfile = context
        .select<HomePageViewModel, bool>((value) => value.creatingProfile);
    final draggingPieMenu = context
        .select<HomePageViewModel, bool>((value) => value.draggingPieMenu);

    return creatingProfile
        ? const CreateProfilePanel()
        : Stack(
            alignment: Alignment.bottomLeft,
            children: [
              const ProfileEditorPanel(),
              if (draggingPieMenu)
                Container(color: Colors.black.withOpacity(0.5)),
              if (draggingPieMenu)
                Positioned(
                  left: 250,
                  bottom: 265,
                  child: SizedBox(
                    width: 250,
                    child: Text(
                      "label-drag-to-pie-menu-hint".tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              if (draggingPieMenu)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    'assets/images/pie_guy_pointing_left.svg',
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
            ],
          );
  }
}
