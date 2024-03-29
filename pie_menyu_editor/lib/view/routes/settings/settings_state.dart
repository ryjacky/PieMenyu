import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pie_menyu_core/db/db.dart';
import '../../../main.dart';
import 'package:url_launcher/url_launcher.dart';

enum SettingsSection {
  general,
  data,
  about,
}

class SettingsState extends ChangeNotifier {
  SettingsSection _selectedSection = SettingsSection.general;

  SettingsSection get selectedSection => _selectedSection;

  set selectedSection(SettingsSection section) {
    _selectedSection = section;
    notifyListeners();
  }
  
  Database _db;
  
  SettingsState(this._db);

  Future<void> exportDataThenShowDir() async {
    String? result = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
      await File(p.join(_db.dbPath, Database.dbFileName))
          .copy(p.join(result, "default.isar"));
      launchUrl(Uri.parse("file:///$result"));
    }
  }

  Future<void> importData() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["isar"],
    );

    if (result?.paths.firstOrNull != null) {
      final dbPath = (await getApplicationSupportDirectory()).parent;
      try {
        _db.close();
      } catch (e) {
        log("DB already closed");
      }

      final dest = File(p.join(dbPath.path, Database.dbFileName));
      if (await dest.exists()) {
        await dest.delete();
      }
      await File(result!.paths.first!).copy(dest.path);
      await _db.initialize(dbPath);
    }
  }
}
