import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_menyu/db/pie_item.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/db/profile.dart';

class DB {
  static late Isar _isar;

  static initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    DB._isar = await Isar.open([ProfileSchema, PieMenuSchema, PieItemSchema],
        directory: dir.path);

    // Create initial record if not existed
    if (await _isar.profiles.count() == 0) {
      await _isar.writeTxn(() async {
        int newPieItemId = await _isar.pieItems.put(PieItem());
        int newPieMenuId =
            await _isar.pieMenus.put(PieMenu(pieItemIds: [newPieItemId]));

        await _isar.profiles.put(Profile(
            hotkeyToPieMenuID: [HotkeyToPieMenuId(pieMenuId: newPieMenuId)]));
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
    await _isar.writeTxn(() async {
      Profile? profile = await _isar.profiles.get(profileId);
      if (profile == null) {
        return;
      }

      if (profile.hotkeyToPieMenuID
          .any((element) => element.pieMenuId == pieMenuId)) {
        return;
      }

      profile.hotkeyToPieMenuID.add(HotkeyToPieMenuId(pieMenuId: pieMenuId));
      await _isar.profiles.put(profile);
    });
  }

  static Future<int> createPieMenu(PieMenu pieMenu) async {
    late int newPieMenuId;
    await _isar.writeTxn(() async {
      newPieMenuId = await _isar.pieMenus.put(pieMenu);
      await _isar.profiles.put(Profile(
          hotkeyToPieMenuID: [HotkeyToPieMenuId(pieMenuId: newPieMenuId)]));
    });

    return newPieMenuId;
  }
}
