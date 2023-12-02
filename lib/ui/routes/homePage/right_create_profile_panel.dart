import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/active_windows/active_windows.dart';
import 'package:pie_menyu/active_windows/window_info.dart';

import '../../widgets/app_info_card.dart';

class RightCreateProfilePanel extends StatefulWidget {
  const RightCreateProfilePanel({super.key});

  @override
  State<RightCreateProfilePanel> createState() =>
      _RightCreateProfilePanelState();
}

class _RightCreateProfilePanelState extends State<RightCreateProfilePanel> {
  List<WindowInfo> activeApps = [];

  @override
  void initState() {
    super.initState();
    setActiveWindow();
  }

  setActiveWindow() async {
    List<WindowInfo> tempWinInfoList = await ActiveWindows().getOpenedWindows();
    setState(() {
      activeApps = tempWinInfoList;
    });
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
            child: SingleChildScrollView(
              child: Wrap(children: [
                for (WindowInfo activeApp in activeApps)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InfoCardWithIcon(
                      onPressed: () {},
                      title: activeApp.name,
                      description: '',
                      icon: FontAwesomeIcons.font,
                    ),
                  )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
