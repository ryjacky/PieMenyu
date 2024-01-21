import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/collapasable_color_picker.dart';
import 'package:pie_menyu_editor/view/widgets/draggable_number_field.dart';
import 'package:provider/provider.dart';

class ShapeSection extends StatelessWidget {
  const ShapeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PieMenuState>();
    final shape = context.select<PieMenuState, PieMenuShape>((value) => value.shape);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-shape".i18n(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Center Radius"),
            ),
            SizedBox(
              width: 70,
              child: DraggableNumberField(
                min: 0,
                max: 500,
                value: shape.centerRadius,
                onChanged: (double value) {
                  state.updatePieMenu(shape: shape..centerRadius = value);
                },
              ),
            ),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Pie Item Offset"),
            ),
            SizedBox(
              width: 70,
              child: DraggableNumberField(
                min: 0,
                max: 360,
                value: shape.pieItemOffset,
                onChanged: (double value) {
                  state.updatePieMenu(shape: shape..pieItemOffset = value);
                },
              ),
            ),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Center Thickness"),
            ),
            SizedBox(
              width: 70,
              child: DraggableNumberField(
                min: 0,
                max: 500,
                value: shape.centerThickness,
                onChanged: (double value) {
                  state.updatePieMenu(shape: shape..centerThickness = value);
                },
              ),
            ),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Pie Item Roundness"),
            ),
            SizedBox(
              width: 70,
              child: DraggableNumberField(
                min: 0,
                max: 500,
                value: shape.pieItemRoundness,
                onChanged: (double value) {
                  state.updatePieMenu(shape: shape..pieItemRoundness = value);
                },
              ),
            ),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Pie Item Spread"),
            ),
            SizedBox(
              width: 70,
              child: DraggableNumberField(
                min: 0,
                max: 500,
                value: shape.pieItemSpread,
                onChanged: (double value) {
                  state.updatePieMenu(shape: shape..pieItemSpread = value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
