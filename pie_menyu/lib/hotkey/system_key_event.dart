import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:global_hotkey/global_hotkey.dart';
import 'package:global_hotkey/hotkey.dart';
import 'package:global_hotkey/hotkey_event.dart';
import 'package:pie_menyu/deep_linking/deep_link_handler.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/profile.dart';

typedef KeyEventListener = bool Function(Hotkey hotKey);

class SystemKeyEvent {
  final List<KeyEventListener> _keyUpListeners = [];

  addKeyUpListener(KeyEventListener listener) {
    _keyUpListeners.add(listener);
  }

  removeKeyUpListener(KeyEventListener listener) {
    _keyUpListeners.remove(listener);
  }

  final List<KeyEventListener> _keyDownListeners = [];

  addKeyDownListener(KeyEventListener listener) {
    _keyDownListeners.add(listener);
  }

  removeKeyDownListener(KeyEventListener listener) {
    _keyDownListeners.remove(listener);
  }

  KeyEventType? _keyEventType;

  KeyEventType? get keyEventType => _keyEventType;

  final Database _db;

  SystemKeyEvent(this._db, DeepLinkHandler deepLinkHandler) {
    registerHotkey();

    deepLinkHandler.addListener((value) {
      switch (value) {
        case DeepLinkCommand.start:
        case DeepLinkCommand.reload:
          registerHotkey();
          break;
        case DeepLinkCommand.stop:
          try {
            GlobalHotkey.instance.dispose();
          } catch (e) {
            log("Failed to dispose hotkeys: $e");
          }
          break;
      }
    });
  }

  registerHotkey() async {
    try {
      GlobalHotkey.instance.dispose();
    } catch (e) {
      log("Failed to dispose hotkeys: $e");
    }

    List<Profile> profiles = await _db.getProfiles();

    Set<Hotkey> hotkeys = {};

    for (final profile in profiles) {
      if (!profile.enabled) continue;

      for (PieMenuHotkey hotkey in profile.pieMenuHotkeys) {
        if (hotkey.keyId == null) continue;
        hotkeys.add(Hotkey(
          LogicalKeySet.fromSet({
            LogicalKeyboardKey(hotkey.keyId!),
            if (hotkey.ctrl) LogicalKeyboardKey.control,
            if (hotkey.shift) LogicalKeyboardKey.shift,
            if (hotkey.alt) LogicalKeyboardKey.alt,
          }),
          context: profile.exes.map((e) => e.path).toSet(),
        ));
      }
    }

    GlobalHotkey.initialize(hotkeys).keyEvents.listen((event) {
      if (event.type == HotkeyEventType.hotkeyTriggered) {
        _onKeyDown(event.hotkey);
      } else if (event.type == HotkeyEventType.hotkeyReleased) {
        _onKeyUp(event.hotkey);
      }
    });

    log("Hotkeys registered");
  }

  _onKeyDown(Hotkey hotkey) async {
    if (_keyEventType == KeyEventType.down) return;

    log("Hotkey pressed: $hotkey");
    _keyEventType = KeyEventType.down;

    for (final listener in _keyDownListeners) {
      if (!listener(hotkey)) break;
    }
  }

  _onKeyUp(Hotkey hotkey) async {
    if (_keyEventType != KeyEventType.down &&
        _keyEventType != KeyEventType.repeat) {
      return;
    }
    log("Hotkey released: $hotkey");

    _keyEventType = KeyEventType.up;

    for (final listener in _keyUpListeners) {
      if (!listener(hotkey)) break;
    }
  }
}
