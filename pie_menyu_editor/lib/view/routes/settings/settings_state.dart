import 'package:flutter/cupertino.dart';

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
}