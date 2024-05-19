import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

class ForegroundWindow {
  String path = "";

  ForegroundWindow() {
    int foregroundWindow = GetForegroundWindow();

    if (foregroundWindow == NULL) {
      throw Exception("No foreground window");
    }

    Pointer<DWORD> processId = calloc<DWORD>();
    GetWindowThreadProcessId(foregroundWindow, processId);

    int processHandle = OpenProcess(
        PROCESS_ACCESS_RIGHTS.PROCESS_QUERY_LIMITED_INFORMATION | PROCESS_ACCESS_RIGHTS.PROCESS_VM_READ,
        FALSE,
        processId.value);

    if (processHandle == NULL) {
      path = "";
    }

    Pointer<Utf16> pathPointer = calloc<Uint16>(MAX_PATH).cast<Utf16>();
    int result =
        GetModuleFileNameEx(processHandle, NULL, pathPointer, MAX_PATH);

    if (result == 0) {
      path = "";
    }

    path = pathPointer.toDartString();
    free(pathPointer);
    free(processId);
  }
}
