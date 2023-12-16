import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/db.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/db/profile.dart';
import 'package:pie_menyu/view/routes/pieMenuEditorPage/pie_menu_editor_page.dart';
import 'package:pie_menyu/view/widgets/PrimaryButton.dart';
import 'package:pie_menyu/view/widgets/TableActionButton.dart';
import 'package:pie_menyu/view/widgets/key_press_recorder.dart';
import 'package:pie_menyu/view/widgets/minimal_text_field.dart';

class RightHomePanel extends StatefulWidget {
  final Profile profile;

  const RightHomePanel({super.key, required this.profile});

  @override
  State<RightHomePanel> createState() => _RightHomePanelState();
}

class _RightHomePanelState extends State<RightHomePanel> {
  final double tableRowGap = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.profile.name,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: PrimaryButton(
                  onPressed: createPieMenu,
                  icon: FontAwesomeIcons.plus,
                  label: Text("button-new-pie-menu".i18n()),
                ),
              )
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: SingleChildScrollView(
              child: Table(
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
                      Text('', style: Theme.of(context).textTheme.labelMedium),
                      Text("table-header-name".i18n(),
                          style: Theme.of(context).textTheme.labelMedium),
                      Text("table-header-hotkey".i18n(),
                          style: Theme.of(context).textTheme.labelMedium),
                      Text("table-header-actions".i18n(),
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                  for (var pieMenu in widget.profile.pieMenus)
                    TableRow(
                      children: [
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
                                      borderRadius: BorderRadius.circular(5)),
                                  minimumSize: const Size(32, 32),
                                ),
                                onPressed: () {},
                                child:
                                    Text(pieMenu.profiles.length.toString())),
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
                            initalHotKey: getPieMenuHotkey(pieMenu),
                            onHotKeyRecorded: (hotkey) =>
                                addHotkeyToProfile(hotkey, pieMenu.id),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TableActionButton(
                                icon: FontAwesomeIcons.pencil,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PieMenuEditorPage(
                                        pieMenu: pieMenu,
                                      ),
                                    ),
                                  );
                                },
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              Tooltip(
                                message: "tooltip-remove-pie-menu".i18n(),
                                child: TableActionButton(
                                  icon: FontAwesomeIcons.trash,
                                  onLongPress: () {
                                    removePieMenuLink(pieMenu);
                                  },
                                  color: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  void createPieMenu() async {
    PieMenu newPieMenu = PieMenu(
      name: "New Pie Menu",
    );
    int pieMenuId = await DB.putPieMenu(newPieMenu);
    await DB.addPieMenuToProfile(pieMenuId, widget.profile.id);

    setState(() {
      widget.profile.pieMenus.add(newPieMenu);
    });
  }

  void setPieMenuName(String name, PieMenu pieMenu) async {
    setState(() {
      pieMenu.name = name;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text("pie-menu-name-saved".i18n())));

    await DB.putPieMenu(pieMenu);
  }

  HotKey? getPieMenuHotkey(PieMenu pieMenu) {
    try {
      HotkeyToPieMenuId htpm = widget.profile.hotkeyToPieMenuIdList
          .firstWhere((element) => element.pieMenuId == pieMenu.id);

      return HotKey(htpm.keyCode, modifiers: htpm.keyModifiers);
    } catch (e) {
      return null;
    }
  }

  removePieMenuLink(PieMenu pieMenu) async {
    setState(() {
      widget.profile.pieMenus.remove(pieMenu);
    });
    await DB.updateProfileToPieMenuLinks(widget.profile);
  }

  addHotkeyToProfile(HotKey hotKey, int pieMenuId) async {
    List<HotkeyToPieMenuId> hotkeyToPieMenuIdList = widget
        .profile.hotkeyToPieMenuIdList
        .where((element) => element.pieMenuId != pieMenuId)
        .toList();
    hotkeyToPieMenuIdList.add(HotkeyToPieMenuId.fromHotKey(hotKey, pieMenuId));

    widget.profile.hotkeyToPieMenuIdList = hotkeyToPieMenuIdList;
    DB.updateProfile(widget.profile);
  }
}
