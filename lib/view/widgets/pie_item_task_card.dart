import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu/view/widgets/draggable_number_field.dart';

import '../../db/pie_item_task.dart';

class PieItemTaskCard extends StatefulWidget {
  final PieItemTask _pieItemTask;
  final List<Widget> _children;
  final String _label;
  final Function(PieItemTask)? onPieItemTaskChange;

  const PieItemTaskCard(
      {super.key,
      this.onPieItemTaskChange,
      required PieItemTask pieItemTask,
      required List<Widget> children, required String label})
      : _pieItemTask = pieItemTask, _children = children, _label = label;

  @override
  State<PieItemTaskCard> createState() => _PieItemTaskCardState();
}

class _PieItemTaskCardState extends State<PieItemTaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget._label),
            trailing: SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("label-repeat".i18n()),
                  const Gap(10),
                  SizedBox(
                    width: 50,
                    child: DraggableNumberField(
                      value: widget._pieItemTask.repeat,
                      onChanged: (value) {
                        widget.onPieItemTaskChange
                            ?.call(widget._pieItemTask..repeat = value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...widget._children
        ],
      ),
    );
  }
}
