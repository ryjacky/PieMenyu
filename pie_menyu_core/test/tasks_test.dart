import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:win32/win32.dart';

void main() {
  group('SendKeyTask', () {
    test('constructor initializes fields correctly', () {
      final task = SendKeyTask();
      expect(task.ctrl, isFalse);
      expect(task.shift, isFalse);
      expect(task.alt, isFalse);
      expect(task.key, isNull);
      expect(task.taskType, PieItemTaskType.sendKey);
    });

    test('constructor from PieItemTask initializes fields correctly', () {
      final pieItemTask = PieItemTask(
        arguments: ["true", "true", "false", "75"],
      );
      final task = SendKeyTask.from(pieItemTask);
      expect(task.ctrl, isTrue);
      expect(task.shift, isTrue);
      expect(task.alt, isFalse);
      expect(task.key, const LogicalKeyboardKey(75));
    });

    test('_fieldCheck ensures correct argument length', () {
      final task = PieItemTask(
        arguments: [""],
      );
      final sendKeyTask = SendKeyTask.from(task);

      expect(sendKeyTask.arguments, ["", "", "", ""]);
    });

    test('getters and setters work as expected', () {
      final task = SendKeyTask();

      task.ctrl = true;
      expect(task.ctrl, isTrue);

      task.shift = true;
      expect(task.shift, isTrue);

      task.alt = true;
      expect(task.alt, isTrue);

      task.key = LogicalKeyboardKey.keyA;
      expect(task.key, LogicalKeyboardKey.keyA);
    });

    test('hotkeyStrings returns a formatted string of keys', () {
      final task = SendKeyTask();
      task.ctrl = true;
      task.shift = true;
      task.key = LogicalKeyboardKey.keyA;
      expect(task.hotkeyStrings, ["Ctrl", "Shift", "A"]);
    });

    test(
        'SendKeyTask simulates pressing Ctrl+Shift+Esc to open the Task Manager',
        () async {
      print("+---------------------------------------------------+");
      print("|                   Important                       |");
      print("| Close Task Manager! We use the task manager to    |");
      print("| check if SendKeyTask sends the key or not!        |");
      print("+---------------------------------------------------+");
      print("Continuing in 10 seconds...");
      await Future.delayed(const Duration(seconds: 10), () {});

      if (isTaskManagerOpened()) {
        print("Task Manager is already opened!");
        print("Please close Task Manager to continue the test.");
        throw Error();
      }
      final task = SendKeyTask();
      task.ctrl = true;
      task.shift = true;
      task.key = LogicalKeyboardKey.escape;

      task.execute();

      await Future.delayed(const Duration(seconds: 5), () {});
      expect(isTaskManagerOpened(), true);
    });
  });
}

bool isTaskManagerOpened() {
  bool opened = false;
  int enumWindowsProc(int hWnd, int lParam) {
    // Don't enumerate windows unless they are marked as WS_VISIBLE
    if (IsWindowVisible(hWnd) == FALSE) return TRUE;

    final length = GetWindowTextLength(hWnd);
    if (length == 0) {
      return TRUE;
    }

    final buffer = wsalloc(length + 1);
    GetWindowText(hWnd, buffer, length + 1);
    if (buffer.toDartString().contains("Task Manager")) {
      opened = true;
    }
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

  enumerateWindows();
  return opened;
}
