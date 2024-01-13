import 'dart:isolate';

import 'package:win32/win32.dart';

abstract class SystemHook {
  SendPort? sendPort;
  int hookHandle = NULL;

  void start(SendPort sendPort);
}