import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_menyu/db/db.dart';
import 'package:pie_menyu/db/pie_item.dart';
import 'package:pie_menyu/db/pie_menu.dart';
import 'package:pie_menyu/ui/widgets/pie_item_widget.dart';

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

  createPieItem() async {
    final PieItem newPieItem = PieItem(displayName: "test");
    await DB.putPieItem(newPieItem);
    widget.pieMenu.pieItems.add(newPieItem);

    updateParameterThenSetState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          TextButton(onPressed: createPieItem, child: Text("add pie item")),
          Positioned(
              left: constraints.maxWidth / 2 - 25,
              bottom: constraints.maxHeight / 2,
              child: Container(
                color: Colors.red,
                width: 50,
                height: 50,
              )),
          for (int i = 0; i < widget.pieMenu.pieItems.length; i++)
            Positioned(
                left: computeXAdjusted(i, constraints.maxWidth / 2),
                bottom: computeYAdjusted(i, constraints.maxHeight / 2),
                child: PieItemWidget(
                  horizontalOffset:
                      i % (widget.pieMenu.pieItems.length / 2) == 0
                          ? PieItemOffset.center
                          : i > widget.pieMenu.pieItems.length / 2
                              ? PieItemOffset.toLeft
                              : PieItemOffset.toRight,
                  borderRadius: widget.pieMenu.pieItemRoundness,
                  backgroundColor: widget.pieMenu.secondaryColor,
                  width: widget.pieMenu.pieItemWidth,
                  height: 50,
                )),
        ],
      );
    });
  }

  double computeYAdjusted(int i, double originY) =>
      originY +
      getYFromBiasedPolar(angleDelta * i, widget.pieMenu.centerRadius);

  /// Returns the x coordinate relative to the [originX] and adjusted
  /// the pie item so it looks more like in a circle.
  double computeXAdjusted(int i, double originX) {
    double rawX =
        getXFromBiasedPolar(angleDelta * i, widget.pieMenu.centerRadius);
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
