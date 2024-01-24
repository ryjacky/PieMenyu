import 'dart:io';
import 'dart:ui';

import 'package:system_tray/system_tray.dart';

class PieMenyuSystemTray {
  static final List<VoidCallback> _onExitCallbacks = [];

  static addOnExitCallback(VoidCallback callback) {
    _onExitCallbacks.add(callback);
  }

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
      MenuItemLabel(label: 'Hide', onClicked: (menuItem) => appWindow.hide()),
      MenuItemLabel(label: 'Exit', onClicked: (menuItem) {
        for (var callback in _onExitCallbacks) {
          callback();
        }
        exit(0);
      }),
    ]);

    // set context menu
    await systemTray.setContextMenu(menu);

    // handle system tray event, break is not needed for dart
    systemTray.registerSystemTrayEventHandler((eventName) {
      switch (eventName){
        case kSystemTrayEventClick:
          if (!Platform.isWindows) {
            systemTray.popUpContextMenu();
          }
        case kSystemTrayEventRightClick:
          Platform.isWindows ? systemTray.popUpContextMenu() : appWindow.show();
        case kSystemTrayEventDoubleClick:
          break;
      }
    });
  }

}