import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as p;

/// Represents information about a running process, which the process has a
/// graphical user interface and is visible in the taskbar.
/// TODO: Support for Linux and MacOS
class GUIProcess {
  final String processName;
  final String exePath;
  final String base64Icon;
  final String mainWindowTitle;

  GUIProcess({
    required this.processName,
    required this.exePath,
    required this.base64Icon,
    required this.mainWindowTitle,
  });

  static Future<Set<GUIProcess>> getAllUnique() async {
    ProcessResult result = await Process.run(
        p.join(Directory(Platform.resolvedExecutable).parent.path, "data",
            "flutter_assets", "support", "get_taskbar_process_info.exe"), []);

    Map<String, GUIProcess> taskBarProcessInfoMap = {};
    for (var item in result.stdout.split("\n")) {
      if (item.trim().isEmpty) continue;
      List<String> parts = item.split("\t");
      if (parts.length != 4) {
        log("Invalid taskbar process info: $item");
        continue;
      }
      taskBarProcessInfoMap[parts[2]] = GUIProcess(
        processName: parts[0],
        exePath: parts[2],
        base64Icon: parts[3].trim(),
        mainWindowTitle: parts[1],
      );
    }

    return taskBarProcessInfoMap.values.toSet();
  }

  // int enumWindowsProc(int hWnd, int lParam) {
  //   // Don't enumerate windows unless they are marked as WS_VISIBLE
  //   if (IsWindowVisible(hWnd) == FALSE) return TRUE;
  //
  //   final length = GetWindowTextLength(hWnd);
  //   if (length == 0) {
  //     return TRUE;
  //   }
  //
  //   final buffer = wsalloc(length + 1);
  //   GetWindowText(hWnd, buffer, length + 1);
  //   print('hWnd $hWnd: ${buffer.toDartString()}');
  //   free(buffer);
  //
  //   return TRUE;
  // }
  //
  // /// List the window handle and text for all top-level desktop windows
  // /// in the current session.
  // void enumerateWindows() {
  //   final lpEnumFunc = NativeCallable<WNDENUMPROC>.isolateLocal(
  //     enumWindowsProc,
  //     exceptionalReturn: 0,
  //   );
  //   EnumWindows(lpEnumFunc.nativeFunction, 0);
  //   lpEnumFunc.close();
  // }
}
