import 'dart:developer' as dev;
import 'dart:ui';

import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_core/providers/pie_menu_provider.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import '../system/keyboard/keyboard_event.dart';
import '../system/keyboard/keyboard_provider.dart';

class WindowController {
  static Size windowSize = const Size(1024, 1024);

  final keyboardProvider = KeyboardProvider();
  final pieMenuProvider = PieMenuProvider();


  WindowController() {
    keyboardProvider.addListener(() {
      if (keyboardProvider.keyEvent.type == KeyboardEventType.keyDown) {
        showWindow(keyboardProvider.keyEvent.hotkey!);
      }
      if (keyboardProvider.keyEvent.type == KeyboardEventType.keyUp) {
        hideWindow();
      }
    });
  }

  void hideWindow() async {
    await windowManager.hide();
  }

  void showWindow(HotKey hotKey) async {
    if (await windowManager.isFocused()) {
      return;
    }

    String foregroundApp = await getForegroundApp();

    List<Profile> profilesOfForegroundApp =
        await DB.getProfilesByExe(foregroundApp);
    Profile? profile = profilesOfForegroundApp.firstOrNull;
    profile ??= (await DB.getProfiles(ids: [1])).firstOrNull;

    if (profile == null) {
      throw Exception("Database possibly corrupted");
    }

    for (HotkeyToPieMenuId hotkeyToPieMenuId in profile.hotkeyToPieMenuIdList) {
      if (hotkeyToPieMenuId.keyCode == hotKey.keyCode) {
        try {
          pieMenuProvider.pieMenu = profile.pieMenus.firstWhere(
              (element) => element.id == hotkeyToPieMenuId.pieMenuId);
          pieMenuProvider.loadPieItems();

          final pieCenterScreenPosition = await screenRetriever.getCursorScreenPoint();
          await windowManager.setPosition(Offset(
              pieCenterScreenPosition.dx - windowSize.width / 2,
              pieCenterScreenPosition.dy - windowSize.height / 2));
          await windowManager.show();
          await windowManager.focus();

          pieMenuProvider.pieCenterScreenPosition = pieCenterScreenPosition;
        } catch (e) {
          dev.log(
              "Pie menu does not exist in profile, id: ${hotkeyToPieMenuId.pieMenuId}");
        }
      }
    }
  }

  String getForegroundApp() {
    return "";
  }
}
