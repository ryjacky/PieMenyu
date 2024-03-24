import 'dart:async';
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

  bool _creatingProfile = false;

  get creatingProfile => _creatingProfile;

  Profile _activeProfile = Profile(name: "Loading...");

  Profile get activeProfile => _activeProfile;

  Map<PieMenu, Profile> _toDelete = {};

  Map<PieMenu, Profile> get toDelete => _toDelete;
  Timer? _toDeleteTimer;

  set activeProfile(Profile profile) {
    _activeProfile = profile;
    notifyListeners();
  }

  final Database _db;

  HomePageViewModel(this._db) {
    updateState();
  }

  updateState() async {
    log("Fetching state...");

    profiles = await _db.getProfiles();
    pieMenus = await _db.getPieMenus();

    activeProfile = profiles.firstWhere(
      (element) => element.id == activeProfile.id,
      orElse: () => profiles.firstOrNull ?? Profile(name: "Loading..."),
    );

    notifyListeners();
  }

  Iterable<PieMenu> getPieMenusOf(Profile profile) {
    return pieMenus.where((pieMenu) =>
        pieMenu.profiles
            .where((thisProfile) => thisProfile.id == profile.id)
            .isNotEmpty &&
        !toDelete.containsKey(pieMenu));
  }

  Iterable<PieMenu> getAllPieMenusExceptIn(Profile profile) {
    return pieMenus.where((pieMenu) =>
        pieMenu.profiles
            .where((thisProfile) => thisProfile.id == profile.id)
            .isEmpty &&
        !toDelete.containsKey(pieMenu));
  }

  Future<void> createProfile(
      String profName, String exePath, String profIcon) async {
    if (await _db.getProfileByExe(exePath) != null) {
      throw Exception("This application is already added to a profile.");
    }

    final profile = Profile()
      ..name = profName
      ..iconBase64 = profIcon;

    await _db.putProfile(profile);
    await _db.linkProfileToExe(profile, exePath);

    await updateState();
  }

  Future<void> addPieMenuTo(Profile profile, PieMenu pieMenu) async {
    await _db.addPieMenuToProfile(pieMenu.id, profile.id);
    await updateState();
  }

  Future<void> removePieMenuFrom(Profile profile, PieMenu pieMenu) async {
    _toDelete[pieMenu] = profile;
    _toDeleteTimer = Timer(const Duration(seconds: 5), () async {
      for (final toDeleteEntry in _toDelete.entries) {
        profile.pieMenus.remove(toDeleteEntry.key);
      }
      await _db.updateProfileToPieMenuLinks(profile);
      await updateState();
      _toDelete.remove(pieMenu);
    });

    notifyListeners();
  }

  cancelDelete(PieMenu pieMenu) {
    _toDeleteTimer?.cancel();
    _toDelete.remove(pieMenu);
    notifyListeners();
  }

  void makePieMenuUniqueIn(Profile profile, PieMenu pieMenu) async {
    await removePieMenuFrom(profile, pieMenu);
    pieMenu.id = Isar.autoIncrement;
    await _db.putPieMenu(pieMenu);
    await addPieMenuTo(profile, pieMenu);
  }

  void createPieMenuIn(Profile profile) async {
    PieMenu newPieMenu = PieMenu()..name = "New Pie Menu";

    int pieMenuId = await _db.putPieMenu(newPieMenu);
    await _db.addPieMenuToProfile(pieMenuId, profile.id);

    List<PieItem> newPieItems = [
      PieItem(name: "New Pie Item"),
      PieItem(name: "New Pie Item"),
      PieItem(name: "New Pie Item"),
      PieItem(name: "New Pie Item"),
      PieItem(name: "New Pie Item"),
    ];

    await Future.wait(newPieItems.map((PieItem e) => _db.putPieItem(e)));

    await _db.addPieItemsToPieMenu(newPieItems, newPieMenu);
    updateState();
  }

  Future<bool> toggleActiveProfile() async {
    activeProfile.enabled = !activeProfile.enabled;
    await _db.putProfile(activeProfile);
    notifyListeners();

    return activeProfile.enabled;
  }

  void toggleCreateProfileMode() {
    _creatingProfile = !_creatingProfile;
    notifyListeners();
  }

  Future<void> putPieMenu(PieMenu pieMenu) async {
    await _db.putPieMenu(pieMenu);
    updateState();
  }

  Future<void> putProfile(Profile profile) async {
    await _db.putProfile(profile);
    updateState();
  }

  Future<void> deleteProfile(Profile profile) async {
    await _db.deleteProfile(profile);
    updateState();
  }
}
