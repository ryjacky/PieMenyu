import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

typedef LowLevelMouseProc = IntPtr Function(Int32 nCode, IntPtr wParam, IntPtr lParam);
typedef LowLevelMouseProcDart = int Function(int nCode, int wParam, int lParam);

class WinMouseHooks {
  static final hHook = calloc<IntPtr>();

  // Hook procedure to be called when a keyboard event occurs
  static int KeyboardProc(int nCode, int wParam, int lParam) {
    if (nCode >= 0) {
      // Process the keyboard event here
      // You can access the event data from the `lParam` parameter
      // and perform custom logic based on the event type and data
    }

    // Pass the event to the next hook procedure in the hook chain
    return CallNextHookEx(hHook.value, nCode, wParam, lParam);
  }

  static initialize() {
    final keyboardProc = Pointer.fromFunction<LowLevelMouseProc>(KeyboardProc, 0);
    hHook.value = SetWindowsHookEx(WH_MOUSE_LL, keyboardProc, NULL, 0);
  }
}