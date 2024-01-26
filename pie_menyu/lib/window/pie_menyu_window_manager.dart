import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
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

/// A function that takes a [MouseEvent] and returns a [bool].
/// If the function returns `false`, the [MouseEvent] will not be propagated to other listeners.
typedef MouseEventListener = Function(PointerEvent event);

class PieMenyuWindow {
  static PieMenyuWindow? instance;

  Database _db;
  PieMenuStateProvider _pieMenuStateProvider;
  SystemKeyEvent _keyEventNotifier;

  final List<MouseEventListener> _mouseEventListener = [];

  addMouseEventListener(MouseEventListener listener) {
    _mouseEventListener.add(listener);
  }

  removeMouseEventListener(MouseEventListener listener) {
    _mouseEventListener.remove(listener);
  }

  PieMenyuWindow._(
    this._db,
    this._pieMenuStateProvider,
    this._keyEventNotifier,
  ) {
    _keyEventNotifier.addKeyDownListener((hotKey) {
      _tryShow(hotKey);
      return true;
    });

    MouseEventPlugin.startListening((mouseEvent) async {
      if (!await windowManager.isFocused()) return;

      for (final listener in _mouseEventListener) {
        final Offset pos = await getRelativeCursorScreenPoint(
          position: Offset(mouseEvent.x.toDouble(), mouseEvent.y.toDouble()),
        );

        PointerEvent event = PointerMoveEvent(position: pos);
        listener(event);
      }
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

  _tryShow(HotKey hotkey) async {
    Profile? profile = await _db.getProfileByExe(ForegroundWindow().path);
    profile ??= (await _db.getProfiles(ids: [1])).first;

    final pieMenu = await _getHotkeyPieMenuIn(profile, hotkey);
    if (pieMenu == null) return;

    final pieMenuState = PieMenuState(_db, pieMenu);
    _pieMenuStateProvider.replaceStates([pieMenuState]);
    _pieMenuStateProvider.pieMenuPositions[pieMenuState] =
        await getRelativeCursorScreenPoint();

    await windowManager.setBounds((await getCurrentDisplayBounds()).deflate(1));
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setAlwaysOnTop(true);
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

  Future<Offset> getRelativeCursorScreenPoint({Offset? position}) async {
    position ??= await screenRetriever.getCursorScreenPoint();
    Rect screenBounds = await getCurrentDisplayBounds();

    return Offset(
      position.dx - screenBounds.left,
      position.dy - screenBounds.top,
    );
  }
}
