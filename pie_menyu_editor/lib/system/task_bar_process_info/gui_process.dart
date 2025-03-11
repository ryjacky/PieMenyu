import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:win32/win32.dart';

/// Represents information about a running process, which the process has a
/// graphical user interface and is visible in the taskbar.
/// TODO: Support for Linux and MacOS
class GUIProcess {
  final String processName;
  final String exePath;
  String base64Icon;
  final String mainWindowTitle;
  static const platform = MethodChannel('pie.menyu/gui_process');

  static final Map<String, GUIProcess> _taskBarProcessInfoMap = {};

  GUIProcess({
    required this.processName,
    required this.exePath,
    required this.base64Icon,
    required this.mainWindowTitle,
  });

  static String? _getProcessFileName(int pid) {
    int processHandle = OpenProcess(
        PROCESS_ACCESS_RIGHTS.PROCESS_QUERY_INFORMATION |
            PROCESS_ACCESS_RIGHTS.PROCESS_VM_READ,
        FALSE,
        pid);
    if (processHandle != 0) {
      try {
        final buffer = wsalloc(MAX_PATH);
        if (GetModuleFileNameEx(processHandle, 0, buffer, MAX_PATH) > 0) {
          return buffer.toDartString();
        }
      } finally {
        CloseHandle(processHandle);
      }
    }

    return null;
  }

  static int _enumWindowsProc(int hWnd, int lParam) {
    // Don't enumerate windows unless they are marked as WS_VISIBLE
    if (IsWindowVisible(hWnd) == FALSE) return TRUE;

    final length = GetWindowTextLength(hWnd);
    if (length == 0) {
      return TRUE;
    }

    final buffer = wsalloc(length + 1);
    GetWindowText(hWnd, buffer, length + 1);
    final String windowTitle = buffer.toDartString();

    Pointer<Uint32> pid = calloc<Uint32>();
    GetWindowThreadProcessId(hWnd, pid);
    final String? processFileName = _getProcessFileName(pid.value);

    if (processFileName == null) {
      free(pid);
      free(buffer);
      return TRUE;
    }

    _taskBarProcessInfoMap[processFileName] = GUIProcess(
      processName: processFileName.split("\\").last.replaceAll(".exe", ""),
      exePath: processFileName,
      base64Icon: "",
      mainWindowTitle: windowTitle,
    );

    free(pid);
    free(buffer);

    return TRUE;
  }

  /// List the window handle and text for all top-level desktop windows
  /// in the current session.
  static Set<GUIProcess> enumerateWindows() {
    if (Platform.isWindows) {
      _taskBarProcessInfoMap.clear();

      final lpEnumFunc = NativeCallable<WNDENUMPROC>.isolateLocal(
        _enumWindowsProc,
        exceptionalReturn: 0,
      );
      EnumWindows(lpEnumFunc.nativeFunction, 0);
      lpEnumFunc.close();

      return _taskBarProcessInfoMap.values.toSet();
    } else if (Platform.isLinux) {

    } else if (Platform.isMacOS) {
      try {
        final result = platform.invokeMethod<List>('enumerateWindows');
        print(result);
      } on PlatformException catch (e) {
        print(e.message);
      }
    }

    return {};
  }
}
