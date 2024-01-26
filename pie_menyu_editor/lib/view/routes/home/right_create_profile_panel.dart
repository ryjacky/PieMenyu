import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pie_menyu_editor/system/task_bar_process_info/process_list_tile.dart';
import 'package:pie_menyu_editor/system/task_bar_process_info/task_bar_process_info.dart';
import 'package:provider/provider.dart';

import 'home_page_view_model.dart';

class RightCreateProfilePanel extends StatefulWidget {
  const RightCreateProfilePanel({super.key});

  @override
  State<RightCreateProfilePanel> createState() =>
      _RightCreateProfilePanelState();
}

class _RightCreateProfilePanelState extends State<RightCreateProfilePanel> {
  Set<TaskBarProcessInfo> activeApps = {
    TaskBarProcessInfo(
        processName: "label-loading".tr(),
        exePath: "label-loading".tr(),
        base64Icon: "",
        mainWindowTitle: "label-loading".tr())
  };

  String filterText = "";

  @override
  void initState() {
    super.initState();
    setActiveWindow();
  }

  setActiveWindow() async {
    activeApps = await TaskBarProcessInfo.getAllUnique();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  "label-create-profile".tr(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "label-search".tr(),
            ),
            onChanged: (String text) => setState(() => filterText = text),
          ),
          const Gap(10),
          Expanded(
            child: ListView(
              children: [
                for (TaskBarProcessInfo activeApp in activeApps)
                  if (activeApp.processName.contains(filterText) ||
                      activeApp.exePath.contains(filterText))
                    ProcessListTile(
                      key: ValueKey(activeApp),
                      processInfo: activeApp,
                      onTap: (info) => tryCreateProfile(info),
                    )
              ],
            ),
          )
        ],
      ),
    );
  }

  tryCreateProfile(TaskBarProcessInfo info) {
    context
        .read<HomePageViewModel>()
        .createProfile(info.processName, info.exePath, info.base64Icon)
        .onError(
          (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error,
              content: Text(error.toString()),
            ),
          ),
        );
  }
}
