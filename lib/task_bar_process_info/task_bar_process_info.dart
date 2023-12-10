import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as p;

class TaskBarProcessInfo {
  final String processName;
  final String exePath;
  final String base64Icon;
  final String mainWindowTitle;

  TaskBarProcessInfo({
    required this.processName,
    required this.exePath,
    required this.base64Icon,
    required this.mainWindowTitle,
  });

  static Future<Set<TaskBarProcessInfo>> getAllUnique() async {
    ProcessResult result = await Process.run(
        p.join(Directory(Platform.resolvedExecutable).parent.path, "data",
            "flutter_assets", "support", "get_taskbar_process_info.exe"), []);

    Map<String, TaskBarProcessInfo> taskBarProcessInfoMap = {};
    for (var item in result.stdout.split("\n")) {
      if (item.trim().isEmpty) continue;
      List<String> parts = item.split("\t");
      if (parts.length != 4) {
        log("Invalid taskbar process info: $item");
        continue;
      }
      taskBarProcessInfoMap[parts[2]] = TaskBarProcessInfo(
        processName: parts[0],
        exePath: parts[2],
        base64Icon: parts[3].trim(),
        mainWindowTitle: parts[1],
      );
    }

    return taskBarProcessInfoMap.values.toSet();
  }
}
