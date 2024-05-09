// Copyright (c) 2020, Dart | Windows.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'hotkey.dart';
import 'hotkey_event.dart';
import 'dart:developer';

class WindowsHotkeyManager {
  static const LLKHF_INJECTED = 0x00000010;

  int /* HHOOK */ keyHook = 0;
  SendPort sendPort;
  Set<Hotkey> hotkeys;

  Hotkey? activeHotkey;

  WindowsHotkeyManager(this.sendPort, this.hotkeys) {
    startLowLevelKeyboardHook();
  }

  void startLowLevelKeyboardHook() {
    final lpfn = NativeCallable<HOOKPROC>.isolateLocal(
      lowLevelKeyboardHookProc,
      exceptionalReturn: 0,
    );

    keyHook = SetWindowsHookEx(
        WINDOWS_HOOK_ID.WH_KEYBOARD_LL, lpfn.nativeFunction, NULL, 0);

    final msg = calloc<MSG>();
    while (GetMessage(msg, NULL, 0, 0) != 0) {
      TranslateMessage(msg);
      DispatchMessage(msg);
    }

    lpfn.close();
    free(msg);

    log("Exiting WindowsHotkeyManager isolate.");
    Isolate.exit(sendPort);
  }

  int lowLevelKeyboardHookProc(int code, int wParam, int lParam) {
    if (code == HC_ACTION) {
      // Windows controls this memory; don't deallocate it.
      final kbs = Pointer<KBDLLHOOKSTRUCT>.fromAddress(lParam);

      if ((kbs.ref.flags & LLKHF_INJECTED) == 0) {
        Hotkey keyPress = Hotkey.fromKeyCode(
          kbs.ref.vkCode,
          ctrl: GetAsyncKeyState(VIRTUAL_KEY.VK_CONTROL) != 0,
          shift: GetAsyncKeyState(VIRTUAL_KEY.VK_SHIFT) != 0,
          alt: GetAsyncKeyState(VIRTUAL_KEY.VK_MENU) != 0,
        );

        if (wParam == WM_KEYUP && activeHotkey != null) {
          sendPort.send(HotkeyEvent(HotkeyEventType.hotkeyReleased, keyPress));
          activeHotkey = null;

          return CallNextHookEx(keyHook, code, wParam, lParam);
        }

        Hotkey? matchedHotkey;
        for (Hotkey hotkey in hotkeys) {
          if (hotkey.keySet != keyPress.keySet) continue;

          if (hotkey.context.contains("global")) {
            matchedHotkey = hotkey;
          }
          if (hotkey.context.contains(getKeyPressContext())) {
            matchedHotkey = hotkey;
            break;
          }
        }

        if (matchedHotkey != null && wParam == WM_KEYDOWN) {
          activeHotkey = matchedHotkey;
          sendPort.send(
              HotkeyEvent(HotkeyEventType.hotkeyTriggered, matchedHotkey));

          return -1;
        }

        return CallNextHookEx(keyHook, code, wParam, lParam);
      } else {
        if (kbs.ref.vkCode == 0xE8) {
          UnhookWindowsHookEx(keyHook);

          PostQuitMessage(0);
          return -1;
        }
      }
    }
    return CallNextHookEx(keyHook, code, wParam, lParam);
  }

  String? getKeyPressContext() {
    int foregroundWindow = GetForegroundWindow();

    if (foregroundWindow == NULL) return null;

    Pointer<DWORD> processId = calloc<DWORD>();
    GetWindowThreadProcessId(foregroundWindow, processId);

    int processHandle = OpenProcess(
        PROCESS_ACCESS_RIGHTS.PROCESS_QUERY_LIMITED_INFORMATION |
            PROCESS_ACCESS_RIGHTS.PROCESS_VM_READ,
        FALSE,
        processId.value);

    if (processHandle == NULL) return null;

    Pointer<Utf16> pathPointer = calloc<Uint16>(MAX_PATH).cast<Utf16>();
    int result =
        GetModuleFileNameEx(processHandle, NULL, pathPointer, MAX_PATH);

    if (result == 0) return null;

    String context = pathPointer.toDartString();
    free(pathPointer);
    free(processId);

    return context;
  }
}
