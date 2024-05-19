import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_editor/view/routes/home/home_page_view_model.dart';

compareProfile(Profile profile1, Profile profile2) {
  return profile1.id == profile2.id &&
      profile1.name == profile2.name &&
      profile1.enabled == profile2.enabled &&
      profile1.name == profile2.name &&
      profile1.pieMenuHotkeys.length == profile2.pieMenuHotkeys.length &&
      profile1.iconBase64 == profile2.iconBase64;
}

comparePieMenu(PieMenu pieMenu1, PieMenu pieMenu2) {
  return pieMenu1.id == pieMenu2.id &&
      pieMenu1.name == pieMenu2.name &&
      pieMenu1.enabled == pieMenu2.enabled &&
      pieMenu1.colors == pieMenu2.colors &&
      pieMenu1.iconStyle == pieMenu2.iconStyle &&
      pieMenu1.font == pieMenu2.font &&
      pieMenu1.behavior == pieMenu2.behavior &&
      pieMenu1.shape == pieMenu2.shape &&
      pieMenu1.pieItemInstances.length == pieMenu2.pieItemInstances.length;
}

void main() {
  group('HomePageViewModel', () {
    test('updateState updates profiles and pieMenus', () async {
      await Isar.initializeIsarCore(download: true);
      // Arrange
      // Remove the existing database file
      final db = Database(Directory.systemTemp);
      await db.close(deleteFromDisk: true);

      final mockDb = Database(Directory.systemTemp);
      final viewModel = HomePageViewModel(mockDb);
      final mockProfiles = [
        Profile(name: "Profile 1"),
        Profile(name: "Profile 2")
      ];
      final mockPieMenus = [
        PieMenu()..name = "PieMenu 1",
        PieMenu()..name = "PieMenu 2"
      ];

      // Add mock data to the database
      await mockDb.putProfile(mockProfiles[0]);
      await mockDb.putProfile(mockProfiles[1]);
      await mockDb.putPieMenu(mockPieMenus[0]);
      await mockDb.putPieMenu(mockPieMenus[1]);
      await mockDb.addPieMenuToProfile(mockPieMenus[0].id, mockProfiles[0].id);
      await mockDb.addPieMenuToProfile(mockPieMenus[1].id, mockProfiles[1].id);

      // Act
      await viewModel.updateState();

      // Assert
      for (var i = 0; i < mockProfiles.length; i++) {
        expect(compareProfile(viewModel.profiles[i], mockProfiles[i]), true);
        expect(comparePieMenu(viewModel.pieMenus[i], mockPieMenus[i]), true);
      }
    });
  });
}
