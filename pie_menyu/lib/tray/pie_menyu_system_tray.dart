import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:global_hotkey/global_hotkey.dart';
import 'package:system_tray/system_tray.dart';
import 'package:url_launcher/url_launcher.dart';

class PieMenyuSystemTray {
  static initialize() async {
    final AppWindow appWindow = AppWindow();
    final SystemTray systemTray = SystemTray();

    // We first init the systray menu
    await systemTray.initSystemTray(
      title: "PieMenyu",
      iconPath: Platform.isWindows ? 'assets/icon.ico' : 'assets/icon.png',
    );

    // create context menu
    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLabel(
          label: 'Hide',
          onClicked: (menuItem) {
            launchUrl(Uri.parse("piemenyueditor://close"));
            appWindow.hide();
          }),
      MenuItemLabel(
          label: 'Exit',
          onClicked: (menuItem) async {
            try {
              GlobalHotkey.instance.dispose();
            } catch (e) {
              log("Failed to dispose hotkey: $e");
            }
            exit(0);
          }),
    ]);

    // set context menu
    await systemTray.setContextMenu(menu);

    // handle system tray event, break is not needed for dart
    systemTray.registerSystemTrayEventHandler((eventName) {
      switch (eventName) {
        case kSystemTrayEventClick:
          if (!Platform.isWindows) {
            systemTray.popUpContextMenu();
          }
        case kSystemTrayEventRightClick:
          Platform.isWindows ? systemTray.popUpContextMenu() : appWindow.show();
        case kSystemTrayEventDoubleClick:
          if (Platform.isWindows) launchUrl(Uri.parse("piemenyueditor://"));
          break;
      }
    });
  }
}
