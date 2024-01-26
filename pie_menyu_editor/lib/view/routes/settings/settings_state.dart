import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:pie_menyu_core/db/db.dart';
import 'package:url_launcher/url_launcher.dart';

enum SettingsSection {
  general,
  data,
  about,
  language,
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

    // TODO: Implementation
  }
}
