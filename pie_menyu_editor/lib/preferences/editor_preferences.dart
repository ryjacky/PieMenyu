import 'package:shared_preferences/shared_preferences.dart';

class EditorPreferences {
  final SharedPreferences _prefs;

  EditorPreferences(this._prefs);

  List<String> get seenCoachMarkList =>
      _prefs.getStringList("seenCoachMarkList") ?? [];

  set seenCoachMarkList(List<String> value) =>
      _prefs.setStringList("seenCoachMarkList", value);

  bool get showOnBoarding => _prefs.getBool("showOnBoarding") ?? true;

  set showOnBoarding(bool value) => _prefs.setBool("showOnBoarding", value);

}
