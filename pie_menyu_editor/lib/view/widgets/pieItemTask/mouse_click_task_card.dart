import 'package:flutter/material.dart';
import 'package:flutter_auto_gui/flutter_auto_gui.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/pieItemTasks/mouse_click_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:provider/provider.dart';

import '../../routes/pieMenuEditorPage/pie_menu_editor_page_view_model.dart';
import '../draggable_number_field.dart';
import '../keyboard_view.dart';
import 'pie_item_task_card.dart';

class MouseClickTaskCard extends StatefulWidget {
  final MouseClickTask mouseClickTask;
  final int order;
  const MouseClickTaskCard({super.key, required this.mouseClickTask, required this.order});

  @override
  State<MouseClickTaskCard> createState() => _MouseClickTaskCardState();
}

class _MouseClickTaskCardState extends State<MouseClickTaskCard> {
  final List<bool> _isSelected = [true, false, false];

  @override
  void initState() {
    switch (widget.mouseClickTask.mouseButton) {
      case MouseButton.left:
        _isSelected[0] = true;
        _isSelected[1] = false;
        _isSelected[2] = false;
        break;
      case MouseButton.middle:
        _isSelected[0] = false;
        _isSelected[1] = true;
        _isSelected[2] = false;
        break;
      case MouseButton.right:
        _isSelected[0] = false;
        _isSelected[1] = false;
        _isSelected[2] = true;
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PieItemTaskCard(
        pieItemTask: widget.mouseClickTask,
        label: "label-mouse-click-task".i18n(),
        children: [
          ListTile(
            title: Text("label-x".i18n()),
            trailing: SizedBox(
              width: 160,
              child: DraggableNumberField(
                value: widget.mouseClickTask.x,
                onChanged: (value) {
                  context
                      .read<PieMenuEditorPageViewModel>()
                      .replacePieItemTaskInCurrentPieItemAt(
                      widget.order, widget.mouseClickTask..x = value);
                },
              ),
            ),
          ),
          ListTile(
            title: Text("label-y".i18n()),
            trailing: SizedBox(
              width: 160,
              child: DraggableNumberField(
                value: widget.mouseClickTask.y,
                onChanged: (value) {
                  context
                      .read<PieMenuEditorPageViewModel>()
                      .replacePieItemTaskInCurrentPieItemAt(
                      widget.order, widget.mouseClickTask..y = value);
                },
              ),
            ),
          ),
          ListTile(
            title: Text("label-mouse-button".i18n()),
            trailing: SizedBox(
              width: 160,
              child: ToggleButtons(
                children: const [
                  Text("Left"),
                  Text("Middle"),
                  Text("Right"),
                ],
                isSelected: _isSelected,
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < _isSelected.length; i++) {
                      _isSelected[i] = (i == index);
                    }

                    MouseButton btn = MouseButton.left;
                    if (index == 1) {
                      btn = MouseButton.middle;
                    } else if (index == 2) {
                      btn = MouseButton.right;
                    }

                    context
                        .read<PieMenuEditorPageViewModel>()
                        .replacePieItemTaskInCurrentPieItemAt(
                        widget.order, widget.mouseClickTask..mouseButton = btn);
                  });
                },
              ),
            ),
          )
        ]);
  }
}
