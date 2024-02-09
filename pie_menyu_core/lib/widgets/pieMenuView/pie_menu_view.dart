import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';

import '../../db/pie_menu.dart';
import '../../painter/pie_center_painter.dart';
import '../pie_item_view.dart';

class PieMenuView extends StatefulWidget {
  final PieMenuState state;

  final Function(PieItemInstance instance)? onTap;
  final Function(PieItemInstance instance)? onHover;

  const PieMenuView({
    super.key,
    required this.state,
    this.onTap,
    this.onHover,
  });

  @override
  State<PieMenuView> createState() => _PieMenuViewState();
}

class _PieMenuViewState extends State<PieMenuView> {
  double angleDelta = 0;

  double getOriginX(BoxConstraints constraints) => constraints.maxWidth / 2;

  double getOriginY(BoxConstraints constraints) => constraints.maxHeight / 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PieMenuState state = widget.state;
    final centerRadius = state.shape.centerRadius;
    final centerThickness = state.shape.centerThickness;
    final nInstances = state.pieItemInstances.length;
    final pieItemInstances = state.pieItemInstances;
    final colors = state.colors;

    final double pieCenterSize = (centerRadius + centerThickness) * 2;

    angleDelta = 2 * pi / nInstances;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: getOriginX(constraints) - centerRadius - centerThickness,
              bottom: getOriginY(constraints) - centerRadius - centerThickness,
              child: Transform.rotate(
                angle: getPieCenterRotation(),
                child: CustomPaint(
                  size: Size(pieCenterSize, pieCenterSize),
                  painter: PieCenterPainter(
                    centerThickness: centerThickness.toDouble(),
                    backgroundColor: Color(colors.secondary),
                    foregroundColor: Color(colors.primary),
                    numberOfPieItems: nInstances,
                  ),
                ),
              ),
            ),
            for (int i = 0; i < nInstances; i++)
              if (pieItemInstances[i].pieItem != null)
                Positioned(
                  right: (i > nInstances / 2)
                      ? getHorizontalOffset(i, constraints)
                      : null,
                  left: (i > 0 && i < nInstances / 2)
                      ? getHorizontalOffset(i, constraints)
                      : null,
                  bottom: getVerticalOffset(i, constraints),
                  child: GestureDetector(
                    onTapUp: (event) {
                      widget.onTap?.call(pieItemInstances[i]);
                    },
                    child: MouseRegion(
                      onHover: (value) {
                        widget.onHover?.call(pieItemInstances[i]);
                      },
                      child: PieItemView(
                        horizontalOffset: i % (nInstances / 2) == 0
                            ? PieItemOffset.center
                            : i > nInstances / 2
                                ? PieItemOffset.toLeft
                                : PieItemOffset.toRight,
                        icon: state.icon,
                        font: state.font,
                        colors: state.colors,
                        shape: state.shape,
                        instance: state.pieItemInstances[i],
                        active:
                            state.activePieItemInstance == pieItemInstances[i],
                      ),
                    ),
                  ),
                ),
          ],
        );
      },
    );
  }

  double getPieCenterRotation() {
    double result = 2 *
        pi *
        widget.state.pieItemInstances
            .indexOf(widget.state.activePieItemInstance) /
        widget.state.pieItemInstances.length;
    return (result.isNaN || result.isInfinite) ? 0 : result;
  }

  double getHorizontalOffset(int i, BoxConstraints constraints) {
    final shape = widget.state.shape;
    return getOriginX(constraints) +
        ((shape.centerRadius + shape.pieItemSpread) * sin(i * angleDelta))
            .abs() -
        widget.state.icon.size / 2;
  }

  double getVerticalOffset(int i, BoxConstraints constraints) {
    final shape = widget.state.shape;

    return getOriginY(constraints) +
        ((shape.centerRadius + shape.pieItemSpread) * cos(i * angleDelta)) -
        widget.state.icon.size / 2;
  }
}
