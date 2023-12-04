import 'dart:developer';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/db.dart';
import 'package:pie_menyu/ui/routes/homePage/home_page.dart';

import 'theme/color_schemes.g.dart';
import 'theme/text_theme.g.dart';

Future<void> main() async {
  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  WidgetsFlutterBinding.ensureInitialized();
  // For hot reload, `unregisterAll()` needs to be called.
  await hotKeyManager.unregisterAll();

  HotKey _hotKey = HotKey(
    KeyCode.keyD,
    modifiers: [KeyModifier.shift],
    // Set hotkey scope (default is HotKeyScope.system)
    scope: HotKeyScope.system, // Set as inapp-wide hotkey.
  );
  await hotKeyManager.register(
    _hotKey,
    keyDownHandler: (hotKey) {
      log('onKeyDown+${hotKey.toJson()}');
    },
    // Only works on macOS.
    keyUpHandler: (hotKey){
      log('onKeyUp+${hotKey.toJson()}');
    } ,
  );
  DB.initialize();

  runApp(const PieMenyus());

  doWhenWindowReady(() {
    const initialSize = Size(900, 600);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class PieMenyus extends StatelessWidget {
  const PieMenyus({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app-name'.i18n(),
      localizationsDelegates: [
        LocalJsonLocalization.delegate
      ],
      darkTheme: ThemeData(
          useMaterial3: false,
          colorScheme: darkColorScheme,
          textTheme: textTheme
      ),
      themeMode: ThemeMode.dark,
      home: WindowBorder(
        color: Theme.of(context).colorScheme.primary,
        width: 1,
        child: const HomePage()
      ),
    );
  }
}