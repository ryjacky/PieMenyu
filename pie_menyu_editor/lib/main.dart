import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_editor/deep_linking/deep_link_handler.dart';
import 'package:pie_menyu_editor/preferences/editor_preferences.dart';
import 'package:pie_menyu_editor/view/coach/coach_provider.dart';
import 'package:pie_menyu_editor/view/routes/home/home_route.dart';
import 'package:pie_menyu_editor/view/routes/on_boarding/on_boarding_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/color_schemes.g.dart';
import 'theme/text_theme.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  DeepLinkHandler.initialize();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  launchAtStartup.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );

  Database db = Database((await getApplicationSupportDirectory()).parent);
  await db.initialize();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (kDebugMode) {
    // Clear the shared preferences on debug mode
    await prefs.clear();
  }

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ja'), Locale('zh')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: PieMenyu(
      db: db,
      pref: EditorPreferences(prefs),
    ),
  ));

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
  final EditorPreferences _pref;

  const PieMenyu({
    super.key,
    required Database db,
    required EditorPreferences pref,
  })  : _db = db,
        _pref = pref;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => _db),
        Provider(create: (_) => _pref),
        ChangeNotifierProvider(create: (_) => CoachProvider(_pref))
      ],
      child: MaterialApp(
        title: "PieMenyu Editor",
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            textTheme: textTheme),
        themeMode: ThemeMode.dark,
        home: _pref.showOnBoarding
            ? const OnBoardingPage()
            : const HomeRoute(),
      ),
    );
  }
}
