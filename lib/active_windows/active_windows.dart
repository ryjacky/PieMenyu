import 'dart:convert';
import 'dart:io';

import 'package:pie_menyu/active_windows/window_info.dart';
import 'package:process_run/shell.dart';

class ActiveWindows {
  String windowsCommand = 'powershell -command "Get-Process | Where-Object { \$_.MainWindowTitle -ne \'\' } | Select-Object Name, Path | ConvertTo-Json"';
  String macCommand = 'osascript -e \'tell application "System Events" to get name of (processes where background only is false)\'';
  String linuxCommand = 'xdotool getactivewindow getwindowname';

  Future<List<WindowInfo>> getOpenedWindows() async {
    if (Platform.isWindows) {
      var rawResult = (await Shell().run(windowsCommand)).first.stdout;
      List<dynamic> result = jsonDecode(rawResult);

      return result
          .map((rawWindowInfo) => WindowInfo(
          name: rawWindowInfo['Name'], path: rawWindowInfo['Path']))
          .toList();
    } else if (Platform.isMacOS) {
      return [];
    } else if (Platform.isLinux) {
      return [];
    } else {
      throw Exception("Unsupported platform");
    }

  }
}
