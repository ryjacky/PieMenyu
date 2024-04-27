import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pie_menyu_editor/flutter/navigator.dart';
import 'package:pie_menyu_editor/view/routes/home/left_panel/create_profile_button.dart';
import 'package:pie_menyu_editor/view/routes/home/left_panel/profile_list_view.dart';
import 'package:provider/provider.dart';

import '../../settings_page/settings_page.dart';
import '../home_page_view_model.dart';

class LeftPanel extends StatefulWidget {
  const LeftPanel({super.key});

  @override
  State<LeftPanel> createState() => _LeftPanelState();
}

class _LeftPanelState extends State<LeftPanel> {
  @override
  Widget build(BuildContext context) {
    final homePageViewModel = context.read<HomePageViewModel>();

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "title-profiles".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const CreateProfileButton(),
            ],
          ),
          const Gap(20),
          const Expanded(
            child: ProfileListView(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.of(context).pushAndClearSnackBar(
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );

                  // Update home page after settings page is closed. (e.g. import data)
                  homePageViewModel.updateState();
                },
                label: Text("button-settings".tr()),
                icon: const FaIcon(Icons.settings, size: 24),
              )
            ],
          )
        ],
      ),
    );
  }
}
