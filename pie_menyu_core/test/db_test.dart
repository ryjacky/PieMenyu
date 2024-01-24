import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_menyu_core/db/DB.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_core/db/profile_exe.dart';
import 'package:path/path.dart' as p;

void main() {

  setUpAll(() async {
    final isarFile = File(p.join(Directory.systemTemp.path, "default.isar"));
    if (await isarFile.exists()) {
      await isarFile.delete(recursive: true);
    }

    WidgetsFlutterBinding.ensureInitialized();
    await Isar.initializeIsarCore(download: true);
    await DB.initialize(isarFile.parent);
  });

  group('DB Tests', () {
    test('test_initialize', () async {

      // Verify that the Isar database is initialized correctly.
      expect(DB.isar, isNotNull);

      // Check that the default profile and profile exe are created.
      final defaultProfile = await DB.getProfileByExe('global');
      expect(defaultProfile, isNotNull);
      expect(defaultProfile!.name, 'Default Profile');
    });

    test('test_getProfiles', () async {
      // Create a few profiles.
      final profile1 = Profile(name: 'Profile 1');
      final profile2 = Profile(name: 'Profile 2');
      await DB.putProfile(profile1);
      await DB.putProfile(profile2);

      // Get all profiles.
      final profiles = await DB.getProfiles();

      // Verify that the profiles are returned correctly.
      expect(profiles.length, 3);
      expect(profiles[0].name, 'Default Profile');
      expect(profiles[1].name, 'Profile 1');
      expect(profiles[2].name, 'Profile 2');
    });

    test('test_getProfileByExe', () async {
      const exe = "";
      // Create a profile and a profile exe.
      final profile = Profile(name: 'Profile 1');
      final profileExe = ProfileExe(path: exe);
      profileExe.profile.value = profile;
      await DB.isar.writeTxn(() async {
        await DB.isar.profiles.put(profile);
        await DB.isar.profileExes.put(profileExe);
        await profileExe.profile.save();
      });

      // Get the profile by exe.
      final profileByExe = await DB.getProfileByExe(exe);

      // Verify that the profile is returned correctly.
      expect(profileByExe, isNotNull);
      expect(profileByExe!.name, 'Profile 1');
    });

    test('test_getProfileByExe', () async {
      const exe = "YEAHYEAH/THIS/IS/THE/EXE/PATH";
      // Create a profile and a profile exe.
      final profile = Profile(name: 'Profile 1');
      await DB.isar.writeTxn(() async {
        await DB.isar.profiles.put(profile);
      });
      final profileExe = ProfileExe(path: exe);
      profileExe.profile.value = profile;
      await DB.isar.writeTxn(() async {
        await DB.isar.profileExes.put(profileExe);
        await profileExe.profile.save();
      });

      // Get the profile by exe.
      final profileByExe = await DB.getProfileByExe(exe);

      // Verify that the profile is returned correctly.
      expect(profileByExe, isNotNull);
      expect(profileByExe!.name, 'Profile 1');
    });

    test('test_getExeToHotkeyMap', () async {
      // remove all profile exes
      await DB.isar.writeTxn(() async {
        await DB.isar.profileExes.where().deleteAll();
      });
      // Create a few profiles and profile exes.
      final profile1 = Profile(name: 'Profile 11143225');
      final profile2 = Profile(name: 'Profile 25937860');
      // Put the profiles
      await DB.isar.writeTxn(() async {
        await DB.isar.profiles.put(profile1);
        await DB.isar.profiles.put(profile2);
      });

      DB.linkProfileToExe(profile1, "global199348503");
      DB.linkProfileToExe(profile2, "global2339481055");

      // Create a few hotkey to pie menu id mappings.
      final hotkeyToPieMenuId1 = HotkeyToPieMenuId(
        keyCode: KeyCode.keyC,
        keyModifiers: [KeyModifier.control],
        pieMenuId: 1,
      );
      final hotkeyToPieMenuId2 = HotkeyToPieMenuId(
        keyCode: KeyCode.keyD,
        keyModifiers: [KeyModifier.alt],
        pieMenuId: 2,
      );
      profile1.hotkeyToPieMenuIdList.add(hotkeyToPieMenuId1);
      profile2.hotkeyToPieMenuIdList.add(hotkeyToPieMenuId2);
      await DB.putProfile(profile1);
      await DB.putProfile(profile2);

      // Get the exe to hotkey map.
      final exeToHotkeyMap = await DB.getExeToHotkeyMap();

      // Verify that the exe to hotkey map is returned correctly.
      expect(exeToHotkeyMap.length, 2);
      expect(exeToHotkeyMap['global199348503']!.length, 1);
      expect(exeToHotkeyMap['global199348503']![0].keyCode, KeyCode.keyC);
      expect(exeToHotkeyMap['global199348503']![0].modifiers, [KeyModifier.control]);
      expect(exeToHotkeyMap['global2339481055']!.length, 1);
      expect(exeToHotkeyMap['global2339481055']![0].keyCode, KeyCode.keyD);
      expect(exeToHotkeyMap['global2339481055']![0].modifiers, [KeyModifier.alt]);
    });

    test('test_linkProfileToExe', () async {
      // Create a profile and a profile exe.
      final profile = Profile(name: 'Profile 1234');
      DB.isar.writeTxn(() async {
        await DB.isar.profiles.put(profile);
      });
      // Link the profile to the exe.
      await DB.linkProfileToExe(profile, 'global1234');

      // Get the profile by exe.
      final profileByExe = await DB.getProfileByExe('global1234');

      // Verify that the profile is linked to the exe correctly.
      expect(profileByExe, isNotNull);
      expect(profileByExe!.name, 'Profile 1234');
    });

    test('test_getPieMenus', () async {
      // Create a few pie menus.
      final pieMenu1 = PieMenu(name: 'Pie Menu 1');
      final pieMenu2 = PieMenu(name: 'Pie Menu 2');
      await DB.putPieMenu(pieMenu1);
      await DB.putPieMenu(pieMenu2);

      // Get all pie menus.
      final pieMenus = await DB.getPieMenus();

      // Verify that the pie menus are returned correctly.
      expect(pieMenus.length, 2);
      expect(pieMenus[0].name, 'Pie Menu 1');
      expect(pieMenus[1].name, 'Pie Menu 2');
    });

    test('test_addPieMenuToProfile', () async {
      // Create a profile and a pie menu.
      final profile = Profile(name: 'Profile 1');
      final pieMenu = PieMenu(name: 'Pie Menu 1');
      await DB.putProfile(profile);
      await DB.putPieMenu(pieMenu);

      // Add the pie menu to the profile.
      await DB.addPieMenuToProfile(pieMenu.id, profile.id);

      // Get the profile with the pie menu.
      final profileWithPieMenu = await DB.isar.profiles.get(profile.id);

      // Verify that the pie menu is added to the profile correctly.
      expect(profileWithPieMenu!.pieMenus.length, 1);
      expect(profileWithPieMenu.pieMenus.elementAt(0).name, 'Pie Menu 1');
    });

    test('test_putProfile', () async {
      // Create a profile.
      final profile = Profile(name: 'Profile 1');

      // Insert the profile.
      final profileId = await DB.putProfile(profile);

      // Get the profile by id.
      final profileById = await DB.isar.profiles.get(profileId);

      // Verify that the profile is inserted correctly.
      expect(profileById, isNotNull);
      expect(profileById!.name, 'Profile 1');
    });

    test('test_putPieMenu', () async {
      // Create a pie menu.
      final pieMenu = PieMenu(name: 'Pie Menu 1');

      // Insert the pie menu.
      final pieMenuId = await DB.putPieMenu(pieMenu);

      // Get the pie menu by id.
      final pieMenuById = await DB.isar.pieMenus.get(pieMenuId);

      // Verify that the pie menu is inserted correctly.
      expect(pieMenuById, isNotNull);
      expect(pieMenuById!.name, 'Pie Menu 1');
    });

    test('test_getPieMenuLinkedCount', () async {
      // Create a profile and a pie menu.
      final profile = Profile(name: 'Profile 1');
      final pieMenu = PieMenu(name: 'Pie Menu 1');
      await DB.putProfile(profile);
      await DB.putPieMenu(pieMenu);

      // Add the pie menu to the profile.
      await DB.addPieMenuToProfile(pieMenu.id, profile.id);

      // Get the linked count of the pie menu.
      final linkedCount = await DB.getPieMenuLinkedCount(pieMenu.id);

      // Verify that the linked count is correct.
      expect(linkedCount, 1);
    });

    test('test_updateProfile', () async {
      // Create a profile.
      final profile = Profile(name: 'Profile 1');
      await DB.putProfile(profile);

      // Update the profile name.
      profile.name = 'Profile 2';
      await DB.updateProfile(profile);

      // Get the profile by id.
      final profileById = await DB.isar.profiles.get(profile.id);

      // Verify that the profile is updated correctly.
      expect(profileById, isNotNull);
      expect(profileById!.name, 'Profile 2');
    });

    test('test_updateProfileToPieMenuLinks', () async {
      // Create a profile and a pie menu.
      final profile = Profile(name: 'Profile 1');
      final pieMenu = PieMenu(name: 'Pie Menu 1');
      await DB.putProfile(profile);
      await DB.putPieMenu(pieMenu);

      // Add the pie menu to the profile.
      await DB.addPieMenuToProfile(pieMenu.id, profile.id);

      // Update the profile to pie menu links.
      await DB.updateProfileToPieMenuLinks(profile);

      // Get the profile with the pie menu.
      final profileWithPieMenu = await DB.isar.profiles.get(profile.id);

      // Verify that the pie menu is added to the profile correctly.
      expect(profileWithPieMenu!.pieMenus.length, 1);
      expect(profileWithPieMenu.pieMenus.elementAt(0).name, 'Pie Menu 1');
    });

    test('test_putPieItem', () async {
      // Create a pie item.
      final pieItem = PieItem(displayName: 'Pie Item 1');

      // Insert the pie item.
      await DB.putPieItem(pieItem);

      // Get the pie item by id.
      final pieItemById = await DB.isar.pieItems.get(pieItem.id);

      // Verify that the pie item is inserted correctly.
      expect(pieItemById, isNotNull);
      expect(pieItemById!.displayName, 'Pie Item 1');
    });

    test('test_addPieItemToPieMenuWithId', () async {
      // Create a pie item and a pie menu.
      final pieItem = PieItem(displayName: 'Pie Item 1');
      final pieMenu = PieMenu(name: 'Pie Menu 1');
      await DB.putPieItem(pieItem);
      await DB.putPieMenu(pieMenu);

      // Add the pie item to the pie menu.
      await DB.addPieItemToPieMenuWithId(pieItem.id, pieMenu.id);

      // Get the pie menu with the pie item.
      final pieMenuWithPieItem = await DB.isar.pieMenus.get(pieMenu.id);

      // Verify that the pie item is added to the pie menu correctly.
      expect(pieMenuWithPieItem!.pieItems.length, 1);
      expect(pieMenuWithPieItem.pieItems.elementAt(0).displayName, 'Pie Item 1');
    });

    test('test_addPieItemsToPieMenu', () async {
      // Create a few pie items and a pie menu.
      final pieItem1 = PieItem(displayName: 'Pie Item 1');
      final pieItem2 = PieItem(displayName: 'Pie Item 2');
      final pieMenu = PieMenu(name: 'Pie Menu 1');
      await DB.putPieItem(pieItem1);
      await DB.putPieItem(pieItem2);
      await DB.putPieMenu(pieMenu);

      // Add the pie items to the pie menu.
      await DB.addPieItemsToPieMenu([pieItem1, pieItem2], pieMenu);

      // Get the pie menu with the pie items.
      final pieMenuWithPieItems = await DB.isar.pieMenus.get(pieMenu.id);

      // Verify that the pie items are added to the pie menu correctly.
      expect(pieMenuWithPieItems!.pieItems.length, 2);
      expect(pieMenuWithPieItems.pieItems.elementAt(0).displayName, 'Pie Item 1');
      expect(pieMenuWithPieItems.pieItems.elementAt(1).displayName, 'Pie Item 2');
    });

    test('test_putPieItemTasks', () async {
      // Create a few pie item tasks.
      final pieItemTask1 = PieItemTask(repeat: 234);
      final pieItemTask2 = PieItemTask(repeat: 243);

      // Insert the pie item tasks.
      await DB.putPieItemTasks([pieItemTask1, pieItemTask2]);

      // Get the pie item tasks by id.
      final pieItemTaskById1 = await DB.isar.pieItemTasks.get(pieItemTask1.id);
      final pieItemTaskById2 = await DB.isar.pieItemTasks.get(pieItemTask2.id);

      // Verify that the pie item tasks are inserted correctly.
      expect(pieItemTaskById1, isNotNull);
      expect(pieItemTaskById1!.repeat, 234);
      expect(pieItemTaskById2, isNotNull);
      expect(pieItemTaskById2!.repeat, 243);
    });

  });
}