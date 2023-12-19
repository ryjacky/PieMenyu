import 'dart:convert';

import 'package:flutter/material.dart';

enum PieItemOffset { toRight, toLeft, center }

class PieItemWidget extends StatefulWidget {
  final int width;
  final int backgroundColor;
  final int borderRadius;
  final String name;
  final String icon;
  final PieItemOffset horizontalOffset;
  final double iconSize;

  const PieItemWidget(
      {super.key,
      required this.width,
      required this.backgroundColor,
      required this.borderRadius,
      required this.name,
      required this.iconSize,
      this.icon = "",
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
                height: widget.iconSize,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Image.memory(
                    base64Decode(widget.icon),
                    width: widget.iconSize,
                    height: widget.iconSize,
                    fit: BoxFit.fitHeight,
                    isAntiAlias: true,
                    errorBuilder: (context, object, error) {
                      return const SizedBox(width: 0, height: 0);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(widget.name),
                  )
                ])),
          ]),
    );
  }
}
