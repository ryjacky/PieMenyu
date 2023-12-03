import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_menyu/db/pie_item.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/db/profile.dart';
import 'package:pie_menyu/db/profile_hotkey_to_pie_menu_id.dart';

class DB {
  static late Isar _isar;

  static initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    DB._isar = await Isar.open([
      ProfileSchema,
      PieMenuSchema,
      PieItemSchema,
      ProfileHotkeyToPieMenuIdSchema
    ], directory: dir.path);

    // Create initial record if not existed
    if (await _isar.profiles.count() == 0) {
      await _isar.writeTxn(() async {
        await _isar.profiles.put(Profile(name: 'Default Profile'));
      });
    }
  }

  static Future<List<Profile>> getProfiles(
      {List<int> ids = const <int>[]}) async {
    if (ids.isEmpty) {
      return _isar.profiles.where().findAll();
    }
    return (await _isar.profiles.getAll(ids)).whereType<Profile>().toList();
  }

  static Future<List<PieMenu>> getPieMenus(
      {List<int> ids = const <int>[]}) async {
    if (ids.isEmpty) {
      return _isar.pieMenus.where().findAll();
    }
    return (await _isar.pieMenus.getAll(ids)).whereType<PieMenu>().toList();
  }

  static addPieMenuToProfile(int pieMenuId, int profileId) async {
    int count = await _isar.profileHotkeyToPieMenuIds
        .where()
        .profileIdEqualTo(profileId)
        .filter()
        .pieMenuIdEqualTo(pieMenuId)
        .count();

    if (count != 0) {
      return;
    }

    await _isar.writeTxn(() async {
      await _isar.profileHotkeyToPieMenuIds.put(
          ProfileHotkeyToPieMenuId(profileId: profileId, pieMenuId: pieMenuId));
    });
  }

  static Future<int> createPieMenu(PieMenu pieMenu) async {
    late int newPieMenuId;
    await _isar.writeTxn(() async {
      newPieMenuId = await _isar.pieMenus.put(pieMenu);
    });

    return newPieMenuId;
  }

  static Future<int> getPieMenuLinkedCount(int pieMenuId) async {
    return await _isar.profileHotkeyToPieMenuIds
        .where()
        .pieMenuIdEqualTo(pieMenuId)
        .count();
  }

  static Future<List<int>> getProfilePieMenuIds(int profileId) async {
    return (await _isar.profileHotkeyToPieMenuIds
            .where()
            .profileIdEqualTo(profileId)
            .findAll())
        .map((e) => e.pieMenuId)
        .toList();
  }
}
