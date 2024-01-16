import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;
import 'package:pie_menyu_core/db/db.dart';
import 'package:url_launcher/url_launcher.dart';

enum SettingsSection {
  general,
  about,
}

class SettingsState extends ChangeNotifier {
  SettingsSection _selectedSection = SettingsSection.general;

  SettingsSection get selectedSection => _selectedSection;
  set selectedSection(SettingsSection section) {
    _selectedSection = section;
    notifyListeners();
  }

  Future<void> exportDataThenShowDir() async {
    String? result = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
      await File(p.join(DB.dbPath, DB.dbFileName))
          .copy(p.join(result, "data.isar"));
      launchUrl(Uri.parse("file:///$result"));
    }
  }
}