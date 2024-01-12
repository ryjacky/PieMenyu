library pie_menyu_core;

import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'pie_item.dart';
import 'pie_item_task.dart';
import 'pie_menu.dart';
import 'profile.dart';

class DB {
  static late Isar _isar;

  static Isar get isar => _isar;

  static initialize() async {
    final dir = await getApplicationSupportDirectory();
    DB._isar = await Isar.open(
        [ProfileSchema, PieMenuSchema, PieItemSchema, PieItemTaskSchema],
        directory: p.join(dir.parent.path, 'PieMenyu'));

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

  static Future<List<Profile>> getProfilesByExe(String exe) async {
    return (await _isar.profiles
            .where()
            .filter()
            .exesElementContains(exe)
            .findAll())
        .whereType<Profile>()
        .toList();
  }

  static Future<List<PieMenu>> getPieMenus(
      {List<int> ids = const <int>[]}) async {
    if (ids.isEmpty) {
      return _isar.pieMenus.where().findAll();
    }
    return (await _isar.pieMenus.getAll(ids)).whereType<PieMenu>().toList();
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

  static void updateProfile(Profile profile) async {
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
  static Future<void> putPieItem(PieItem pieItem) async {
    await _isar.writeTxn(() async {
      await _isar.pieItems.put(pieItem);
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

    pieMenu.pieItems.add(pieItem);
    await _isar.writeTxn(() async {
      // Isar automatically handles duplicated case for IsarLinks and will
      // not add if existed
      await pieMenu.pieItems.save();
    });
  }

  static addPieItemsToPieMenu(List<PieItem> pieItems, PieMenu pieMenu) async {
    pieMenu.pieItems.addAll(pieItems);
    await _isar.writeTxn(() async {
      // Isar automatically handles duplicated case for IsarLinks and will
      // not add if existed
      await pieMenu.pieItems.save();
    });
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

  @Deprecated("Use updatePieItemTasks instead")
  static addTasksToPieItem(List<PieItemTask> tasks, PieItem pieItem) {
    pieItem.tasks.addAll(tasks);
    _isar.writeTxn(() async {
      pieItem.tasks.save();
    });
  }

  static updatePieItemTasks(List<PieItemTask> tasks, PieItem pieItem) {
    final taskToDelete = [];
    for (PieItemTask task in pieItem.tasks) {
      if (!tasks.contains(task)) {
        taskToDelete.add(task);
      }
    }

    pieItem.tasks.removeAll(taskToDelete);
    pieItem.tasks.addAll(tasks);

    _isar.writeTxn(() async {
      pieItem.tasks.save();
    });
  }
}
