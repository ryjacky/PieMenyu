import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/db/profile.dart';
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
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(32, 32),
                  ),
                  onPressed: () {
                    viewModel.makePieMenuUniqueIn(activeProfile, pieMenu);
                  },
                  child: Text(pieMenu.profiles.length.toString()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 25, 0),
              child: MinimalTextField(
                key: ValueKey(pieMenu.id),
                onSubmitted: (String? name) {
                  setPieMenuName(name ?? "", pieMenu);
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
                  final isHotkeyUsed = activeProfile.hotkeyToPieMenuIdList
                      .any((htpm) => isHotkeyEqual(htpm, hotkey));
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

  void setPieMenuName(String name, PieMenu pieMenu) async {
    setState(() {
      pieMenu.name = name;
    });

    showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text("pie-menu-name-saved".tr())));

    await context.read<HomePageViewModel>().putPieMenu(pieMenu);
  }

  HotKey? getPieMenuHotkey(PieMenu pieMenu, Profile profile) {
    try {
      HotkeyToPieMenuId htpm = profile.hotkeyToPieMenuIdList
          .firstWhere((element) => element.pieMenuId == pieMenu.id);

      return HotKey(htpm.keyCode, modifiers: htpm.keyModifiers);
    } catch (e) {
      return null;
    }
  }

  addHotkeyToProfile(Profile profile, HotKey hotKey, int pieMenuId) async {
    List<HotkeyToPieMenuId> hotkeyToPieMenuIdList = profile
        .hotkeyToPieMenuIdList
        .where((element) => element.pieMenuId != pieMenuId)
        .toList();
    hotkeyToPieMenuIdList.add(HotkeyToPieMenuId.fromHotKey(hotKey, pieMenuId));

    profile.hotkeyToPieMenuIdList = hotkeyToPieMenuIdList;
    context.read<HomePageViewModel>().putProfile(profile);
  }

  removeHotkeyFromProfile(Profile profile, HotKey hotKey) async {
    List<HotkeyToPieMenuId> hotkeyToPieMenuIdList = profile
        .hotkeyToPieMenuIdList
        .where((element) => !isHotkeyEqual(element, hotKey))
        .toList();

    profile.hotkeyToPieMenuIdList = hotkeyToPieMenuIdList;
    context.read<HomePageViewModel>().putProfile(profile);
  }

  isHotkeyEqual(HotkeyToPieMenuId htpm, HotKey hotkey) {
    return htpm.keyCode == hotkey.keyCode &&
        htpm.keyModifiers.contains(KeyModifier.shift) ==
            hotkey.modifiers?.contains(KeyModifier.shift) &&
        htpm.keyModifiers.contains(KeyModifier.control) ==
            hotkey.modifiers?.contains(KeyModifier.control) &&
        htpm.keyModifiers.contains(KeyModifier.alt) ==
            hotkey.modifiers?.contains(KeyModifier.alt);
  }

  void removePieMenu(
    HomePageViewModel viewModel,
    Profile activeProfile,
    PieMenu pieMenu,
  ) {
    viewModel.removePieMenuFrom(activeProfile, pieMenu);
    // Allow delete up to a single level.
    showSnackBar(
      SnackBar(
        content: Text("message-pie-menu-deleted".tr()),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: "label-undo".tr(),
          onPressed: () {
            viewModel.cancelDelete();
          },
        ),
      ),
    );
  }
}
