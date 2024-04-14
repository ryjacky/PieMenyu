import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/db.dart';

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
