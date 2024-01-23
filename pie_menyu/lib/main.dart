import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_menyu/screens/pie_menu_screen/pie_menu_screen.dart';
import 'package:pie_menyu/window/pie_menyu_window_manager.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:provider/provider.dart';

import 'hotkey/key_event_notifier.dart';
import 'screens/pie_menu_screen/pie_menu_state_provider.dart';
import 'tray/pie_menyu_system_tray.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbDir = (await getApplicationSupportDirectory()).parent;
  final db = Database(dbDir);
  final pieMenuStateProvider = PieMenuStateProvider();
  final globalKeyEvent = GlobalKeyEvent(db);
  final windowManager = PieMenyuWindowManager(
    db,
    pieMenuStateProvider,
    globalKeyEvent,
  );

  if (await isRunning()) {
    debugPrint("PieMenyu is already running");
    exit(0);
  }

  windowManager.initialize();
  PieMenyuSystemTray.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => db),
        Provider(create: (_) => windowManager),
        Provider(create: (_) => globalKeyEvent),
        ChangeNotifierProvider(create: (_) => pieMenuStateProvider),
      ],
      child: MaterialApp(
        title: 'PieMenyu',
        localizationsDelegates: [LocalJsonLocalization.delegate],
        home: const PieMenuScreen(),
      ),
    ),
  );
}

Future<bool> isRunning() async {
  final exeName =
      Platform.resolvedExecutable.split(Platform.pathSeparator).last;

  final cmdQueryProcess = "tasklist /FI \"imagename eq $exeName\"";

  final result = await Process.run(cmdQueryProcess, []);
  return exeName.allMatches(result.stdout.toString()).length > 1;
}
