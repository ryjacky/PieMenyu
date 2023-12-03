import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/db/db.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/db/profile.dart';
import 'package:pie_menyu/ui/widgets/PrimaryButton.dart';
import 'package:pie_menyu/ui/widgets/TableActionButton.dart';
import 'package:pie_menyu/ui/widgets/minimal_text_field.dart';

class RightHomePanel extends StatefulWidget {
  final Profile profile;
  final List<PieMenu> pieMenus;

  const RightHomePanel(
      {super.key,
      required this.profile,
      required this.pieMenus});

  @override
  State<RightHomePanel> createState() => _RightHomePanelState();
}

class _RightHomePanelState extends State<RightHomePanel> {
  final double tableRowGap = 10;
  List<PieMenu> pieMenusFromOtherProfiles = [];

  void createPieMenu() async {
    PieMenu newPieMenu = PieMenu(
      name: "New Pie Menu",
    );
    int pieMenuId = await DB.createPieMenu(newPieMenu);
    await DB.addPieMenuToProfile(pieMenuId, widget.profile.id);

    setState(() {
      widget.pieMenus.add(newPieMenu);
    });
  }

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
                  0: FractionColumnWidth(0.06),
                  1: FractionColumnWidth(0.39),
                  2: FractionColumnWidth(0.39),
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
                  for (var pieMenu in widget.pieMenus)
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
                                  minimumSize: const Size(32, 32),
                                ),
                                onPressed: () {},
                                child: Text(
                                    pieMenu.profiles.length.toString())),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 8, 0),
                          child: MinimalTextField(
                            controller:
                                TextEditingController(text: pieMenu.name),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 8, 0),
                          child: MinimalTextField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TableActionButton(
                                icon: FontAwesomeIcons.pencil,
                                onPressed: () {},
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              TableActionButton(
                                icon: FontAwesomeIcons.trash,
                                onPressed: () {},
                                color: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
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
}
