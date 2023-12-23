import 'dart:io';
import 'package:path/path.dart' as p;

class MouseHookProc {
  static MouseHookProc? _instance;

  Process? _mouseHookProc;

  Future<Stream> run() async {
    _mouseHookProc ??= await Process.start(
        p.join(Directory(Platform.resolvedExecutable).parent.path, "data",
            "flutter_assets", "windows", "support", "mouseHook.exe"),
        []);

    return _mouseHookProc!.stdout;
  }

  factory MouseHookProc() {
    _instance ??= MouseHookProc._();
    return _instance!;
  }

  dispose() {
    _mouseHookProc?.kill();
    _instance = null;
    _mouseHookProc = null;
  }

  MouseHookProc._();
}
