import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_core/pieItemTasks/open_folder_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_text_task.dart';
import 'package:pie_menyu_editor/view/widgets/notification/notification.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageViewModel extends ChangeNotifier {
  List<Profile> profiles = [];
  List<PieMenu> pieMenus = [];

  /// Notifications that are queued to be shown.
  /// Notifications are shown in the order they are added unless they are marked as urgent.
  final Queue<NotificationDelegate> _notifications = Queue();

  void addNotification(NotificationDelegate notification, {bool urgent = false}) {
    if (urgent) {
      _notifications.addFirst(notification);
    } else {
      _notifications.add(notification);
    }
    notifyListeners();
  }

  NotificationDelegate? get firstNotification => _notifications.firstOrNull;

  NotificationDelegate? dismissNotification() {
    return _notifications.removeFirst();
  }

  bool _creatingProfile = false;

  bool _draggingPieMenu = false;

  bool _pieMenyuStatus = true;

  bool get pieMenyuStatus => _pieMenyuStatus;

  set pieMenyuStatus(bool value) {
    _pieMenyuStatus = value;

    launchUrl(Uri.parse("piemenyu://${value ? "start" : "stop"}"));
    notifyListeners();
  }

  bool get draggingPieMenu => _draggingPieMenu;

  set draggingPieMenu(bool value) {
    _draggingPieMenu = value;
    notifyListeners();
  }

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

    pieMenyuStatus = false;
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

  Future<void> removePieMenuFrom(Profile profile, PieMenu pieMenu,
      {lazy = true}) async {
    _toDelete[pieMenu] = profile;
    _toDeleteTimer = Timer(Duration(seconds: lazy ? 5 : 0), () async {
      final newLinks = profile.pieMenuHotkeys.toList();
      for (final toDeleteEntry in _toDelete.entries) {
        profile.pieMenus.remove(toDeleteEntry.key);
        newLinks.removeWhere(
            (element) => element.pieMenuId == toDeleteEntry.key.id);
      }
      profile.pieMenuHotkeys = newLinks;
      await _db.updateProfileToPieMenuLinks(profile);
      await updateState();
      _toDelete.remove(pieMenu);
    });

    pieMenyuStatus = false;
    notifyListeners();
  }

  cancelDelete(PieMenu pieMenu) {
    _toDeleteTimer?.cancel();
    _toDelete.remove(pieMenu);
    notifyListeners();
  }

  void makePieMenuUniqueIn(Profile profile, PieMenu pieMenu) async {
    await removePieMenuFrom(profile, pieMenu, lazy: false);
    PieMenu newPieMenu = PieMenu.from(pieMenu);
    newPieMenu.id = Isar.autoIncrement;

    await _db.putPieMenu(newPieMenu);
    await addPieMenuTo(profile, newPieMenu);
  }

  Future<void> createTutorialPieMenu() async {
    PieMenu? tutorialPieMenu = (await _db.getPieMenus(ids: [1])).firstOrNull;
    if (tutorialPieMenu == null) {
      tutorialPieMenu = PieMenu()
        ..id = 1
        ..name = "New Pie Menu";
      await _db.putPieMenu(tutorialPieMenu);
    }

    List<PieItem> newPieItems = [
      PieItem(name: "Center"),
      PieItem(name: "Save")
        ..tasks = [
          SendKeyTask()
            ..ctrl = true
            ..key = LogicalKeyboardKey.keyS
        ],
      PieItem(name: "Open Downloads")
        ..tasks = [OpenFolderTask()..folderPath = "~/Documents"],
      PieItem(name: "Toggle Volume")
        ..tasks = [SendKeyTask()..key = LogicalKeyboardKey.audioVolumeMute],
      PieItem(name: "Paste texts")
        ..tasks = [PasteTextTask()..text = "Piiiiiiiiiiiie Menyu!"],
      PieItem(name: "New Pie Item"),
    ];

    await _db.putPieItems(newPieItems);
    await _db.linkPieItemsTo(tutorialPieMenu, newPieItems);

    updateState();
  }

  void createPieMenuIn(Profile profile) async {
    PieMenu newPieMenu = PieMenu()..name = "New Pie Menu";

    int pieMenuId = await _db.putPieMenu(newPieMenu);
    await _db.addPieMenuToProfile(pieMenuId, profile.id);

    if (pieMenuId == 1) return await createTutorialPieMenu();

    List<PieItem> newPieItems = [
      PieItem(name: "Center"),
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
