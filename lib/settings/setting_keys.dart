enum SettingKeys {
  escapeKey,
}

extension SettingKeysExtension on SettingKeys {
  String get key {
    switch (this) {
      case SettingKeys.escapeKey:
        return "escapeKey";
    }
  }
}