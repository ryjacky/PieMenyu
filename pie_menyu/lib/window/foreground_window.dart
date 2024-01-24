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
        PROCESS_QUERY_LIMITED_INFORMATION | PROCESS_VM_READ,
        FALSE,
        processId.value);

    if (processHandle == NULL) {
      throw Exception("Unable to open process");
    }

    Pointer<Utf16> pathPointer = calloc<Uint16>(MAX_PATH).cast<Utf16>();
    int result =
        GetModuleFileNameEx(processHandle, NULL, pathPointer, MAX_PATH);

    if (result == 0) {
      throw Exception("Unable to get module file name");
    }

    path = pathPointer.toDartString();
    free(pathPointer);
    free(processId);
  }
}
