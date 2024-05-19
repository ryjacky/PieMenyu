import 'dart:math';

import 'package:flutter/material.dart';

class PieCenter extends CustomPaint {
  PieCenter({
    super.key,
    super.size,
    double arcAngle = 2 * pi,
    required double centerThickness,
    required Color backgroundColor,
    required Color highlightColor,
    required bool onCenter,
  }) : super(
    painter: _PieCenterPainter(
      centerThickness: centerThickness,
      backgroundColor: backgroundColor,
      highlightColor: highlightColor,
      arcAngle: arcAngle,
      onCenter: onCenter,
    ),
  );
}

class _PieCenterPainter extends CustomPainter {
  final double centerThickness;
  final Color backgroundColor;
  final Color highlightColor;
  final double arcAngle;
  final bool onCenter;

  _PieCenterPainter({
    required this.centerThickness,
    required this.backgroundColor,
    required this.highlightColor,
    required this.arcAngle,
    required this.onCenter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - centerThickness / 2;

    _drawCircle(canvas, center, radius, backgroundColor, centerThickness);

    if (arcAngle != 2 * pi) {
      _drawArc(
          canvas, center, radius, highlightColor, centerThickness, arcAngle);
    } else if (!onCenter) {
      _drawCircle(canvas, center, radius + centerThickness / 2, highlightColor,
          centerThickness / 2);
    } else {
      _drawCircle(canvas, center, radius - centerThickness / 2, highlightColor,
          centerThickness / 2);
    }
  }

  void _drawCircle(Canvas canvas, Offset center, double radius, Color color,
      double strokeWidth) {
    final circlePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, circlePaint);
  }

  void _drawArc(Canvas canvas, Offset center, double radius, Color color,
      double strokeWidth, double arcAngle) {
    final arcPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 - arcAngle / 2,
      arcAngle,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
