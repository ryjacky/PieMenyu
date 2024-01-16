import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:localization/localization.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_menyu_core/db/db.dart';

import 'theme/color_schemes.g.dart';
import 'theme/text_theme.g.dart';
import 'package:path/path.dart' as p;

import 'view/routes/home/home_page.dart';

Future<void> main() async {
  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  WidgetsFlutterBinding.ensureInitialized();
  // For hot reload, `unregisterAll()` needs to be called.
  await hotKeyManager.unregisterAll();
  await DB.initialize((await getApplicationSupportDirectory()).parent);

  // Start pieMenyu
  Process.start(
      p.join(Directory(Platform.resolvedExecutable).parent.path, "pie_menyu",
          "pie_menyu.exe"),
      [], mode: ProcessStartMode.detached);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  launchAtStartup.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );

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
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: textTheme
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage()
    );
  }
}