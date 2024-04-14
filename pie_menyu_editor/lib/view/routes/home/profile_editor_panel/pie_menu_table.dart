import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:pie_menyu_editor/view/widgets/delayed_tooltip.dart';
import 'package:pie_menyu_editor/view/widgets/key_press_recorder.dart';
import 'package:pie_menyu_editor/view/widgets/minimal_text_field.dart';
import 'package:pie_menyu_editor/view/widgets/outlined_icon_button.dart';
import 'package:provider/provider.dart';

import '../../pie_menu_editor/pie_menu_editor_route.dart';
import '../home_page_view_model.dart';

class PieMenuTable extends StatefulWidget {
  const PieMenuTable({super.key});

  @override
  State<PieMenuTable> createState() => _PieMenuTableState();
}

class _PieMenuTableState extends State<PieMenuTable> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomePageViewModel>();

    final activeProfile = context
        .select<HomePageViewModel, Profile>((value) => value.activeProfile);
    final allPieMenuInProfile = viewModel.getPieMenusOf(activeProfile);

    final themeLabelMedium = Theme.of(context).textTheme.labelMedium;

    return Table(
      columnWidths: const {
        0: FractionColumnWidth(0.07),
        1: FractionColumnWidth(0.51),
        2: FractionColumnWidth(0.26),
        3: FractionColumnWidth(0.16),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            Text('', style: themeLabelMedium),
            Text("table-header-name".tr(), style: themeLabelMedium),
            Text("table-header-hotkey".tr(), style: themeLabelMedium),
            Text("table-header-actions".tr(), style: themeLabelMedium),
          ],
        ),
        for (var pieMenu in allPieMenuInProfile)
          TableRow(children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Draggable(
                data: pieMenu.id,
                feedback: Text(
                  pieMenu.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                onDragStarted: () => viewModel.draggingPieMenu = true,
                onDragEnd: (details) => viewModel.draggingPieMenu = false,
                child: DelayedTooltip(
                  message: pieMenu.profiles.length == 1
                      ? "tooltip-duplicate-or-link-pie-menu".tr()
                      : "tooltip-make-pie-menu-unique".tr(),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: const Size(32, 32),
                      maximumSize: const Size(32, 32),
                      padding: const EdgeInsets.all(0),
                    ),
                    onPressed: () {
                      viewModel.makePieMenuUniqueIn(activeProfile, pieMenu);
                    },
                    child: Text(pieMenu.profiles.length == 1
                        ? "U"
                        : pieMenu.profiles.length.toString()),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 25, 0),
              child: MinimalTextField(
                key: ValueKey(pieMenu.id),
                onSubmitted: (String? name) {
                  context
                      .read<HomePageViewModel>()
                      .putPieMenu(pieMenu..name = name ?? "");
                },
                content: pieMenu.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 8, 0),
              child: KeyPressRecorder(
                key: ValueKey(pieMenu.id),
                initialHotkey: getPieMenuHotkey(pieMenu, activeProfile),
                onHotKeyRecorded: (newHotkey) =>
                    addHotkeyToProfile(activeProfile, newHotkey, pieMenu.id),
                onClear: (prevHotkey) =>
                    removeHotkeyFromProfile(activeProfile, prevHotkey),
                validation: (hotkey) {
                  final isHotkeyUsed =
                      activeProfile.pieMenuHotkeys.any((pieMenuHotkey) {
                    final keySet = pieMenuHotkey.keySet;
                    if (keySet == null) return true;
                    return isKeySetEqual(keySet, hotkey);
                  });
                  if (!isHotkeyUsed) return true;

                  showSnackBar(SnackBar(
                      backgroundColor: Colors.red[400],
                      content: Text("message-hotkey-is-used".tr())));

                  return false;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedIconButton(
                    icon: FontAwesomeIcons.pencil,
                    onPressed: () async {
                      final db = context.read<Database>();
                      final pm =
                          (await db.getPieMenus(ids: [pieMenu.id])).firstOrNull;

                      if (pm == null || !context.mounted) return;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PieMenuEditorRoute(pm),
                        ),
                      );
                    },
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  OutlinedIconButton(
                    icon: FontAwesomeIcons.trash,
                    onPressed: () =>
                        removePieMenu(viewModel, activeProfile, pieMenu),
                    color: Theme.of(context).colorScheme.errorContainer,
                  ),
                ],
              ),
            ),
          ]),
      ],
    );
  }

  showSnackBar(SnackBar snackBar) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(snackBar);
  }

  LogicalKeySet? getPieMenuHotkey(PieMenu pieMenu, Profile profile) {
    try {
      PieMenuHotkey hotkey = profile.pieMenuHotkeys
          .firstWhere((element) => element.pieMenuId == pieMenu.id);

      print(hotkey.keySet);
      return hotkey.keySet;
    } catch (e) {
      return null;
    }
  }

  addHotkeyToProfile(
      Profile profile, LogicalKeySet keySet, int pieMenuId) async {
    List<PieMenuHotkey> hotkeyToPieMenuIdList = profile.pieMenuHotkeys
        .where((element) => element.pieMenuId != pieMenuId)
        .toList();

    final pieMenuHotkey = PieMenuHotkey(pieMenuId: pieMenuId);
    for (final key in keySet.keys) {
      if (key == LogicalKeyboardKey.control) {
        pieMenuHotkey.ctrl = true;
      } else if (key == LogicalKeyboardKey.shift) {
        pieMenuHotkey.shift = true;
      } else if (key == LogicalKeyboardKey.alt) {
        pieMenuHotkey.alt = true;
      } else {
        pieMenuHotkey.keyId = key.keyId;
      }
    }
    hotkeyToPieMenuIdList.add(pieMenuHotkey);

    profile.pieMenuHotkeys = hotkeyToPieMenuIdList;
    context.read<HomePageViewModel>().putProfile(profile);
  }

  removeHotkeyFromProfile(Profile profile, LogicalKeySet keySet) async {
    List<PieMenuHotkey> hotkeyToPieMenuIdList =
        profile.pieMenuHotkeys.where((element) {
      if (element.keySet == null) return false;
      return !isKeySetEqual(element.keySet!, keySet);
    }).toList();

    profile.pieMenuHotkeys = hotkeyToPieMenuIdList;
    context.read<HomePageViewModel>().putProfile(profile);
  }

  /// return false when both s1 and s2 are null
  isKeySetEqual(LogicalKeySet s1, LogicalKeySet s2) {
    return listEquals(s1.keys.toList(), s2.keys.toList());
  }

  void removePieMenu(
    HomePageViewModel viewModel,
    Profile activeProfile,
    PieMenu pieMenu,
  ) {
    log("Removing pie menu ${pieMenu.id} from profile ${activeProfile.name}",
        name: "PieMenuTable.removePieMenu");
    viewModel.removePieMenuFrom(activeProfile, pieMenu);
    setState(() {});
    // Allow delete up to a single level.
    showSnackBar(
      SnackBar(
        content: Text("message-pie-menu-deleted".tr()),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: "label-undo".tr(),
          onPressed: () {
            viewModel.cancelDelete(pieMenu);
            setState(() {});
          },
        ),
      ),
    );
  }
}
