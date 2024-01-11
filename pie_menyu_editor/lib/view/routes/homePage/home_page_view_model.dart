import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/profile.dart';

class HomePageViewModel extends ChangeNotifier {
  List<Profile> profiles = [];

  HomePageViewModel() {
    fetchProfiles();
  }

  fetchProfiles() async {
    log("Fetching state...");

    profiles = await DB.getProfiles();
    log("There is ${profiles.length} profiles");

    notifyListeners();
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

    await fetchProfiles();
  }
}
