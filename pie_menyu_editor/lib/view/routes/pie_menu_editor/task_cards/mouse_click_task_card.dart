import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pie_menyu_core/pieItemTasks/mouse_click_task.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:provider/provider.dart';
import 'package:screen_retriever/screen_retriever.dart';

import 'pie_item_task_card.dart';

class MouseClickTaskCard extends StatefulWidget {
  final MouseClickTask mouseClickTask;
  final int order;
  final VoidCallback? onDelete;

  const MouseClickTaskCard(
      {super.key,
      required this.mouseClickTask,
      required this.order,
      this.onDelete});

  @override
  State<MouseClickTaskCard> createState() => _MouseClickTaskCardState();
}

class _MouseClickTaskCardState extends State<MouseClickTaskCard> {
  final List<bool> _isSelected = [true, false, false];
  bool _isListening = false;

  @override
  void initState() {
    HardwareKeyboard.instance.addHandler(handleEnter);

    _isSelected[0] = false;
    _isSelected[1] = false;
    _isSelected[2] = false;
    switch (widget.mouseClickTask.mouseButton) {
      case MouseButton.left:
        _isSelected[0] = true;
        break;
      case MouseButton.middle:
        _isSelected[1] = true;
        break;
      case MouseButton.right:
        _isSelected[2] = true;
        break;
      default:
        _isSelected[0] = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PieItemTaskCard(
      onDelete: widget.onDelete,
      label: "label-mouse-click-task".tr(),
      children: [
        ListTile(
          leading: Text("label-position".tr()),
          title:
              Text("(${widget.mouseClickTask.x}, ${widget.mouseClickTask.y})"),
          trailing: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.background),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  content: Text("hint-select-mouse-pos".tr())));
              setState(() {
                _isListening = !_isListening;
              });
            },
            child: Text(
                (_isListening ? "label-listening" : "label-listen").tr()),
          ),
        ),
        ListTile(
          leading: Text(
            "label-button".tr(),
          ),
          trailing: ToggleButtons(
            borderRadius: BorderRadius.circular(10),
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

                final state = context.read<PieMenuState>();
                final pieItem = state.activePieItemDelegate;
                state.updateTaskIn(
                    pieItem, widget.mouseClickTask..mouseButton = btn);
              });
            },
            children: [
              Text("label-left-short".tr()),
              Text("label-middle-short".tr()),
              Text("label-right-short".tr()),
            ],
          ),
        ),
        const Gap(10),
      ],
    );
  }

  bool handleEnter(KeyEvent event) {
    if (!_isListening || event.logicalKey != LogicalKeyboardKey.enter) {
      return false;
    }

    screenRetriever.getCursorScreenPoint().then((mousePos) {
      widget.mouseClickTask
        ..x = mousePos.dx.toInt()
        ..y = mousePos.dy.toInt();

      final state = context.read<PieMenuState>();
      final pieItem = state.activePieItemDelegate;
      state.updateTaskIn(pieItem, widget.mouseClickTask);

      setState(() {
        _isListening = false;
      });
    });

    return true;
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(handleEnter);
    super.dispose();
  }
}
