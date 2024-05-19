import 'dart:io';

import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';

class UpdateStatusProvider extends ChangeNotifier {
  bool _updating = false;
  bool _updateAvailable = false;

  bool get updating => _updating;

  bool get updateAvailable => _updateAvailable;

  set updateAvailable(bool value) {
    _updateAvailable = value;
    notifyListeners();
  }

  set updating(bool value) {
    _updating = value;
    notifyListeners();
  }

  void fetchUpdate() async {
    // Check for update
    ProcessResult? result;
    if (Platform.isWindows) {
      result = (await Shell().run("winget upgrade")).firstOrNull;
    }

    if (result != null && result.outText.contains("PieMenyu")) {
      updateAvailable = true;
    }

    updateAvailable = false;
  }

  Future<void> update() async {
    if (Platform.isWindows) {
      updating = true;
      await Process.start("winget", ["upgrade", "PieMenyu"],
          mode: ProcessStartMode.detached);
    }
  }
}
