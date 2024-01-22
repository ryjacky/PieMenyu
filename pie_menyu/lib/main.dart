import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_menyu/screens/pie_menu_screen/pie_menu_screen.dart';
import 'package:pie_menyu/window/window_manager.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:provider/provider.dart';

import 'screens/pie_menu_screen/pie_menu_state_provider.dart';
import 'tray/pie_menyu_system_tray.dart';

Future<void> main() async {
  final dbDir = (await getApplicationSupportDirectory()).parent;
  final db = Database(dbDir);
  final pieMenuStateProvider = PieMenuStateProvider();
  final windowManager = PieMenyuWindowManager(db, pieMenuStateProvider);

  if (await isRunning()) {
    log("PieMenyu is already running");
    exit(0);
  }

  WidgetsFlutterBinding.ensureInitialized();
  windowManager.initialize();
  PieMenyuSystemTray.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => db),
        Provider(create: (_) => windowManager),
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
