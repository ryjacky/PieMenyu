import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/system/keyboard/keyboard_event.dart';
import 'package:pie_menyu/system/keyboard/keyboard_provider.dart';
import 'package:pie_menyu/system/pie_menyu_system_tray.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_core/providers/pie_menu_provider.dart';
import 'package:provider/provider.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import 'system/mouse/mouse_cursor_provider.dart';
import 'view/pie_menu_view.dart';

const windowSize = Size(1024, 1024);
final pieMenuProvider = PieMenuProvider();

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  List<Future<dynamic>> asyncInitializers = [
    windowManager.ensureInitialized(),
    DB.initialize(),
    PieMenyuSystemTray.initialize(),
  ];
  await Future.wait(asyncInitializers);

  final keyboardProvider = KeyboardProvider();
  keyboardProvider.addListener(() {
    if (keyboardProvider.keyEvent.type == KeyboardEventType.keyDown) {
      showWindow(keyboardProvider.keyEvent.hotkey!);
    }
    if (keyboardProvider.keyEvent.type == KeyboardEventType.keyUp) {
      hideWindow();
    }
  });


  WindowOptions windowOptions = const WindowOptions(
    size: windowSize,
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

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MouseCursorProvider()),
      ChangeNotifierProvider(create: (_) => pieMenuProvider),
    ],
    child: MyApp(),
  ),);
}

void hideWindow() async {
  await windowManager.hide();
}

void showWindow(HotKey hotKey) async {
  if (await windowManager.isFocused()) {
    return;
  }

  String foregroundApp = await getForegroundApp();

  List<Profile> profilesOfForegroundApp =
      await DB.getProfilesByExe(foregroundApp);
  Profile? profile = profilesOfForegroundApp.firstOrNull;
  profile ??= (await DB.getProfiles(ids: [1])).firstOrNull;

  if (profile == null) {
    throw Exception("Database possibly corrupted");
  }

  for (HotkeyToPieMenuId hotkeyToPieMenuId in profile.hotkeyToPieMenuIdList) {
    if (hotkeyToPieMenuId.keyCode == hotKey.keyCode) {
      try {
        pieMenuProvider.pieMenu = profile.pieMenus
            .firstWhere((element) => element.id == hotkeyToPieMenuId.pieMenuId);

        Offset cursorPos = await screenRetriever.getCursorScreenPoint();
        await windowManager.setPosition(Offset(cursorPos.dx - windowSize.width / 2,
            cursorPos.dy - windowSize.height / 2));
        await windowManager.show();
        await windowManager.focus();
      } catch (e) {
        log("Pie menu does not exist in profile, id: ${hotkeyToPieMenuId.pieMenuId}");
      }
    }
  }
}

String getForegroundApp() {
  return "";
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mousePosition = context
        .select<MouseCursorProvider, Offset>((value) => value.cursorPosition);
    final pieMenu =
    context.select<PieMenuProvider, PieMenu>((value) => value.pieMenu);
    final pieItems = context
        .select<PieMenuProvider, List<PieItem>>((value) => value.pieItems);

    return MaterialApp(
      title: 'PieMenyu',
      localizationsDelegates: [LocalJsonLocalization.delegate],
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: PieMenuView(mousePosition: mousePosition, pieMenu: pieMenu, pieItems: pieItems,),
      ),
    );
  }
}
