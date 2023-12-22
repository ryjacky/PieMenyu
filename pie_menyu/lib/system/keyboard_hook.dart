import 'dart:developer';
import 'dart:io';

import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:path/path.dart' as p;
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/profile.dart';

typedef KeyUpListener = void Function();
typedef KeyDownListener = void Function(HotKey);

class KeyboardHook {
  static KeyboardHook? _instance;
  final List<KeyDownListener> _keyDownListeners = [];
  final List<KeyUpListener> _keyUpListeners = [];

  static ensureInitialized() {
    _instance ??= KeyboardHook();
    _instance!._initializeKeyUpHook();
    _instance!._initializeKeyDownHook();
  }

  static KeyboardHook get instance {
    if (_instance == null) {
      throw Exception("KeyboardHook is not initialized");
    }
    return _instance!;
  }

  addKeyDownListener(KeyDownListener listener) {
    _keyDownListeners.add(listener);
  }

  removeKeyDownListener(KeyDownListener listener) {
    _keyDownListeners.remove(listener);
  }

  addKeyUpListener(KeyUpListener listener) {
    _keyUpListeners.add(listener);
  }

  removeKeyUpListener(KeyUpListener listener) {
    _keyUpListeners.remove(listener);
  }

  void _initializeKeyDownHook() async {
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
            for (var listener in _keyDownListeners) {
              listener(hotkey);
            }
          },
        );
      }
    }
    log("Registered hotkeys: ${hotKeyManager.registeredHotKeyList}");
  }

  void _initializeKeyUpHook() async {
    Process keyUpProc = await Process.start(
        p.join(Directory(Platform.resolvedExecutable).parent.path, "data",
            "flutter_assets", "support", "keyboardHook.exe"),
        []);

    await keyUpProc.stdout.forEach((element) {
      for (var listener in _keyUpListeners) {
        listener();
      }
    });
  }
}
