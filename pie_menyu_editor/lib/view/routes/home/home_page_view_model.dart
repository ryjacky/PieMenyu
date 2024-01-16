import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';

class HomePageViewModel extends ChangeNotifier {
  List<Profile> profiles = [];
  List<PieMenu> pieMenus = [];

  Profile _activeProfile = Profile(name: "Loading...");
  Profile get activeProfile => _activeProfile;
  set activeProfile(Profile profile) {
    _activeProfile = profile;
    notifyListeners();
  }

  HomePageViewModel() {
    updateState();
  }

  updateState() async {
    log("Fetching state...");

    profiles = await DB.getProfiles();
    pieMenus = await DB.getPieMenus();

    activeProfile = profiles.firstOrNull ?? Profile(name: "Loading...");
    notifyListeners();
  }

  Iterable<PieMenu> getPieMenusOf(Profile profile) {
    return pieMenus.where((element) => element.profiles
        .where((element) => element.id == profile.id)
        .isNotEmpty);
  }

  Iterable<PieMenu> getAllPieMenusExceptIn(Profile profile) {
    return pieMenus.where((element) =>
        element.profiles.where((element) => element.id == profile.id).isEmpty);
  }

  Future<void> createProfile(
      String profName, String exePath, String profIcon) async {
    if (await DB.getProfileByExe(exePath) != null) {
      throw Exception("This application is already added to a profile.");
    }

    final profile = Profile()
      ..name = profName
      ..iconBase64 = profIcon;

    await DB.putProfile(profile);
    await DB.linkProfileToExe(profile, exePath);

    await updateState();
  }

  Future<void> addPieMenuTo(Profile profile, PieMenu pieMenu) async {
    await DB.addPieMenuToProfile(pieMenu.id, profile.id);
    await updateState();
  }

  Future<void> removePieMenuFrom(Profile profile, PieMenu pieMenu) async {
    profile.pieMenus.remove(pieMenu);
    await DB.updateProfileToPieMenuLinks(profile);
    await updateState();
  }

  void makePieMenuUniqueIn(Profile profile, PieMenu pieMenu) async {
    await removePieMenuFrom(profile, pieMenu);
    pieMenu.id = Isar.autoIncrement;
    await DB.putPieMenu(pieMenu);
    await addPieMenuTo(profile, pieMenu);
  }

  void createPieMenuIn(Profile profile) async {
    PieMenu newPieMenu = PieMenu(
      name: "New Pie Menu",
    );

    int pieMenuId = await DB.putPieMenu(newPieMenu);
    await DB.addPieMenuToProfile(pieMenuId, profile.id);

    List<PieItem> newPieItems = [
      PieItem(displayName: "New Pie Item"),
      PieItem(displayName: "New Pie Item"),
      PieItem(displayName: "New Pie Item"),
      PieItem(displayName: "New Pie Item"),
      PieItem(displayName: "New Pie Item"),
    ];

    await Future.wait(newPieItems.map((PieItem e) => DB.putPieItem(e)));

    await DB.addPieItemsToPieMenu(newPieItems, newPieMenu);

    updateState();
  }

  Future<bool> toggleActiveProfile() async {
    activeProfile.enabled = !activeProfile.enabled;
    await DB.putProfile(activeProfile);
    notifyListeners();

    return activeProfile.enabled;
  }
}
