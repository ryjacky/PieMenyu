import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';

class UpdateProvider {
  final String filename = "PieMenyuInstaller.exe";

  Future<bool> fetchUpdate() async {
    final rawVersion = await Future.wait([
      get(Uri.parse(
          "https://github.com/ryjacky/PieMenyu/releases/download/versionInfo/latest")),
      PackageInfo.fromPlatform()
    ]);

    int rawUpdateAvailable = ((rawVersion[0] as Response)
        .body
        .compareTo((rawVersion[1] as PackageInfo).version));

    if (rawUpdateAvailable > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> update() async {
    if (Platform.isWindows) {
      final file = File(path.join(Directory.systemTemp.path, filename));
      if (await file.exists()) await file.delete();

      final task = DownloadTask(
        url:
            'https://github.com/ryjacky/PieMenyu/releases/latest/download/$filename',
        filename: filename,
        directory: Directory.systemTemp.path,
        updates: Updates.statusAndProgress,
        retries: 3,
      );

      await FileDownloader().download(task, onStatus: (status) async {
        if (status == TaskStatus.complete) {
          await Process.start(file.path, [], mode: ProcessStartMode.detached);
          exitApp();
        }
      });
    }
  }

  exitApp() async {
    await launchUrl(Uri.parse("piemenyu://exit"));
    exit(0);
  }
}
