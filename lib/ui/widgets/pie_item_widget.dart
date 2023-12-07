import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

enum PieItemOffset { toRight, toLeft, center }

class PieItemWidget extends StatefulWidget {
  final int width;
  final int height;
  final int backgroundColor;
  final int borderRadius;
  final PieItemOffset horizontalOffset;

  const PieItemWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.backgroundColor,
      required this.borderRadius,
      this.horizontalOffset = PieItemOffset.toRight});

  @override
  State<PieItemWidget> createState() => _PieItemWidgetState();
}

class _PieItemWidgetState extends State<PieItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width.toDouble(),
      child: Row(
          mainAxisAlignment: widget.horizontalOffset == PieItemOffset.toRight
              ? MainAxisAlignment.start
              : widget.horizontalOffset == PieItemOffset.toLeft
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius.toDouble()),
                  color: Color(widget.backgroundColor),
                ),
                padding: const EdgeInsets.all(5),
                height: widget.height.toDouble(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FaIcon(FontAwesomeIcons.plus),
                      Gap(10),
                      Text("data")
                    ])),
          ]),
    );
  }
}
