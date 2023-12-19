import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/view/widgets/pie_item_widget.dart';

import '../../painter/PieCenterPainter.dart';

class PieMenuPreview extends StatefulWidget {
  final PieMenu pieMenu;

  const PieMenuPreview({super.key, required this.pieMenu});

  @override
  State<PieMenuPreview> createState() => _PieMenuPreviewState();
}

class _PieMenuPreviewState extends State<PieMenuPreview> {
  double angleDelta = 0;

  @override
  void initState() {
    super.initState();

    updateParameterThenSetState();
  }

  Future<void> updateParameterThenSetState() async {
    if (!widget.pieMenu.pieItems.isLoaded) {
      widget.pieMenu.pieItems.load();
    }
    angleDelta = 2 * pi / widget.pieMenu.pieItems.length;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const height = 35;

    if (!widget.pieMenu.pieItems.isLoaded) {
      widget.pieMenu.pieItems.load();
    }
    angleDelta = 2 * pi / widget.pieMenu.pieItems.length;
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned(
              left: (constraints.maxWidth - widget.pieMenu.centerRadius - widget.pieMenu.centerThickness) / 2,
              bottom: (constraints.maxHeight - widget.pieMenu.centerRadius - widget.pieMenu.centerThickness) / 2,
              child: CustomPaint(
                size: Size(
                    (widget.pieMenu.centerRadius +
                        widget.pieMenu.centerThickness).toDouble(),
                    (widget.pieMenu.centerRadius +
                        widget.pieMenu.centerThickness).toDouble()),
                painter: PieCenterPainter(
                    centerThickness: widget.pieMenu.centerThickness.toDouble(),
                    backgroundColor: Color(widget.pieMenu.secondaryColor),
                    foregroundColor: Color(widget.pieMenu.mainColor),
                    numberOfPieItems: widget.pieMenu.pieItems.length),
              )),
          for (int i = 0; i < widget.pieMenu.pieItems.length; i++)
            Positioned(
                left: computeXAdjusted(i, constraints.maxWidth / 2),
                bottom:
                    computeYAdjusted(i, constraints.maxHeight / 2 - height / 2),
                child: PieItemWidget(
                  name: widget.pieMenu.pieItems.elementAt(i).displayName,
                  icon: widget.pieMenu.pieItems.elementAt(i).iconBase64,
                  horizontalOffset:
                      i % (widget.pieMenu.pieItems.length / 2) == 0
                          ? PieItemOffset.center
                          : i > widget.pieMenu.pieItems.length / 2
                              ? PieItemOffset.toLeft
                              : PieItemOffset.toRight,
                  borderRadius: widget.pieMenu.pieItemRoundness,
                  backgroundColor: widget.pieMenu.secondaryColor,
                  width: widget.pieMenu.pieItemWidth,
                  height: height,
                )),
        ],
      );
    });
  }

  double computeYAdjusted(int i, double originY) {
    double yAdjusted = originY +
        getYFromBiasedPolar(angleDelta * i, widget.pieMenu.centerRadius + widget.pieMenu.pieItemSpread);

    if (i == 0) {
      yAdjusted += 10;
    }

    if (i == widget.pieMenu.pieItems.length / 2) {
      yAdjusted -= 10;
    }

    return yAdjusted;
  }

  /// Returns the x coordinate relative to the [originX] and adjusted
  /// the pie item so it looks more like in a circle.
  double computeXAdjusted(int i, double originX) {
    double rawX =
        getXFromBiasedPolar(angleDelta * i, widget.pieMenu.centerRadius + widget.pieMenu.pieItemSpread);
    double half = widget.pieMenu.pieItems.length / 2;
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
}
