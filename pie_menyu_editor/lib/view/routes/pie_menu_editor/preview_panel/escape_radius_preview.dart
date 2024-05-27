import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class EscapeRadiusPreview extends DottedBorder {
  EscapeRadiusPreview(double escapeRadius)
      : super(
          color: Colors.blue,
          borderType: BorderType.Circle,
          dashPattern: [3, (2 * pi * escapeRadius - 100) / 100],
          strokeWidth: 3.0,
          child: SizedBox.square(dimension: escapeRadius * 2),
        );
}
