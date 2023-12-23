import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:path/path.dart' as p;

enum HookTypes {
  keyboard,
  mouse,
}
extension HookTypesExtension on HookTypes {
  String get name {
    switch (this) {
      case HookTypes.keyboard:
        return "keyboardHook.exe";
      case HookTypes.mouse:
        return "mouseHook.exe";
    }
  }
}

class SystemHook {
  static Future<ReceivePort> isolated(HookTypes type) async {
    final receivePort = ReceivePort();

    Isolate.spawn(
        (sendPort) => SystemHook._()._run(sendPort, type), receivePort.sendPort);

    return receivePort;
  }

  _run(SendPort sendPort, HookTypes type) async {
    final keyboardHookProc = await Process.start(
        p.join(Directory(Platform.resolvedExecutable).parent.path, "data",
            "flutter_assets", "windows", "support", type.name),
        []);

    keyboardHookProc.stdout.transform(utf8.decoder).listen((event) {
      sendPort.send(event);
    });
  }

  SystemHook._();
}
