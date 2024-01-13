import 'dart:isolate';

abstract class SystemHook {
  void start(SendPort sendPort);
}