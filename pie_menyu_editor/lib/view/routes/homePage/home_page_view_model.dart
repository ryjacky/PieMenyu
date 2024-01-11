import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';

class HomePageViewModel extends ChangeNotifier {
  List<Profile> profiles = [];
  List<PieMenu> pieMenus = [];

  HomePageViewModel() {
    fetchState();
  }

  fetchState() async {
    log("Fetching state...");

    profiles = await DB.getProfiles();
    pieMenus = await DB.getPieMenus();

    notifyListeners();
  }

  Iterable<PieMenu> getPieMenusOf(Profile profile) {
    return pieMenus.where((element) => element.profiles
        .where((element) => element.id == profile.id)
        .isNotEmpty);
  }

  Iterable<PieMenu> getAllPieMenusExceptIn(Profile profile) {
    return pieMenus.where((element) => element.profiles
        .where((element) => element.id == profile.id)
        .isEmpty);
  }

  Future<void> createProfile(
      String profName, String exePath, String profIcon) async {
    if (profiles
        .where((element) => element.exes.contains(exePath))
        .isNotEmpty) {
      throw Exception("This application is already added to a profile.");
    }

    await DB.putProfile(Profile()
      ..name = profName
      ..exes.add(exePath)
      ..iconBase64 = profIcon);

    await fetchState();
  }

  void addPieMenuTo(Profile profile, PieMenu pieMenu) async {
    await DB.addPieMenuToProfile(pieMenu.id, profile.id);
    await fetchState();
  }
}
