import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pie_menyu_editor/system/file_icon.dart';
import 'package:pie_menyu_editor/system/task_bar_process_info/process_list_tile.dart';
import 'package:pie_menyu_editor/system/task_bar_process_info/gui_process.dart';
import 'package:provider/provider.dart';

import '../home_page_view_model.dart';

class CreateProfilePanel extends StatefulWidget {
  const CreateProfilePanel({super.key});

  @override
  State<CreateProfilePanel> createState() =>
      _CreateProfilePanelState();
}

class _CreateProfilePanelState extends State<CreateProfilePanel> {
  Set<GUIProcess> activeApps = {
    GUIProcess(
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
    activeApps = GUIProcess.enumerateWindows();
    for (GUIProcess app in activeApps) {
      FileIcon.getBase64(app.exePath).then((value) {
        app.base64Icon = value;

        if (mounted) setState(() {});
      });
    }
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
                for (GUIProcess activeApp in activeApps)
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

  tryCreateProfile(GUIProcess info) {
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
