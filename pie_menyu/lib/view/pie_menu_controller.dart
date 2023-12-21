import 'package:flutter/cupertino.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';
import 'package:window_manager/window_manager.dart';

class PieMenuController extends ChangeNotifier {
  int _currentPieItemId;

  PieMenu _pieMenu;
  List<PieItem> _pieItems = [];
  final Map<int, List<PieItemTask>> _tasksOfPieItem = {};

  PieMenuController({
    required int currentPieItemId,
    required PieMenu pieMenu,
  })  : _currentPieItemId = currentPieItemId,
        _pieMenu = pieMenu {
    registerAllHotkeys();

    loadPieItemTasks();
  }

  loadPieItemTasks() async {
    // await _pieMenu.pieItems.load();
    // _pieItems = _pieMenu.pieItems.toList();
    //
    // // Load tasks of each pie item
    // await Future.wait(_pieMenu.pieItems.map((pieItem) => pieItem.tasks.load()));
    //
    // for (PieItem pieItem in _pieMenu.pieItems) {
    //   _tasksOfPieItem[pieItem.id] = pieItem.tasks.toList();
    // }
    //
    // notifyListeners();
  }

  List<PieItem> get pieItems => _pieItems;

  Map<int, List<PieItemTask>> get tasksOfPieItem => _tasksOfPieItem;

  PieMenu get pieMenu => _pieMenu;

  set pieMenu(PieMenu value) {
    _pieMenu = value;
    notifyListeners();
  }

  int get currentPieItemId => _currentPieItemId;

  set currentPieItemId(int value) {
    _currentPieItemId = value;
    notifyListeners();
  }

  void registerAllHotkeys() async {
    List<Profile> profiles = await DB.getProfiles();
    for (final prof in profiles) {
      for (final hotkeyToPieMenuId in prof.hotkeyToPieMenuIdList) {
        final HotKey hotkey = HotKey(hotkeyToPieMenuId.keyCode,
            modifiers: hotkeyToPieMenuId.keyModifiers,
            scope: HotKeyScope.system);

        await hotKeyManager.register(hotkey, keyDownHandler: (hotkey) async {
          Offset cursorPos = await screenRetriever.getCursorScreenPoint();
          (await screenRetriever.getAllDisplays()).first;
          await windowManager.setAlignment(Alignment.center);
          await windowManager.show();
          await windowManager.focus();
        });
      }
    }

  }
}
