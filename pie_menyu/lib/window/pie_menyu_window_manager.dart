import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_hotkey/hotkey.dart';
import 'package:mouse_event/mouse_event.dart';
import 'package:pie_menyu/hotkey/system_key_event.dart';
import 'package:pie_menyu/screens/pie_menu_screen/pie_menu_state_provider.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import 'foreground_window.dart';

class PieMenyuWindow {
  static PieMenyuWindow? instance;

  Database _db;
  PieMenuStateProvider _pieMenuStateProvider;
  SystemKeyEvent _keyEventNotifier;

  PieMenyuWindow._(
    this._db,
    this._pieMenuStateProvider,
    this._keyEventNotifier,
  ) {
    _keyEventNotifier.addKeyDownListener((hotKey) {
      _tryShow(hotKey);
      return true;
    });
  }

  factory PieMenyuWindow(
    Database db,
    PieMenuStateProvider pieMenuStateProvider,
    SystemKeyEvent keyUpNotifier,
  ) {
    instance ??= PieMenyuWindow._(
      db,
      pieMenuStateProvider,
      keyUpNotifier,
    );
    return instance!;
  }

  initialize() async {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      backgroundColor: Colors.transparent,
      skipTaskbar: true,
      titleBarStyle: TitleBarStyle.hidden,
      alwaysOnTop: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.setAsFrameless();
      await Future.delayed(const Duration(milliseconds: 100));
      await hide();
    });

    log("Window manager initialized");
  }

  _tryShow(Hotkey hotkey) async {
    List<Profile?> profiles = [
      await _db.getProfileByExe(ForegroundWindow().path),
      (await _db.getProfiles(ids: [1])).firstOrNull
    ];

    for (Profile profile in profiles.whereType<Profile>()) {
      final pieMenu = await _getHotkeyPieMenuIn(profile, hotkey);
      if (pieMenu == null) continue;

      final pieMenuState = PieMenuState.fromPieMenu(_db, pieMenu);
      _pieMenuStateProvider.replaceStates([pieMenuState]);

      await windowManager.setBounds((await getCurrentDisplayBounds()).deflate(1));
      await windowManager.show();

      return;
    }
  }

  Future<void> hide() async {
    await windowManager.hide();
  }

  // Modified from calcWindowPosition
  static Future<Rect> getCurrentDisplayBounds() async {
    Display primaryDisplay = await screenRetriever.getPrimaryDisplay();
    List<Display> allDisplays = await screenRetriever.getAllDisplays();
    Offset cursorScreenPoint = await screenRetriever.getCursorScreenPoint();

    Display currentDisplay = allDisplays.firstWhere(
      (display) => Rect.fromLTWH(
        display.visiblePosition!.dx,
        display.visiblePosition!.dy,
        display.size.width,
        display.size.height,
      ).contains(cursorScreenPoint),
      orElse: () => primaryDisplay,
    );

    return Rect.fromLTWH(
        currentDisplay.visiblePosition!.dx,
        currentDisplay.visiblePosition!.dy,
        currentDisplay.size.width,
        currentDisplay.size.height);
  }

  Future<PieMenu?> _getHotkeyPieMenuIn(Profile profile, Hotkey hotkey) async {
    int? pieMenuId = profile.pieMenuHotkeys
        .where((pieMenuHotkey) {
          return hotkey.keySet.keys.contains(LogicalKeyboardKey(pieMenuHotkey.keyId!)) &&
              pieMenuHotkey.ctrl ==
                  hotkey.keySet.keys.contains(LogicalKeyboardKey.control) &&
              pieMenuHotkey.shift ==
                  hotkey.keySet.keys.contains(LogicalKeyboardKey.shift) &&
              pieMenuHotkey.alt ==
                  hotkey.keySet.keys.contains(LogicalKeyboardKey.alt);
        })
        .firstOrNull
        ?.pieMenuId;

    if (pieMenuId == null) return null;

    return (await _db.getPieMenus(ids: [pieMenuId])).firstOrNull;
  }

  static Future<Offset> getRelativeCursorScreenPoint({Offset? position}) async {
    position ??= await screenRetriever.getCursorScreenPoint();
    Rect screenBounds = await getCurrentDisplayBounds();

    return Offset(
      position.dx - screenBounds.left,
      position.dy - screenBounds.top,
    );
  }
}
