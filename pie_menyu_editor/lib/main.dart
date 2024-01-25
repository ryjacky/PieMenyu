import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:localization/localization.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_editor/view/routes/home/home_route.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/color_schemes.g.dart';
import 'theme/text_theme.g.dart';

Future<void> main() async {
  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  WidgetsFlutterBinding.ensureInitialized();
  // For hot reload, `unregisterAll()` needs to be called.
  await hotKeyManager.unregisterAll();

  // Start pieMenyu
  // Will not when both editor and pie_menyu is in debug mode
  // pie_menyu will be terminated after close in debug mode
  launchUrl(Uri.parse("piemenyu://"));

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  launchAtStartup.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );

  Database db = Database((await getApplicationSupportDirectory()).parent);
  await db.initialize();

  runApp(PieMenyu(db: db));

  doWhenWindowReady(() {
    const initialSize = Size(900, 600);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class PieMenyu extends StatelessWidget {
  final Database _db;
  const PieMenyu({super.key, required Database db}) : _db = db;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => _db),
      ],
      child: MaterialApp(
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
        home: const HomeRoute()
      ),
    );
  }
}