import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_menyu/bindings/stylus_gesture_binding.dart';
import 'package:pie_menyu/screens/pie_menu_screen/pie_menu_screen.dart';
import 'package:pie_menyu/screens/pie_menu_screen/pie_menu_screen_view_model.dart';
import 'package:pie_menyu/window/pie_menyu_window_manager.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/executor/executor_service.dart';
import 'package:provider/provider.dart';

import 'deep_linking/deep_link_handler.dart';
import 'hotkey/system_key_event.dart';
import 'screens/pie_menu_screen/pie_menu_state_provider.dart';
import 'tray/pie_menyu_system_tray.dart';

Future<void> main(dynamic args) async {
  WidgetsFlutterBinding.ensureInitialized();
  StylusGestureBinding.initialize();

  final deepLinkHandler = DeepLinkHandler();
  final dbDir = (await getApplicationSupportDirectory()).parent;
  final db = Database(dbDir);
  final pieMenuStateProvider = PieMenuStateProvider();
  final systemKeyEvent = SystemKeyEvent(db, deepLinkHandler);
  final windowManager = PieMenyuWindow(
    db,
    pieMenuStateProvider,
    systemKeyEvent,
  );
  final executorService = ExecutorService();
  final pieMenuScreenViewModel = PieMenuScreenViewModel(
    executorService,
    windowManager,
    pieMenuStateProvider,
    systemKeyEvent,
    db,
  );

  await windowManager.initialize();
  await PieMenyuSystemTray.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => db),
        Provider(create: (_) => windowManager),
        Provider(create: (_) => systemKeyEvent),
        ChangeNotifierProvider(create: (_) => executorService),
        ChangeNotifierProvider(create: (_) => pieMenuScreenViewModel),
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
