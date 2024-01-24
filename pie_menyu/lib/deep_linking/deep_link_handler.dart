import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:win32_registry/win32_registry.dart';

class DeepLinkHandler {
  final List<ValueChanged> _onReloadListeners = [];

  void addOnReloadListener(ValueChanged listener) {
    _onReloadListeners.add(listener);
  }

  DeepLinkHandler() {
    register('piemenyu');

    final appLinks = AppLinks();

    appLinks.allUriLinkStream.listen((uri) {
      if (uri.path.contains("reload")) {
        for (var onReload in _onReloadListeners) {
          onReload(uri);
        }
      }
    });
  }

  Future<void> register(String scheme) async {
    String appPath = Platform.resolvedExecutable;

    String protocolRegKey = 'Software\\Classes\\$scheme';
    RegistryValue protocolRegValue = const RegistryValue(
      'URL Protocol',
      RegistryValueType.string,
      '',
    );
    String protocolCmdRegKey = 'shell\\open\\command';
    RegistryValue protocolCmdRegValue = RegistryValue(
      '',
      RegistryValueType.string,
      '"$appPath" "%1"',
    );

    final regKey = Registry.currentUser.createKey(protocolRegKey);
    regKey.createValue(protocolRegValue);
    regKey.createKey(protocolCmdRegKey).createValue(protocolCmdRegValue);
  }
}
