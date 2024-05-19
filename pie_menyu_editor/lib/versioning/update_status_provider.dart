import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;

class UpdateStatusProvider extends ChangeNotifier {
  final String filename = "PieMenyuInstaller.exe";

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
    final rawVersion = await Future.wait([
      get(Uri.parse(
          "https://github.com/ryjacky/PieMenyu/releases/download/versionInfo/latest")),
      PackageInfo.fromPlatform()
    ]);

    int rawUpdateAvailable = ((rawVersion[0] as Response)
        .body
        .compareTo((rawVersion[1] as PackageInfo).version));

    if (rawUpdateAvailable > 0) {
      updateAvailable = true;
    } else {
      updateAvailable = false;
    }
  }

  Future<void> update() async {
    if (Platform.isWindows) {
      updating = true;

      final file =
          File(path.join(Directory.systemTemp.path, filename));
      if (await file.exists()) await file.delete();

      final task = DownloadTask(
        url:
            'https://github.com/ryjacky/PieMenyu/releases/latest/download/$filename',
        filename: filename,
        directory: Directory.systemTemp.path,
        updates: Updates.statusAndProgress,
        retries: 3,
      );

      final result = await FileDownloader().download(task, onStatus: (status) {
        if (status == TaskStatus.complete) {
          updating = false;
          Process.run(file.path, []);
        }
      });
    }
  }
}
