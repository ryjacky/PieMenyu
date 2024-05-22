import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/draggable_number_field.dart';
import 'package:provider/provider.dart';

class ShapeSection extends StatelessWidget {
  const ShapeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PieMenuState>();
    final shape =
        context.select<PieMenuState, PieMenuShape>((value) => value.shape);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-shape".tr(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("label-center-radius".tr()),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("label-center-thickness".tr()),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("label-pie-item-roundness".tr()),
            ),
            SizedBox(
              width: 70,
              child: DraggableNumberField(
                min: 0,
                max: 100,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("label-pie-item-spread".tr()),
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
