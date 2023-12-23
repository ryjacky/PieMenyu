import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/system/mouse/mouse_cursor_provider.dart';
import 'package:pie_menyu/system/pie_menyu_system_tray.dart';
import 'package:pie_menyu/system/window/foreground_window.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/providers/pie_menu_provider.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'controller/window_controller.dart';
import 'view/pie_menu_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<Future<dynamic>> asyncInitializers = [
    windowManager.ensureInitialized(),
    DB.initialize(),
    PieMenyuSystemTray.initialize(),
  ];
  await Future.wait(asyncInitializers);

  WindowOptions windowOptions = WindowOptions(
    size: WindowController.windowSize,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
    alwaysOnTop: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.minimize();
    await windowManager.hide();
  });

  print(ForegroundWindow.get().path);

  final windowControl = WindowController();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => windowControl.pieMenuProvider),
        ChangeNotifierProvider(create: (_) => MouseCursorProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mousePosition = context.select<MouseCursorProvider, Offset>(
        (value) => value.mouseEvent.position);
    final pieMenu =
        context.select<PieMenuProvider, PieMenu>((value) => value.pieMenu);
    final pieItems = context
        .select<PieMenuProvider, List<PieItem>>((value) => value.pieItems);

    return MaterialApp(
      title: 'PieMenyu',
      localizationsDelegates: [LocalJsonLocalization.delegate],
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: PieMenuView(
          pieMenu: pieMenu,
          pieItems: pieItems,
          activePieItemAt: getActivePieItemOrderIndex(
            context.read<PieMenuProvider>().pieCenterScreenPosition,
            mousePosition,
            pieMenu,
            pieItems,
          ),
        ),
      ),
    );
  }

  int getActivePieItemOrderIndex(
    Offset pieCenterPosition,
    Offset position,
    PieMenu pieMenu,
    List<PieItem> pieItems,
  ) {
    if (pieItems.isEmpty) {
      return 0;
    }

    final dx = position.dx - pieCenterPosition.dx;
    // 0,0 is top left, so dy is inverted
    final dy = pieCenterPosition.dy - position.dy;
    // We want the angle of 12 o'clock to be 0, so we swap dx and dy
    double pieCenterRotation = atan2(dx, dy);

    if (dx < 0) {
      pieCenterRotation += 2 * pi;
    }

    // Offset the rotation by half the angle of a pie item,
    // which is the detection range
    pieCenterRotation += 2 * pi / pieItems.length / 2;

    var activeBtnIndex =
        (pieItems.length * pieCenterRotation / (2 * pi)).floor();

    // Because we offset the rotation by half the angle of a pie item,
    // we need to mod by the number of pie items to get the correct index
    return activeBtnIndex % pieItems.length;
  }
}
