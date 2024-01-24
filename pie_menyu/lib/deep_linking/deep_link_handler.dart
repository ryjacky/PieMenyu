import 'dart:developer';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:win32_registry/win32_registry.dart';

enum DeepLinkCommand {
  reload,
}

class DeepLinkHandler {
  final List<ValueChanged<DeepLinkCommand>> _listeners = [];

  void addListener(ValueChanged<DeepLinkCommand> listener) {
    _listeners.add(listener);
  }

  DeepLinkHandler() {
    register('piemenyu');

    final appLinks = AppLinks();

    appLinks.allUriLinkStream.listen((uri) {
      if (uri.toString().contains("reload")) {
        for (var listener in _listeners) {
          listener(DeepLinkCommand.reload);
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
