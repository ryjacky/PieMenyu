import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
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
  bool keyUpRegistered = false;

  PieMenyuWindowManager._(this._db, this._pieMenuStateProvider);

  factory PieMenyuWindowManager(
      Database db, PieMenuStateProvider pieMenuStateProvider) {
    instance ??= PieMenyuWindowManager._(db, pieMenuStateProvider);
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

    await _unregisterHotkey();
    await _registerHotkey();

    log("Window manager initialized");
  }


  Future<void> _unregisterHotkey() async {
    await hotKeyManager.unregisterAll();
  }

  _registerHotkey() async {
    final hotkeys = await _db.getAllHotkeys();
    for (HotKey hotkey in hotkeys) {
      hotKeyManager.register(
        hotkey..scope = HotKeyScope.system,
        keyDownHandler: _onKeyDown,
        keyUpHandler: _onKeyUp,
      );
    }

    if (Platform.isWindows && !keyUpRegistered) {
      keyUpRegistered = true;
      RawKeyboard.instance.addListener((event) {
        if (event is RawKeyUpEvent) {
          _onKeyUp(HotKey(KeyCode.space));
        }
      });
    }

    log("Hotkeys registered");
  }

  _onKeyDown(HotKey hotkey) async {
    log("Hotkey pressed: $hotkey");
    Profile? profile = await _db.getProfileByExe(ForegroundWindow().path);
    profile ??= (await _db.getProfiles(ids: [1])).first;
    final pieMenu = await _getHotkeyPieMenuIn(profile, hotkey);

    if (pieMenu == null) return;

    final pieMenuState = PieMenuState(_db, pieMenu);
    _pieMenuStateProvider.replaceStates([pieMenuState]);
    _pieMenuStateProvider.pieMenuPositions[pieMenuState] = await screenRetriever.getCursorScreenPoint();

    windowManager.setBounds((await getCurrentDisplayBounds()).deflate(1));
    windowManager.show();
    await _unregisterHotkey();
  }

  /// On Windows platform hotkey is always HotKey(KeyCode.space)
  _onKeyUp(HotKey hotkey) async {
    log("Hotkey released: $hotkey");

    await windowManager.hide();
    _registerHotkey();
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


}
