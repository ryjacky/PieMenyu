import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/pie_menyu_system_tray.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:window_manager/window_manager.dart';

import 'view/pie_menu_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  await hotKeyManager.unregisterAll();
  await DB.initialize();
  await PieMenyuSystemTray.initialize();

  WindowOptions windowOptions = const WindowOptions(
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
    alwaysOnTop: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.hide();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PieMenyu',
      localizationsDelegates: [LocalJsonLocalization.delegate],
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: PieMenuView(pieMenu: PieMenu()),
      ),
    );
  }
}
