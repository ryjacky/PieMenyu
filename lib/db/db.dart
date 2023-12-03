import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_menyu/db/pie_item.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/db/profile.dart';

class DB {
  static late Isar _isar;

  static initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    DB._isar = await Isar.open([
      ProfileSchema,
      PieMenuSchema,
      PieItemSchema,
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
    List<dynamic> result = await Future.wait([
      _isar.profiles.get(profileId),
      _isar.pieMenus.get(pieMenuId),
    ]);

    Profile? profile = result[0];
    if (profile == null) {
      log("Profile not found, id: $profileId");
      return;
    }

    PieMenu? pieMenu = result[1];
    if (pieMenu == null) {
      log("Pie menu not found, id: $pieMenuId");
      return;
    }

    profile.pieMenus.add(pieMenu);
    await _isar.writeTxn(() async {
      await profile.pieMenus.save();
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
     PieMenu? pieMenu = await _isar.pieMenus.get(pieMenuId);
     if (pieMenu == null) {
       return 0;
     }

     return pieMenu.profiles.length;
  }

  static Future<List<int>> getProfilePieMenuIds(int profileId) async {
    // get profile
    Profile? profile = await _isar.profiles.get(profileId);
    if (profile == null) {
      log("Profile not found, id: $profileId");
      return [];
    }

    return profile.pieMenus.map((e) => e.id).toList();
  }
}
