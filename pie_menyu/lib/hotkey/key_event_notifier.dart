import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:keyboard_event/keyboard_event.dart' as hook;
import 'package:pie_menyu/deep_linking/deep_link_handler.dart';
import 'package:pie_menyu_core/db/db.dart';

import 'known_v_key.dart';

typedef KeyEventListener = bool Function(HotKey hotKey);

class SystemKeyEvent {
  /// Only be used in the Windows platform
  bool keyUpRegistered = false;

  final List<KeyEventListener> _keyUpListeners = [];

  addKeyUpListener(KeyEventListener listener) {
    _keyUpListeners.add(listener);
  }

  final List<KeyEventListener> _keyDownListeners = [];

  addKeyDownListener(KeyEventListener listener) {
    _keyDownListeners.add(listener);
  }

  KeyEventType? _keyEventType;

  KeyEventType? get keyEventType => _keyEventType;

  final Database _db;

  List<int?> _pressedKeys = [];

  SystemKeyEvent(this._db, DeepLinkHandler deepLinkHandler) {
    _registerHotkey();

    deepLinkHandler.addListener((value) {
      switch (value) {
        case DeepLinkCommand.reload:
          _registerHotkey();
          break;
      }
    });
  }

  _registerHotkey() async {
    await hotKeyManager.unregisterAll();

    final hotkeys = await _db.getAllHotkeys();
    for (HotKey hotkey in hotkeys) {
      hotKeyManager.register(
        hotkey..scope = HotKeyScope.system,
        keyDownHandler: _onKeyDown,
        keyUpHandler: _onKeyUp,
      );
    }

    if (Platform.isWindows && !keyUpRegistered) {
      await initPlatformState();

      keyUpRegistered = true;
      hook.KeyboardEvent().startListening((keyEvent) {
        if (keyEvent.isKeyUP && _pressedKeys.contains(keyEvent.vkCode)) {
          _onKeyUp(HotKey(KeyCode.space));
        }
      });
    }

    log("Hotkeys registered");
  }

  Future<void> initPlatformState() async {
    List<String> err = [];
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await hook.KeyboardEvent.platformVersion;
    } on PlatformException {
      err.add('Failed to get platform version.');
    }
    try {
      await hook.KeyboardEvent.init();
    } on PlatformException {
      err.add('Failed to get virtual-key map.');
    }
  }

  _onKeyDown(HotKey hotkey) async {
    if (_keyEventType == KeyEventType.down) return;

    log("Hotkey pressed: $hotkey");
    _keyEventType = KeyEventType.down;
    _pressedKeys = [
      kKnownVirtualKeyCodes[hotkey.keyCode.stringValue],
      if (hotkey.modifiers != null)
        ...hotkey.modifiers!.map((e) => kKnownVirtualKeyCodes[e.stringValue])
    ];

    for (final listener in _keyDownListeners) {
      if (!listener(hotkey)) break;
    }
  }

  /// On Windows platform hotkey is always HotKey(KeyCode.space)
  _onKeyUp(HotKey hotkey) async {
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
