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
                  left: computeXAdjusted(i, getOriginX(constraints)),
                  bottom: computeYAdjusted(i, getOriginY(constraints)),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    mouseCursor: SystemMouseCursors.basic,
                    splashColor: Colors.transparent,
                    onTap: () {
                      state.activePieItemInstance = pieItemInstances[i];
                      widget.onTap?.call(state.pieItemInstances[i]);
                    },
                    onHover: (value) {
                      if (value) {
                        widget.onHover?.call(state.pieItemInstances[i]);
                      }
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
                      active: state.activePieItemInstance == pieItemInstances[i],
                    ),
                  ),
                ),
          ],
        );
      },
    );
  }

  double computeYAdjusted(int i, double originY) {
    double yAdjusted = originY +
        getYFromBiasedPolar(
            angleDelta * i,
            widget.state.shape.centerRadius +
                widget.state.shape.centerThickness / 2 +
                widget.state.shape.pieItemSpread) -
        widget.state.icon.size / 2;

    return yAdjusted;
  }

  /// Returns the x coordinate relative to the [originX] and adjusted
  /// the pie item so it looks more like in a circle.
  double computeXAdjusted(int i, double originX) {
    double rawX = getXFromBiasedPolar(angleDelta * i,
        widget.state.shape.centerRadius + widget.state.shape.pieItemSpread);

    double half = widget.state.pieItemInstances.length / 2;
    if (i % half != 0) {
      rawX += i > half
          ? -PieMenuShape.pieItemWidth / 2 + widget.state.icon.size / 2
          : PieMenuShape.pieItemWidth / 2 - widget.state.icon.size / 2;
    }

    return originX + rawX - PieMenuShape.pieItemWidth / 2;
  }

  /// Returns the x coordinate from a polar coordinate system starting from the
  /// y axis.
  double getXFromBiasedPolar(double angleFromYAxis, double radius) {
    return radius *
        sin(angleFromYAxis + widget.state.shape.pieItemOffset / 360 * pi);
  }

  /// Returns the y coordinate from a polar coordinate system starting from the
  /// y axis.
  double getYFromBiasedPolar(double angleFromYAxis, double radius) {
    return radius *
        cos(angleFromYAxis + widget.state.shape.pieItemOffset / 360 * pi);
  }

  double getPieCenterRotation() {
    double result = 2 *
        pi *
        widget.state.pieItemInstances
            .indexOf(widget.state.activePieItemInstance) /
        widget.state.pieItemInstances.length;
    return (result.isNaN || result.isInfinite) ? 0 : result;
  }
}
