import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:window_manager/window_manager.dart';

import 'keyboard_event.dart';
import 'keyboard_hook.dart';

class KeyboardProvider extends ChangeNotifier {
  KeyboardEvent _event = KeyboardEvent(KeyboardEventType.keyUp, 0);

  KeyboardHookIsolate? _keyboardHookIsolate;

  KeyboardProvider() {
    initializeKeyDownHook().then((value) => initializeKeyboardHook())
    ;
  }

  get keyEvent => _event;

  void initializeKeyboardHook() async {
    _keyboardHookIsolate = KeyboardHookIsolate(hotKeyManager.registeredHotKeyList);
    _keyboardHookIsolate!.addKeyUpListener(() async {
      if (await windowManager.isFocused()) {
        _event = KeyboardEvent(KeyboardEventType.keyUp, 0);
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initializeKeyDownHook() async {
    await hotKeyManager.unregisterAll();
    List<Profile> profiles = await DB.getProfiles();
    for (Profile profile in profiles) {
      for (HotkeyToPieMenuId hotkeyToPieMenuId
          in profile.hotkeyToPieMenuIdList) {
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
