import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:system_tray/system_tray.dart';
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
    final appLinks = AppLinks();

    appLinks.allUriLinkStream.listen((uri) async {
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

      // deep links always open the window, we need to hide it programmatically
      await Future.delayed(const Duration(milliseconds: 100));
      await windowManager.hide();
      await AppWindow().hide();

    });
  }
}
