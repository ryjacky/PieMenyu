library pie_menyu_core;

import 'dart:io';

import 'package:pie_menyu_core/db/pie_item_task.dart';

import '../executor/executable.dart';

class OpenFolderTask extends PieItemTask with Executable {
  OpenFolderTask() : super(taskType: PieItemTaskType.openFolder) {
    _fieldCheck();
  }

  OpenFolderTask.from(PieItemTask pieItemTask) : super.from(pieItemTask) {
    _fieldCheck();
  }

  _fieldCheck() {
    if (arguments.length != 1) {
      arguments = [""];
    }
    taskType = PieItemTaskType.openFolder;
  }

  set folderPath(String value) {
    arguments = [value];
  }

  String get folderPath => arguments[0];

  @override
  Future<void> execute() async {
    if (Platform.isWindows) {
      await Process.run("explorer", [folderPath], runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run("open", [folderPath], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run("xdg-open", [folderPath], runInShell: true);
    }
  }
}
