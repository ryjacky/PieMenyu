import 'dart:math';

import 'package:flutter/material.dart';

class PieCenterPainter extends CustomPainter {
  final double centerThickness;
  final Color backgroundColor;
  final Color foregroundColor;
  final int numberOfPieItems;

  PieCenterPainter(
      {required this.centerThickness,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.numberOfPieItems});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - centerThickness / 2;

    // draw a circle with backgroundColor, centerThickness, and size
    final circlePaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = centerThickness
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, circlePaint);

    // draw an arc with foregroundColor, centerThickness, and size, each arc is of 2pi/numberOfPieItems
    final arcPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = centerThickness
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        0 - pi / 2 - pi / numberOfPieItems,
        2 * pi / numberOfPieItems, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
