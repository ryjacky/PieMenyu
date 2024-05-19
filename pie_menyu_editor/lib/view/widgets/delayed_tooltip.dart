import 'package:flutter/material.dart';

class DelayedTooltip extends Tooltip {
  const DelayedTooltip({super.key, super.message, super.child})
      : super(
    preferBelow: false,
    waitDuration: const Duration(milliseconds: 500),
  );
}
