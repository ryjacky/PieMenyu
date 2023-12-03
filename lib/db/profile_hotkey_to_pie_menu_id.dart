import 'package:isar/isar.dart';

part 'profile_hotkey_to_pie_menu_id.g.dart';

@collection
class ProfileHotkeyToPieMenuId {
  Id id = Isar.autoIncrement;

  @Index()
  int profileId = 0;

  bool ctrl = false;
  bool shift = false;
  bool alt = false;
  String key = "";

  @Index()
  int pieMenuId = 0;

  ProfileHotkeyToPieMenuId({
    this.profileId = 0,
    this.ctrl = false,
    this.shift = false,
    this.alt = false,
    this.key = "",
    this.pieMenuId = 0,
  });
}