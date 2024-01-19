library pie_menyu_core;

import 'dart:developer';
import 'dart:io';

import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:isar/isar.dart';
import 'package:pie_menyu_core/db/profile_exe.dart';

import 'pie_item.dart';
import 'pie_item_task.dart';
import 'pie_menu.dart';
import 'profile.dart';

class DB {
  static late Isar _isar;

  static Isar get isar => _isar;

  static String _dbPath = "";
  static String get dbPath => _dbPath;

  static const String dbFileName = "default.isar";

  static initialize(Directory dbPath) async {
    _dbPath = dbPath.path;
    DB._isar = await Isar.open(
        [ProfileSchema, PieMenuSchema, PieItemSchema, PieItemTaskSchema, ProfileExeSchema],
        directory: _dbPath);

    final defaultProf = Profile(name: 'Default Profile');
    final defaultProfExe = ProfileExe(path: "global")..profile.value = defaultProf;

    // Create initial record if not existed
    if (await _isar.profiles.count() == 0) {
      await _isar.writeTxn(() async {
        await _isar.profileExes.put(defaultProfExe);
        await _isar.profiles.put(defaultProf);
        await defaultProfExe.profile.save();
      });
    }
  }

  static close() async {
    await _isar.close();
  }

  static Future<List<Profile>> getProfiles(
      {List<int> ids = const <int>[]}) async {
    if (ids.isEmpty) {
      return _isar.profiles.where().findAll();
    }
    return (await _isar.profiles.getAll(ids)).whereType<Profile>().toList();
  }

  static Future<Profile?> getProfileByExe(String path) async {
    ProfileExe? profileExe = await _isar.profileExes.where().pathEqualTo(path).findFirst();

    if (profileExe == null) {
      return null;
    }

    await profileExe.profile.load();
    return profileExe.profile.value;
  }

  static Future<Map<String, List<HotKey>>> getExeToHotkeyMap() async {
    final Map<String, List<HotKey>> exeToHotkeyMap = {};

    final List<ProfileExe> profileExes = await _isar.profileExes.where().findAll();
    for (ProfileExe profileExe in profileExes) {
      await profileExe.profile.load();
      final Profile? profile = profileExe.profile.value;

      if (profile == null) {
        log("Profile not found, id: ${profileExe.profile}");
        continue;
      }

      final List<HotKey> hotkeys = [];
      for (HotkeyToPieMenuId hotkeyToPieMenuId in profile.hotkeyToPieMenuIdList) {
        hotkeys.add(HotKey(hotkeyToPieMenuId.keyCode,
            modifiers: hotkeyToPieMenuId.keyModifiers,
            scope: HotKeyScope.system));
      }

      exeToHotkeyMap[profileExe.path] = hotkeys;
    }

    return exeToHotkeyMap;
  }

  static Future<void> linkProfileToExe(Profile profile, String path) async {
    ProfileExe? profileExe = await _isar.profileExes.where().pathEqualTo(path).findFirst();
    profileExe ??= ProfileExe(path: path);

    profileExe.profile.value = profile;

    await isar.writeTxn(() async {
      await isar.profileExes.put(profileExe!);
      await profileExe.profile.save();
    });
  }

  static Future<List<PieMenu>> getPieMenus(
      {List<int> ids = const <int>[]}) async {
    if (ids.isEmpty) {
      return _isar.pieMenus.where().findAll();
    }
    return (await _isar.pieMenus.getAll(ids)).whereType<PieMenu>().toList();
  }

  static Future<List<PieItem>> getPieItems(
      {List<int> ids = const <int>[]}) async {
    if (ids.isEmpty) {
      return _isar.pieItems.where().findAll();
    }
    return (await _isar.pieItems.getAll(ids)).whereType<PieItem>().toList();
  }

  static Future<void> addPieMenuToProfile(int pieMenuId, int profileId) async {
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
      // Isar automatically handles duplicated case for IsarLinks and will
      // not add if existed
      await profile.pieMenus.save();
    });
  }

  static Future<int> putProfile(Profile profile) async {
    late int profileId;
    await _isar.writeTxn(() async {
      profileId = await _isar.profiles.put(profile);
    });

    return profileId;
  }

  /// Insert when not existed, update when existed.
  static Future<int> putPieMenu(PieMenu pieMenu) async {
    late int pieMenuId;
    await _isar.writeTxn(() async {
      pieMenuId = await _isar.pieMenus.put(pieMenu);
    });

    return pieMenuId;
  }

  static Future<int> getPieMenuLinkedCount(int pieMenuId) async {
    PieMenu? pieMenu = await _isar.pieMenus.get(pieMenuId);
    if (pieMenu == null) {
      return 0;
    }

    return pieMenu.profiles.length;
  }

  static Future<void> updateProfile(Profile profile) async {
    await _isar.writeTxn(() async {
      await _isar.profiles.put(profile);
    });
  }

  static Future<void> updateProfileToPieMenuLinks(Profile profile) async {
    await _isar.writeTxn(() async {
      await profile.pieMenus.save();
    });
  }

  /// Insert when not existed, update when existed.
  /// [pieItem.id] will be set to the inserted id.
  @Deprecated("Use putPieItems")
  static Future<void> putPieItem(PieItem pieItem) async {
    await _isar.writeTxn(() async {
      await _isar.pieItems.put(pieItem);
    });
  }

  static Future<void> putPieItems(List<PieItem> pieItem) async {
    await _isar.writeTxn(() async {
      await _isar.pieItems.putAll(pieItem);
    });
  }

  static addPieItemToPieMenuWithId(int pieItemID, int pieMenuId) async {
    List<dynamic> result = await Future.wait([
      _isar.pieItems.get(pieItemID),
      _isar.pieMenus.get(pieMenuId),
    ]);

    PieItem? pieItem = result[0];
    if (pieItem == null) {
      log("Pie item not found, id: $pieItemID");
      return;
    }

    PieMenu? pieMenu = result[1];
    if (pieMenu == null) {
      log("Pie menu not found, id: $pieMenuId");
      return;
    }

    throw UnimplementedError();

    // pieMenu.pieItems.add(pieItem);
    // await _isar.writeTxn(() async {
    //   // Isar automatically handles duplicated case for IsarLinks and will
    //   // not add if existed
    //   await pieMenu.pieItems.save();
    // });
  }

  static addPieItemsToPieMenu(List<PieItem> pieItems, PieMenu pieMenu) async {
    throw UnimplementedError();
    // pieMenu.pieItems.addAll(pieItems);
    // await _isar.writeTxn(() async {
    //   // Isar automatically handles duplicated case for IsarLinks and will
    //   // not add if existed
    //   await pieMenu.pieItems.save();
    // });
  }

  static Future<List<PieItem>> getPieItemsOf(PieMenu pieMenu) async {
    return getPieItems(ids: pieMenu.pieItemInstances.map((e) => e.pieItemId).toList());
  }

  /// Quoted from https://isar.dev/docs/
  /// Insert or update a list of objects.
  /// Returns the list of ids of the new or updated objects.
  /// If the objects have an non-final id property,
  /// it will be set to the assigned id.
  /// Otherwise you should use the returned ids to update the objects.
  static Future<void> putPieItemTasks(List<PieItemTask> tasks) async {
    await _isar.writeTxn(() async {
      await _isar.pieItemTasks.putAll(tasks);
    });
  }
}
