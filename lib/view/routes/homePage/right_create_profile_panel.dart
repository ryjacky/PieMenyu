import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/system/task_bar_process_info.dart';

class RightCreateProfilePanel extends StatefulWidget {
  const RightCreateProfilePanel({super.key});

  @override
  State<RightCreateProfilePanel> createState() =>
      _RightCreateProfilePanelState();
}

class _RightCreateProfilePanelState extends State<RightCreateProfilePanel> {
  Set<TaskBarProcessInfo> activeApps = {
    TaskBarProcessInfo(
        processName: "label-loading".i18n(),
        exePath: "label-loading".i18n(),
        base64Icon: "",
        mainWindowTitle: "label-loading".i18n())
  };

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
                  "label-create-profile".i18n(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "label-search".i18n(),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              for (TaskBarProcessInfo activeApp in activeApps)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: ListTile(
                      title: Text(activeApp.processName),
                      subtitle: Text(activeApp.exePath),
                      leading: Image.memory(
                        base64Decode(activeApp.base64Icon),
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(FontAwesomeIcons.question,
                              size: 32);
                        },
                      ),
                      onTap: () {
                        print(activeApp.processName);
                      },
                    ),
                  ),
                )
            ],
          ))
        ],
      ),
    );
  }
}
