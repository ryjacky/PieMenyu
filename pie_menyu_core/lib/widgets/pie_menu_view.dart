import 'dart:math';

import 'package:flutter/material.dart';

import '../db/pie_item.dart';
import '../db/pie_menu.dart';
import '../painter/pie_center_painter.dart';
import 'pie_item_view.dart';

class PieMenuView extends StatefulWidget {
  final PieMenu pieMenu;
  final int pieItemOrderIndex;
  final List<PieItem> pieItems;

  final Function(int pieItemOrderIndex)? onPieItemClicked;

  const PieMenuView({super.key,
    required this.pieMenu,
    required this.pieItems,
    required this.pieItemOrderIndex,
    this.onPieItemClicked});

  @override
  State<PieMenuView> createState() => _PieMenuViewState();
}

class _PieMenuViewState extends State<PieMenuView> {
  double angleDelta = 0;
  int pieItemOrderIndex = 0;

  @override
  void initState() {
    super.initState();

    pieItemOrderIndex = widget.pieItemOrderIndex;
  }

  @override
  Widget build(BuildContext context) {
    const height = 35;
    angleDelta = 2 * pi / widget.pieItems.length;

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned(
            left: (constraints.maxWidth -
                widget.pieMenu.centerRadius -
                widget.pieMenu.centerThickness) /
                2,
            bottom: (constraints.maxHeight -
                widget.pieMenu.centerRadius -
                widget.pieMenu.centerThickness) /
                2,
            child: Transform.rotate(
              angle: getPieCenterRotation(),
              child: CustomPaint(
                size: Size(
                  (widget.pieMenu.centerRadius + widget.pieMenu.centerThickness)
                      .toDouble(),
                  (widget.pieMenu.centerRadius + widget.pieMenu.centerThickness)
                      .toDouble(),
                ),
                painter: PieCenterPainter(
                    centerThickness: widget.pieMenu.centerThickness.toDouble(),
                    backgroundColor: Color(widget.pieMenu.secondaryColor),
                    foregroundColor: Color(widget.pieMenu.mainColor),
                    numberOfPieItems: widget.pieItems.length),
              ),
            ),
          ),
          for (int i = 0; i < widget.pieItems.length; i++)
            Positioned(
              left: computeXAdjusted(i, constraints.maxWidth / 2),
              bottom:
              computeYAdjusted(i, constraints.maxHeight / 2 - height / 2),
              child: GestureDetector(
                onTap: () {
                  widget.onPieItemClicked?.call(i);
                  pieItemOrderIndex = i;
                },
                child: PieItemView(
                  name: widget.pieItems
                      .elementAt(i)
                      .displayName,
                  icon: widget.pieItems
                      .elementAt(i)
                      .iconBase64,
                  horizontalOffset: i % (widget.pieItems.length / 2) == 0
                      ? PieItemOffset.center
                      : i > widget.pieItems.length / 2
                      ? PieItemOffset.toLeft
                      : PieItemOffset.toRight,
                  borderRadius: widget.pieMenu.pieItemRoundness,
                  backgroundColor: pieItemOrderIndex == i
                      ? widget.pieMenu.mainColor
                      : widget.pieMenu.secondaryColor,
                  width: widget.pieMenu.pieItemWidth,
                  iconSize: widget.pieMenu.iconSize.toDouble(),
                ),
              ),
            ),
        ],
      );
    });
  }

  double computeYAdjusted(int i, double originY) {
    double yAdjusted = originY +
        getYFromBiasedPolar(angleDelta * i,
            widget.pieMenu.centerRadius + widget.pieMenu.pieItemSpread);

    if (i == 0) {
      yAdjusted += 10;
    }

    if (i == widget.pieItems.length / 2) {
      yAdjusted -= 10;
    }

    return yAdjusted;
  }

  /// Returns the x coordinate relative to the [originX] and adjusted
  /// the pie item so it looks more like in a circle.
  double computeXAdjusted(int i, double originX) {
    double rawX = getXFromBiasedPolar(angleDelta * i,
        widget.pieMenu.centerRadius + widget.pieMenu.pieItemSpread);
    double half = widget.pieItems.length / 2;
    if (i % half != 0) {
      rawX += i > half
          ? -widget.pieMenu.pieItemWidth / 2
          : widget.pieMenu.pieItemWidth / 2;
    }

    return originX + rawX - widget.pieMenu.pieItemWidth / 2;
  }

  /// Returns the x coordinate from a polar coordinate system starting from the
  /// y axis.
  double getXFromBiasedPolar(double angleFromYAxis, int radius) {
    return radius * sin(angleFromYAxis);
  }

  /// Returns the y coordinate from a polar coordinate system starting from the
  /// y axis.
  double getYFromBiasedPolar(double angleFromYAxis, int radius) {
    return radius * cos(angleFromYAxis);
  }

  double getPieCenterRotation() {
    double result = 2 * pi * widget.pieItemOrderIndex / widget.pieItems.length;
    return (result.isNaN || result.isInfinite) ? 0 : result;
  }
}
