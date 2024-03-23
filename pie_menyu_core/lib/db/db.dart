library pie_menyu_core;

import 'dart:developer';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:pie_menyu_core/db/profile_exe.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';

import 'pie_item.dart';
import 'pie_menu.dart';
import 'profile.dart';

class Database {
  static const String dbFileName = "default.isar";

  final Isar _isar;

  Isar get isar => _isar;

  final String _dbPath;

  String get dbPath => _dbPath;

  Database(Directory dir)
      : _isar = Isar.openSync([
          ProfileSchema,
          PieMenuSchema,
          PieItemSchema,
          ProfileExeSchema,
        ], directory: dir.path),
        _dbPath = dir.path;

  initialize() async {
    // Create initial record if not existed
    final defaultProf = Profile(name: 'Default Profile');
    final defaultProfExe = ProfileExe(path: "global")
      ..profile.value = defaultProf;
    if (await _isar.profiles.count() == 0) {
      await _isar.writeTxn(() async {
        await _isar.profileExes.put(defaultProfExe);
        await _isar.profiles.put(defaultProf);
        await defaultProfExe.profile.save();
      });
    }
  }

  close() async {
    await _isar.close();
  }

  Future<List<Profile>> getProfiles({List<int> ids = const <int>[]}) async {
    if (ids.isEmpty) {
      return _isar.profiles.where().findAll();
    }
    return (await _isar.profiles.getAll(ids)).whereType<Profile>().toList();
  }

  Future<Profile?> getProfileByExe(String path) async {
    ProfileExe? profileExe =
        await _isar.profileExes.where().pathEqualTo(path).findFirst();

    if (profileExe == null) {
      return null;
    }

    await profileExe.profile.load();
    return profileExe.profile.value;
  }

  Future<List<PieMenuHotkey>> getAllHotkeys() async {
    final List<PieMenuHotkey> hotkeys = [];

    final List<Profile> profiles =
        await _isar.profiles.where().filter().enabledEqualTo(true).findAll();

    for (Profile profile in profiles) {
      hotkeys.addAll(profile.pieMenuHotkeys);
    }

    return hotkeys;
  }

  save(PieMenuState state) async {
    log("Saving pie menu state", name: "db.dart save()");
    final pieItems = state.pieItemDelegates.map((e) {
      if (e.pieItem != null && e.pieItem!.id < 0) {
        e.pieItem!.id = Isar.autoIncrement;
      }
      return e.pieItem;
    }).whereType<PieItem>();

    await putPieItems(pieItems.toList());
    for (PieItemDelegate pieItemInstance in state.pieItemDelegates) {
      pieItemInstance.pieItemId = pieItemInstance.pieItem!.id;
    }

    await putPieMenu(state.pieMenu);
  }

  Future<void> linkProfileToExe(Profile profile, String path) async {
    ProfileExe? profileExe =
        await _isar.profileExes.where().pathEqualTo(path).findFirst();
    profileExe ??= ProfileExe(path: path);

    profileExe.profile.value = profile;

    await isar.writeTxn(() async {
      await isar.profileExes.put(profileExe!);
      await profileExe.profile.save();
    });
  }

  Future<List<PieMenu>> getPieMenus({List<int> ids = const <int>[]}) async {
    if (ids.isEmpty) {
      return _isar.pieMenus.where().findAll();
    }
    return (await _isar.pieMenus.getAll(ids)).whereType<PieMenu>().toList();
  }

  Future<List<PieItem>> getPieItems({List<int> ids = const <int>[]}) async {
    if (ids.isEmpty) {
      return _isar.pieItems.where().findAll();
    }
    return (await _isar.pieItems.getAll(ids)).whereType<PieItem>().toList();
  }

  Future<void> addPieMenuToProfile(int pieMenuId, int profileId) async {
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

  Future<int> putProfile(Profile profile) async {
    late int profileId;
    await _isar.writeTxn(() async {
      profileId = await _isar.profiles.put(profile);
    });

    return profileId;
  }

  /// Insert when not existed, update when existed.
  Future<int> putPieMenu(PieMenu pieMenu) async {
    late int pieMenuId;
    await _isar.writeTxn(() async {
      pieMenuId = await _isar.pieMenus.put(pieMenu);
    });

    return pieMenuId;
  }

  Future<int> getPieMenuLinkedCount(int pieMenuId) async {
    PieMenu? pieMenu = await _isar.pieMenus.get(pieMenuId);
    if (pieMenu == null) {
      return 0;
    }

    return pieMenu.profiles.length;
  }

  Future<void> updateProfile(Profile profile) async {
    await _isar.writeTxn(() async {
      await _isar.profiles.put(profile);
    });
  }

  Future<void> updateProfileToPieMenuLinks(Profile profile) async {
    await _isar.writeTxn(() async {
      await profile.pieMenus.save();
    });
  }

  /// Insert when not existed, update when existed.
  /// [pieItem.id] will be set to the inserted id.
  @Deprecated("Use putPieItems")
  Future<void> putPieItem(PieItem pieItem) async {
    await _isar.writeTxn(() async {
      await _isar.pieItems.put(pieItem);
    });
  }

  Future<void> putPieItems(List<PieItem> pieItem) async {
    await _isar.writeTxn(() async {
      await _isar.pieItems.putAll(pieItem);
    });
  }

  addPieItemToPieMenuWithId(int pieItemID, int pieMenuId) async {
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

    pieMenu.pieItemInstances.add(PieItemDelegate(pieItemId: pieItem.id));
    await _isar.writeTxn(() async {
      await _isar.pieMenus.put(pieMenu);
    });
  }

  @Deprecated("Use createPieItemIn instead in the future")
  addPieItemsToPieMenu(List<PieItem> pieItems, PieMenu pieMenu) async {
    pieMenu.pieItemInstances
        .addAll(pieItems.map((e) => PieItemDelegate(pieItemId: e.id)));
    await _isar.writeTxn(() async {
      await _isar.pieMenus.put(pieMenu);
    });
  }

  Future<void> loadPieItemInstance(PieItemDelegate pieItemInstance) async {
    pieItemInstance.pieItem =
        await _isar.pieItems.get(pieItemInstance.pieItemId);
  }
}
