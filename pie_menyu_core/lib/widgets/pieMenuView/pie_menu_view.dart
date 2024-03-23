import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_center.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';

import '../../db/pie_menu.dart';
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
    final nSlices = state.pieItemInstances.length - 1;
    final pieItemInstances = state.pieItemInstances;
    final colors = state.colors;

    final double pieCenterSize = (centerRadius + centerThickness) * 2;

    angleDelta = 2 * pi / nSlices;

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
                child: GestureDetector(
                  onTapUp: (event) {
                    widget.onTap?.call(pieItemInstances.first);
                  },
                  child: PieCenter(
                    size: Size(pieCenterSize, pieCenterSize),
                    centerThickness: centerThickness.toDouble(),
                    backgroundColor: Color(colors.secondary),
                    highlightColor: Color(colors.primary),
                    arcAngle: state.activePieItemInstance == pieItemInstances.firstOrNull ? 2 * pi : angleDelta,
                  ),
                ),
              ),
            ),
            for (int i = 0; i < nSlices; i++)
              if (pieItemInstances[i].pieItem != null)
                Positioned(
                  right: (i > nSlices / 2)
                      ? getHorizontalOffset(i, constraints)
                      : null,
                  left: (i > 0 && i < nSlices / 2)
                      ? getHorizontalOffset(i, constraints)
                      : null,
                  bottom: getVerticalOffset(i, constraints),
                  child: GestureDetector(
                    onTapUp: (event) {
                      widget.onTap?.call(pieItemInstances[i + 1]);
                    },
                    child: MouseRegion(
                      onHover: (value) {
                        widget.onHover?.call(pieItemInstances[i + 1]);
                      },
                      child: PieItemView(
                        horizontalOffset: i % (nSlices / 2) == 0
                            ? PieItemOffset.center
                            : i > nSlices / 2
                                ? PieItemOffset.toLeft
                                : PieItemOffset.toRight,
                        icon: state.icon,
                        font: state.font,
                        colors: state.colors,
                        shape: state.shape,
                        instance: state.pieItemInstances[i + 1],
                        active:
                            state.activePieItemInstance == pieItemInstances[i + 1],
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
    final pieItemPosition = widget.state.pieItemInstances
        .indexOf(widget.state.activePieItemInstance);

    if (pieItemPosition == 0) {
      return 2 * pi;
    } else {
      double result = 2 *
          pi *
          (widget.state.pieItemInstances
                  .indexOf(widget.state.activePieItemInstance) -
              1) /
          (widget.state.pieItemInstances.length - 1);
      return (result.isNaN || result.isInfinite) ? 0 : result;
    }
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
