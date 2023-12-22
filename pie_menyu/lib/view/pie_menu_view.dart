import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/painter/pie_center_painter.dart';

class PieMenuView extends StatefulWidget {
  final Offset mousePosition;
  final PieMenu pieMenu;
  final List<PieItem> pieItems;
  const PieMenuView({super.key, required this.mousePosition, required this.pieMenu, required this.pieItems});

  @override
  State<PieMenuView> createState() => _PieMenuViewState();
}

class _PieMenuViewState extends State<PieMenuView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: CustomPaint(
              size: Size(
                (widget.pieMenu.centerRadius + widget.pieMenu.centerThickness).toDouble(),
                (widget.pieMenu.centerRadius + widget.pieMenu.centerThickness).toDouble(),
              ),
              painter: PieCenterPainter(
                  centerThickness: widget.pieMenu.centerThickness.toDouble(),
                  backgroundColor: Color(widget.pieMenu.secondaryColor),
                  foregroundColor: Color(widget.pieMenu.mainColor),
                  numberOfPieItems: widget.pieItems.length),
            ),
          ),
          // for (int i = 0; i < _pieItems.length; i++)
          //   Positioned(
          //     left: computeXAdjusted(i, constraints.maxWidth / 2),
          //     bottom:
          //     computeYAdjusted(i, constraints.maxHeight / 2 - height / 2),
          //     child: GestureDetector(
          //       onTap: () {
          //         context.read<PieMenuEditorPageViewModel>().currentPieItemId =
          //             _pieItems.elementAt(i).id;
          //       },
          //       child: PieItemView(
          //         name: _pieItems.elementAt(i).displayName,
          //         icon: _pieItems.elementAt(i).iconBase64,
          //         horizontalOffset: i % (_pieItems.length / 2) == 0
          //             ? PieItemOffset.center
          //             : i > _pieItems.length / 2
          //             ? PieItemOffset.toLeft
          //             : PieItemOffset.toRight,
          //         borderRadius: widget.pieMenu.pieItemRoundness,
          //         backgroundColor:
          //         currentPieMenuId == _pieItems.elementAt(i).id
          //             ? widget.pieMenu.mainColor
          //             : widget.pieMenu.secondaryColor,
          //         width: widget.pieMenu.pieItemWidth,
          //         iconSize: widget.pieMenu.iconSize.toDouble(),
          //       ),
          //     ),
          //   ),
        ],
      );
    });
  }
}
