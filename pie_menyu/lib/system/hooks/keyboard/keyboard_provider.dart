import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:window_manager/window_manager.dart';

import '../../window/foreground_window_event.dart';
import 'keyboard_event.dart';
import 'keyboard_hook.dart';

class KeyboardProvider extends ChangeNotifier {
  KeyboardEvent _event = KeyboardEvent(KeyboardEventType.keyUp, 0);

  KeyboardHookIsolate? _keyboardHookIsolate;

  KeyboardProvider() {
    setKeyDownHook().then((value) => initializeKeyboardHook());
    ForegroundWindowEvent().start();
    ForegroundWindowEvent().addListener((exePath) {
      if (exePath.contains("pie_menyu_editor.exe")) {
        hotKeyManager.unregisterAll();
      } else {
        setKeyDownHook(exePath: exePath);
      }
    });
  }

  get keyEvent => _event;

  void initializeKeyboardHook() async {
    _keyboardHookIsolate =
        KeyboardHookIsolate(hotKeyManager.registeredHotKeyList);
    _keyboardHookIsolate!.addKeyUpListener((int vkCode) async {
      if (await windowManager.isFocused()) {
        _event = KeyboardEvent(KeyboardEventType.keyUp, vkCode);
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> setKeyDownHook({String exePath = ""}) async {
    await hotKeyManager.unregisterAll();

    List<Profile> profiles = [
      await DB.getProfileByExe(exePath),
      (await DB.getProfiles(ids: [1])).firstOrNull
    ].whereType<Profile>().toList();

    for (var profile in profiles) {
      for (var hotkeyToPieMenuId in profile.hotkeyToPieMenuIdList) {
        await hotKeyManager.register(
          HotKey(hotkeyToPieMenuId.keyCode,
              modifiers: hotkeyToPieMenuId.keyModifiers,
              scope: HotKeyScope.system),
          keyDownHandler: (hotkey) {
            _event = KeyboardEvent(
                KeyboardEventType.keyDown, hotkey.keyCode.keyId,
                hotkey: hotkey);
            notifyListeners();
          },
        );
      }
    }
    log("Registered hotkeys: ${hotKeyManager.registeredHotKeyList}");
  }
}
