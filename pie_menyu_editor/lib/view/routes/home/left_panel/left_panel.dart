import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pie_menyu_editor/flutter/navigator.dart';
import 'package:pie_menyu_editor/versioning/update_provider.dart';
import 'package:pie_menyu_editor/view/routes/home/left_panel/create_profile_button.dart';
import 'package:pie_menyu_editor/view/routes/home/left_panel/profile_list_view.dart';
import 'package:pie_menyu_editor/view/widgets/notification/notification.dart';
import 'package:pie_menyu_editor/view/widgets/notification/notification_badge.dart';
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
  void initState() {
    super.initState();
    checkForUpdate();
  }

  void checkForUpdate() async {
    final hasUpdate = await context.read<UpdateProvider>().fetchUpdate();

    if (hasUpdate && mounted) {
      final homePageViewModel = context.read<HomePageViewModel>();

      final updatingNotification = NotificationDelegate(
        message: "tooltip-updating".tr(),
        icon: const Icon(Icons.file_download_outlined, size: 16),
        onPressed: () {},
        type: NotificationType.warning,
        curve: Curves.easeInOut,
      );

      homePageViewModel.addNotification(
        NotificationDelegate(
          message: "tooltip-update-available".tr(),
          onPressed: () {
            context.read<UpdateProvider>().update();
            homePageViewModel.dismissNotification();
            homePageViewModel.addNotification(updatingNotification,
                urgent: true);
          },
          icon: const Text("!"),
          type: NotificationType.warning,
          curve: null,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final homePageViewModel = context.read<HomePageViewModel>();

    final nextNotification =
        context.select<HomePageViewModel, NotificationDelegate?>(
      (value) => value.firstNotification,
    );

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
              CreateProfileButton(),
            ],
          ),
          const Gap(20),
          const Expanded(
            child: ProfileListView(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (nextNotification != null) ...[
                NotificationBadge(notification: nextNotification),
                const Gap(10),
              ],
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
