import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu/system/keyboard/keyboard_event.dart';
import 'package:pie_menyu/system/keyboard/keyboard_hook.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:window_manager/window_manager.dart';

import '../system_hook.dart';

class KeyboardProvider extends ChangeNotifier {
  KeyboardEvent _event = KeyboardEvent(KeyboardEventType.keyUp, 0);

  KeyboardHookIsolate? _keyboardHookIsolate;

  KeyboardProvider() {
    initializeKeyboardHook();
    initializeKeyDownHook();
  }

  get keyEvent => _event;

  void initializeKeyboardHook() async {
    _keyboardHookIsolate = KeyboardHookIsolate();
    _keyboardHookIsolate!.addMouseMoveListener((x, y) async {
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

  void initializeKeyDownHook() async {
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
