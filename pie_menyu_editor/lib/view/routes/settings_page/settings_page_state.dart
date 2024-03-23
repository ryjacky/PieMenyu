import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:pie_menyu_core/db/db.dart';
import 'package:url_launcher/url_launcher.dart';

@protected
enum SettingsSection {
  general,
  data,
  about,
  language,
}

@protected
class SettingsPageState extends ChangeNotifier {
  SettingsSection _selectedSection = SettingsSection.general;

  SettingsSection get selectedSection => _selectedSection;

  set selectedSection(SettingsSection section) {
    _selectedSection = section;
    notifyListeners();
  }
  
  final Database _db;
  
  SettingsPageState(this._db);

  Future<void> exportDataThenShowDir() async {

  }

  Future<void> importData() async {
  }
}
