import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_menyu/screens/pie_menu_screen/pie_menu_state_provider.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_view.dart';
import 'package:provider/provider.dart';

class PieMenuScreen extends StatefulWidget {
  const PieMenuScreen({super.key});

  @override
  State<PieMenuScreen> createState() => _PieMenuScreenState();
}

class _PieMenuScreenState extends State<PieMenuScreen> {
  @override
  Widget build(BuildContext context) {
    final pieMenuStates = context.watch<PieMenuStateProvider>().pieMenuStates;
    final pieMenuPos = context.read<PieMenuStateProvider>().pieMenuPositions;

    if (pieMenuStates.isEmpty) return Container();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(builder: (_, constraint) {
        return MouseRegion(
          onHover: (event) {
            final instance = getPieItemInstanceAt(
              event.position,
              pieMenuPos[pieMenuStates.last] ??=
                  Offset(constraint.maxWidth / 2, constraint.maxHeight / 2),
              pieMenuStates.last.pieItemInstances,
            );

            if (instance != pieMenuStates.last.activePieItemInstance) {
              pieMenuStates.last.activePieItemInstance = instance;
            }
          },
          child: Stack(
            children: [
              for (final state in pieMenuStates)
                buildPieMenuView(
                  state,
                  constraint,
                  pieMenuPos[state] ??=
                      Offset(constraint.maxWidth / 2, constraint.maxHeight / 2),
                )
            ],
          ),
        );
      }),
    );
  }

  PieItemInstance getPieItemInstanceAt(
    Offset position,
    Offset pieCenterPosition,
    List<PieItemInstance> instances,
  ) {
    final dx = position.dx - pieCenterPosition.dx;
    // 0,0 is top left, so dy is inverted
    final dy = pieCenterPosition.dy - position.dy;
    // We want the angle of 12 o'clock to be 0, so we swap dx and dy
    double pieCenterRotation = atan2(dx, dy);

    if (dx < 0) {
      pieCenterRotation += 2 * pi;
    }

    // Offset the rotation by half the angle of a pie item,
    // which is the detection range
    pieCenterRotation += 2 * pi / instances.length / 2;

    var activeBtnIndex =
        (instances.length * pieCenterRotation / (2 * pi)).floor();

    // Because we offset the rotation by half the angle of a pie item,
    // we need to mod by the number of pie items to get the correct index
    return instances[activeBtnIndex % instances.length];
  }

  Widget buildPieMenuView(
      PieMenuState state, BoxConstraints constraint, Offset position) {
    var width = position.dx * 2;
    var height = position.dy * 2;

    if (width > constraint.maxWidth) {
      width = constraint.maxWidth - (width - constraint.maxWidth);
    }
    if (height > constraint.maxHeight) {
      height = constraint.maxHeight - (height - constraint.maxHeight);
    }

    final alignment = Alignment(
      position.dx > constraint.maxWidth / 2 ? 1 : -1,
      position.dy > constraint.maxHeight / 2 ? 1 : -1,
    );

    return Align(
      alignment: alignment,
      child: SizedBox(
        width: width,
        height: height,
        child: PieMenuView(state: state),
      ),
    );
  }
}
