import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

class ForegroundWindowEvent {
  static ForegroundWindowEvent? _instance; // Singleton instance
  final List<Function(String)> _listeners = []; // List of listeners

  factory ForegroundWindowEvent() {
    _instance ??= ForegroundWindowEvent._();
    return _instance!;
  }

  // Private constructor
  ForegroundWindowEvent._();

  void addListener(Function(String exePath) listener) {
    _listeners.add(listener);
  }

  void removeListener(Function(String) listener) {
    _listeners.remove(listener);
  }

  Future<void> start() async {
    Process result = await Process.start(
        p.join(Directory(Platform.resolvedExecutable).parent.path, "data",
            "flutter_assets", "support", "foregroundWindowEvent.exe"),
        []);

    result.stdout.transform(utf8.decoder).listen((data) {
      for (var listener in _listeners) {
        listener(data.trim());
      }
    });
  }
}