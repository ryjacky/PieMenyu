import 'package:app_links/app_links.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class DeepLinkHandler {
  static DeepLinkHandler? _instance;

  static DeepLinkHandler get instance {
    if (_instance == null) throw Exception("DeepLinkHandler not yet initialized.");
    return _instance!;
  }

  static initialize() {
    _instance ??= DeepLinkHandler._internal();
  }

  DeepLinkHandler._internal() {
    final appLinks = AppLinks();

    appLinks.allUriLinkStream.listen((uri) async {
      String url = uri.toString();

      if (url.contains("close")) appWindow.close();
    });
  }
}
