library pie_menyu_core;

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:win32/win32.dart';

import '../executor/executable.dart';

class OpenAppTask extends PieItemTask with Executable {
  final Map<String, int> _windowTitleToHandle = {};

  OpenAppTask() : super(taskType: PieItemTaskType.openApp) {
    _fieldCheck();
  }

  OpenAppTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck() {
    if (arguments.length != 2) {
      arguments = ["", ""];
    }
    taskType = PieItemTaskType.openApp;
  }

  set appPath(String value) {
    arguments[0] = value;
  }

  String get appPath => arguments[0];

  set windowTitle(String value) {
    arguments[1] = value;
  }

  String get windowTitle => arguments[1];

  @override
  Future<void> execute() async {
    enumerateWindows();

    final key = _windowTitleToHandle.keys
        .where((key) => key.contains(windowTitle))
        .firstOrNull;
    final hWnd = _windowTitleToHandle[key];

    if (hWnd != null && windowTitle.isNotEmpty) {
      SetForegroundWindow(hWnd);
    } else {
      await Process.run(appPath, [], runInShell: true);
    }
  }

  int enumWindowsProc(int hWnd, int lParam) {
    // Don't enumerate windows unless they are marked as WS_VISIBLE
    if (IsWindowVisible(hWnd) == FALSE) return TRUE;

    final length = GetWindowTextLength(hWnd);
    if (length == 0) {
      return TRUE;
    }

    final buffer = wsalloc(length + 1);
    GetWindowText(hWnd, buffer, length + 1);
    _windowTitleToHandle[buffer.toDartString()] = hWnd;
    free(buffer);

    return TRUE;
  }

  /// List the window handle and text for all top-level desktop windows
  /// in the current session.
  void enumerateWindows() {
    final lpEnumFunc = NativeCallable<EnumWindowsProc>.isolateLocal(
      enumWindowsProc,
      exceptionalReturn: 0,
    );
    EnumWindows(lpEnumFunc.nativeFunction, 0);
    lpEnumFunc.close();
  }

// DON'T delete this yet, it could be used in pie_menyu_editor
// String? getExePath(int processID) {
//   // Get a handle to the process.
//   final hProcess = OpenProcess(
//       PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, FALSE, processID);
//
//   if (hProcess == 0) {
//     return null;
//   }
//
//   // Get a list of all the modules in this process.
//   final hMods = calloc<HMODULE>(1024);
//   final cbNeeded = calloc<DWORD>();
//   final szModName = wsalloc(MAX_PATH);
//
//   String? result;
//
//   if (GetModuleFileNameEx(hProcess, NULL, szModName, MAX_PATH) != 0) {
//     result = szModName.toDartString();
//   }
//
//   free(hMods);
//   free(cbNeeded);
//   free(szModName);
//
//   // Release the handle to the process.
//   CloseHandle(hProcess);
//
//   return result;
// }
}
