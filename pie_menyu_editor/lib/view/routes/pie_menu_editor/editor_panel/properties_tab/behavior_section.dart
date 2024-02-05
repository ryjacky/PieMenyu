import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_editor/view/widgets/compact_dropdown_menu.dart';
import 'package:pie_menyu_editor/view/widgets/draggable_number_field.dart';
import 'package:provider/provider.dart';

class BehaviorSection extends StatelessWidget {
  const BehaviorSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PieMenuState>();
    final behavior = context
        .select<PieMenuState, PieMenuBehavior>((value) => value.behavior);

    log("Sub menu activation mode: ${behavior.subMenuActivationMode}",
        name: "BehaviorSection");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("label-behavior".tr(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Open In Screen Center"),
            ),
            Switch(
              // This bool value toggles the switch.
              value: behavior.openInScreenCenter,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (bool value) {
                state.updatePieMenu(
                    behavior: PieMenuBehavior.from(
                        behavior..openInScreenCenter = value));
              },
            ),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
              child: Text("Escape Radius"),
            ),
            SizedBox(
              width: 70,
              child: DraggableNumberField(
                min: 0,
                max: 500,
                value: behavior.escapeRadius,
                onChanged: (double value) {
                  state.updatePieMenu(behavior: behavior..escapeRadius = value);
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
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Tooltip(
                message: "tooltip-activation-mode-hint".tr(),
                child: const Icon(
                  Icons.help_outline,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            Text("label-activation-mode".tr()),
            CompactDropdownMenu<ActivationMode>(
              width: 120,
              initialSelection: behavior.activationMode,
              dropdownMenuEntries: [
                DropdownMenuEntry(
                    value: ActivationMode.onRelease,
                    label: "label-release".tr()),
                DropdownMenuEntry(
                    value: ActivationMode.onClick, label: "label-click".tr()),
                DropdownMenuEntry(
                    value: ActivationMode.onHover, label: "label-hover".tr()),
              ],
              onSelected: (ActivationMode? value) {
                if (value == null) return;
                state.updatePieMenu(behavior: behavior..activationMode = value);
              },
            ),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Tooltip(
                message: "tooltip-sub-menu-activation-mode-hint".tr(),
                child: const Icon(
                  Icons.help_outline,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
                width: 120, child: Text("label-sub-menu-activation-mode".tr())),
            CompactDropdownMenu<ActivationMode>(
              width: 120,
              initialSelection: behavior.subMenuActivationMode,
              dropdownMenuEntries: [
                DropdownMenuEntry(
                    value: ActivationMode.onClick, label: "label-click".tr()),
                DropdownMenuEntry(
                    value: ActivationMode.onHover, label: "label-hover".tr()),
              ],
              onSelected: (ActivationMode? value) {
                if (value == null) return;
                state.updatePieMenu(
                    behavior: behavior..subMenuActivationMode = value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
