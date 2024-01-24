import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu/hotkey/key_event_notifier.dart';
import 'package:pie_menyu/screens/pie_menu_screen/pie_menu_state_provider.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import 'foreground_window.dart';

class PieMenyuWindowManager {
  static PieMenyuWindowManager? instance;

  Database _db;
  PieMenuStateProvider _pieMenuStateProvider;
  SystemKeyEvent _keyEventNotifier;

  PieMenyuWindowManager._(
    this._db,
    this._pieMenuStateProvider,
    this._keyEventNotifier,
  ) {
    _keyEventNotifier.addKeyUpListener((hotKey) {
      hide();
      return true;
    });
    _keyEventNotifier.addKeyDownListener((hotKey) {
      _tryShow(hotKey);
      return true;
    });

  }

  factory PieMenyuWindowManager(
    Database db,
    PieMenuStateProvider pieMenuStateProvider,
    SystemKeyEvent keyUpNotifier,
  ) {
    instance ??= PieMenyuWindowManager._(
      db,
      pieMenuStateProvider,
      keyUpNotifier,
    );
    return instance!;
  }

  initialize() async {
    windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      backgroundColor: Colors.transparent,
      skipTaskbar: true,
      titleBarStyle: TitleBarStyle.hidden,
      alwaysOnTop: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setAsFrameless();
      await windowManager.hide();
      await windowManager.blur();
    });

    log("Window manager initialized");
  }

  _tryShow(HotKey hotkey) async {
    Profile? profile = await _db.getProfileByExe(ForegroundWindow().path);
    profile ??= (await _db.getProfiles(ids: [1])).first;
    final pieMenu = await _getHotkeyPieMenuIn(profile, hotkey);

    if (pieMenu == null) return;

    final pieMenuState = PieMenuState(_db, pieMenu);
    _pieMenuStateProvider.replaceStates([pieMenuState]);
    _pieMenuStateProvider.pieMenuPositions[pieMenuState] = await getRelativeCursorScreenPoint();

    windowManager.setBounds((await getCurrentDisplayBounds()).deflate(1));
    windowManager.show();
  }

  Future<void> hide() async {
    await windowManager.hide();
  }

  // Modified from calcWindowPosition
  Future<Rect> getCurrentDisplayBounds() async {
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

  Future<PieMenu?> _getHotkeyPieMenuIn(Profile profile, HotKey hotkey) async {
    int? pieMenuId = profile.hotkeyToPieMenuIdList
        .where(
          (htpm) =>
              htpm.keyCode == hotkey.keyCode &&
              htpm.keyModifiers.every(
                  (element) => hotkey.modifiers?.contains(element) ?? false),
        )
        .firstOrNull
        ?.pieMenuId;

    if (pieMenuId == null) return null;

    return (await _db.getPieMenus(ids: [pieMenuId])).firstOrNull;
  }

  Future<Offset> getRelativeCursorScreenPoint() async {
    Offset cursorPos = await screenRetriever.getCursorScreenPoint();
    Rect screenBounds = await getCurrentDisplayBounds();

    return Offset(
      cursorPos.dx - screenBounds.left,
      cursorPos.dy - screenBounds.top,
    );
  }
}
