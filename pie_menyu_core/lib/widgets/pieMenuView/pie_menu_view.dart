import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_center.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';

import '../../db/pie_menu.dart';
import '../pie_item_view.dart';

class PieMenuView extends StatefulWidget {
  final PieMenuState state;

  final Function(PieItemDelegate instance)? onTap;
  final Function(PieItemDelegate instance)? onHover;
  final Widget? Function(PieItemView defaultPieSlice, int index)?
      pieSliceBuilder;

  const PieMenuView({
    super.key,
    required this.state,
    this.onTap,
    this.onHover,
    this.pieSliceBuilder,
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
    final nSlices = state.pieItemDelegates.length - 1;
    final pieItemInstances = state.pieItemDelegates;
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
                    arcAngle: state.activePieItemDelegate ==
                            pieItemInstances.firstOrNull
                        ? 2 * pi
                        : angleDelta,
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
                      child: buildPieSlice(
                        PieItemView(
                          horizontalOffset: i % (nSlices / 2) == 0
                              ? PieItemOffset.center
                              : i > nSlices / 2
                                  ? PieItemOffset.toLeft
                                  : PieItemOffset.toRight,
                          icon: state.icon,
                          font: state.font,
                          colors: state.colors,
                          shape: state.shape,
                          instance: state.pieItemDelegates[i + 1],
                          active: state.activePieItemDelegate ==
                              pieItemInstances[i + 1],
                          height: state.runtimeHeight,
                        ),
                        i + 1,
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
    final pieItemPosition = widget.state.pieItemDelegates
        .indexOf(widget.state.activePieItemDelegate);

    if (pieItemPosition == 0) {
      return 2 * pi;
    } else {
      double result = 2 *
          pi *
          (widget.state.pieItemDelegates
                  .indexOf(widget.state.activePieItemDelegate) -
              1) /
          (widget.state.pieItemDelegates.length - 1);
      return (result.isNaN || result.isInfinite) ? 0 : result;
    }
  }

  double getHorizontalOffset(int i, BoxConstraints constraints) {
    final shape = widget.state.shape;
    return getOriginX(constraints) +
        ((shape.centerRadius + shape.pieItemSpread) * sin(i * angleDelta))
            .abs() -
        widget.state.runtimeHeight / 2;
  }

  double getVerticalOffset(int i, BoxConstraints constraints) {
    final shape = widget.state.shape;

    return getOriginY(constraints) +
        ((shape.centerRadius + shape.pieItemSpread) * cos(i * angleDelta)) -
        widget.state.runtimeHeight / 2;
  }

  buildPieSlice(PieItemView pieSliceView, int index) {
    return widget.pieSliceBuilder?.call(pieSliceView, index) ?? pieSliceView;
  }
}
