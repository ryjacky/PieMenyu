import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_item_order_index_controller.dart';

import '../../db/pie_item.dart';
import '../../db/pie_menu.dart';
import '../../painter/pie_center_painter.dart';
import '../pie_item_view.dart';

class PieMenuView extends StatefulWidget {
  final PieMenu pieMenu;
  final PieItemOrderIndexController pieItemOrderIndexController;
  final List<PieItem> pieItems;

  final Function(int pieItemOrderIndex)? onPieItemClicked;

  const PieMenuView(
      {super.key,
      required this.pieMenu,
      required this.pieItems,
      required this.pieItemOrderIndexController,
      this.onPieItemClicked});

  @override
  State<PieMenuView> createState() => _PieMenuViewState();
}

class _PieMenuViewState extends State<PieMenuView> {
  double angleDelta = 0;
  int pieItemOrderIndex = 0;

  double getOriginX(BoxConstraints constraints) => constraints.maxWidth / 2;

  double getOriginY(BoxConstraints constraints) => constraints.maxHeight / 2;

  @override
  void initState() {
    super.initState();

    pieItemOrderIndex = widget.pieItemOrderIndexController.value;
    widget.pieItemOrderIndexController.addListener(() {
      setState(() {
        pieItemOrderIndex = widget.pieItemOrderIndexController.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double pieCenterSize =
        (widget.pieMenu.centerRadius + widget.pieMenu.centerThickness) * 2;

    angleDelta = 2 * pi / widget.pieItems.length;

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned(
            left: getOriginX(constraints) -
                widget.pieMenu.centerRadius -
                widget.pieMenu.centerThickness,
            bottom: getOriginY(constraints) -
                widget.pieMenu.centerRadius -
                widget.pieMenu.centerThickness,
            child: Transform.rotate(
              angle: getPieCenterRotation(),
              child: CustomPaint(
                size: Size(pieCenterSize, pieCenterSize),
                painter: PieCenterPainter(
                  centerThickness: widget.pieMenu.centerThickness.toDouble(),
                  backgroundColor: Color(widget.pieMenu.secondaryColor),
                  foregroundColor: Color(widget.pieMenu.mainColor),
                  numberOfPieItems: widget.pieItems.length,
                ),
              ),
            ),
          ),
          for (int i = 0; i < widget.pieItems.length; i++)
            Positioned(
              left: computeXAdjusted(i, getOriginX(constraints)),
              bottom: computeYAdjusted(i, getOriginY(constraints)),
              child: GestureDetector(
                onTap: () {
                  widget.onPieItemClicked?.call(i);
                  pieItemOrderIndex = i;
                },
                child: PieItemView(
                  name: widget.pieItems.elementAt(i).displayName,
                  icon: widget.pieItems.elementAt(i).iconBase64,
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
                  font: widget.pieMenu.fontName,
                  fontColor: widget.pieMenu.fontColor,
                  fontSize: widget.pieMenu.fontSize.toDouble(),
                ),
              ),
            ),
        ],
      );
    });
  }

  double computeYAdjusted(int i, double originY) {
    double yAdjusted = originY +
        getYFromBiasedPolar(
            angleDelta * i,
            widget.pieMenu.centerRadius +
                widget.pieMenu.centerThickness / 2 +
                widget.pieMenu.pieItemSpread) -
        widget.pieMenu.iconSize / 2;

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
          ? -widget.pieMenu.pieItemWidth / 2 + widget.pieMenu.iconSize / 2
          : widget.pieMenu.pieItemWidth / 2 - widget.pieMenu.iconSize / 2;
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
  double getYFromBiasedPolar(double angleFromYAxis, double radius) {
    return radius * cos(angleFromYAxis);
  }

  double getPieCenterRotation() {
    double result = 2 * pi * pieItemOrderIndex / widget.pieItems.length;
    return (result.isNaN || result.isInfinite) ? 0 : result;
  }
}
