import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_hotkey/global_hotkey.dart';
import 'package:global_hotkey/hotkey.dart';
import 'package:global_hotkey/hotkey_event.dart';

void main() async {
  runApp(const MyApp());

  final hotkey = GlobalHotkey.initialize({
    Hotkey(LogicalKeySet(LogicalKeyboardKey.keyA)),
  });

  hotkey.keyEvents.listen((HotkeyEvent e) {
    if (e.type == KeyEventType.hotkeyTriggered) {
      print("Hotkey triggered: ${e.hotkey.keySet.keys.first.keyLabel}");
    } else if (e.type == KeyEventType.hotkeyReleased) {
      print("Hotkey released: ${e.hotkey.keySet.keys.first.keyLabel}");
    }
  });

  // You need to dispose the hotkey when you are done with it
  // hotkey.dispose();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
      ),
    );
  }
}
