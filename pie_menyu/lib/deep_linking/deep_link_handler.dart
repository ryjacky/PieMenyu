import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:system_tray/system_tray.dart';
import 'package:win32_registry/win32_registry.dart';
import 'package:window_manager/window_manager.dart';

enum DeepLinkCommand {
  reload,
  stop,
  start,
}

class DeepLinkHandler {
  final List<ValueChanged<DeepLinkCommand>> _listeners = [];

  void addListener(ValueChanged<DeepLinkCommand> listener) {
    _listeners.add(listener);
  }

  DeepLinkHandler() {
    register('piemenyu');

    final appLinks = AppLinks();

    appLinks.allUriLinkStream.listen((uri) async {
      // deep links always open the window, we need to hide it programmatically
      await windowManager.hide();
      await AppWindow().hide();

      String url = uri.toString();
      for (var listener in _listeners) {
        if (url.contains("reload")) {
          listener(DeepLinkCommand.reload);
        } else if (url.contains('start')) {
          listener(DeepLinkCommand.start);
        } else if (url.contains('stop')) {
          listener(DeepLinkCommand.stop);
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
