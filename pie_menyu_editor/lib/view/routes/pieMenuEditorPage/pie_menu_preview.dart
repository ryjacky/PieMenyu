import 'dart:math';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_core/painter/pie_center_painter.dart';
import 'package:pie_menyu_core/widgets/pie_item_view.dart';
import 'package:pie_menyu_editor/view/routes/pieMenuEditorPage/pie_menu_editor_page_view_model.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:provider/provider.dart';

class PieMenuPreview extends StatefulWidget {
  const PieMenuPreview({super.key});

  @override
  State<PieMenuPreview> createState() => _PieMenuPreviewState();
}

class _PieMenuPreviewState extends State<PieMenuPreview> {
  PieMenu _pieMenu = PieMenu(name: "label-loading".i18n());
  List<PieItem> _pieItems = [];
  double angleDelta = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> updateParameterThenSetState() async {
    angleDelta = 2 * pi / _pieMenu.pieItems.length;
  }

  @override
  Widget build(BuildContext context) {
    _pieMenu = context.watch<PieMenuEditorPageViewModel>().pieMenu;
    _pieItems = context.select<PieMenuEditorPageViewModel, List<PieItem>>(
        (value) => value.pieItems);

    updateParameterThenSetState();
    final currentPieMenuId = context.select<PieMenuEditorPageViewModel, int>(
        (value) => value.currentPieItemId);

    const height = 35;

    angleDelta = 2 * pi / _pieItems.length;
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned(
              left: (constraints.maxWidth -
                      _pieMenu.centerRadius -
                      _pieMenu.centerThickness) /
                  2,
              bottom: (constraints.maxHeight -
                      _pieMenu.centerRadius -
                      _pieMenu.centerThickness) /
                  2,
              child: CustomPaint(
                size: Size(
                    (_pieMenu.centerRadius + _pieMenu.centerThickness)
                        .toDouble(),
                    (_pieMenu.centerRadius + _pieMenu.centerThickness)
                        .toDouble()),
                painter: PieCenterPainter(
                    centerThickness: _pieMenu.centerThickness.toDouble(),
                    backgroundColor: Color(_pieMenu.secondaryColor),
                    foregroundColor: Color(_pieMenu.mainColor),
                    numberOfPieItems: _pieItems.length),
              )),
          for (int i = 0; i < _pieItems.length; i++)
            Positioned(
              left: computeXAdjusted(i, constraints.maxWidth / 2),
              bottom:
                  computeYAdjusted(i, constraints.maxHeight / 2 - height / 2),
              child: GestureDetector(
                onTap: () {
                  context.read<PieMenuEditorPageViewModel>().currentPieItemId =
                      _pieItems.elementAt(i).id;
                },
                child: PieItemView(
                  name: _pieItems.elementAt(i).displayName,
                  icon: _pieItems.elementAt(i).iconBase64,
                  horizontalOffset: i % (_pieItems.length / 2) == 0
                      ? PieItemOffset.center
                      : i > _pieItems.length / 2
                          ? PieItemOffset.toLeft
                          : PieItemOffset.toRight,
                  borderRadius: _pieMenu.pieItemRoundness,
                  backgroundColor:
                      currentPieMenuId == _pieItems.elementAt(i).id
                          ? _pieMenu.mainColor
                          : _pieMenu.secondaryColor,
                  width: _pieMenu.pieItemWidth,
                  iconSize: _pieMenu.iconSize.toDouble(),
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
            angleDelta * i, _pieMenu.centerRadius + _pieMenu.pieItemSpread);

    if (i == 0) {
      yAdjusted += 10;
    }

    if (i == _pieItems.length / 2) {
      yAdjusted -= 10;
    }

    return yAdjusted;
  }

  /// Returns the x coordinate relative to the [originX] and adjusted
  /// the pie item so it looks more like in a circle.
  double computeXAdjusted(int i, double originX) {
    double rawX = getXFromBiasedPolar(
        angleDelta * i, _pieMenu.centerRadius + _pieMenu.pieItemSpread);
    double half = _pieItems.length / 2;
    if (i % half != 0) {
      rawX += i > half ? -_pieMenu.pieItemWidth / 2 : _pieMenu.pieItemWidth / 2;
    }

    return originX + rawX - _pieMenu.pieItemWidth / 2;
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
