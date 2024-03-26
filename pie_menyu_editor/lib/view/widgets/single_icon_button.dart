import 'package:flutter/material.dart';

class SingleColorIconButton extends TextButton {
  SingleColorIconButton({
    super.key,
    required IconData icon,
    super.onPressed,
    Color color = Colors.white70,
  }) : super(
          style: TextButton.styleFrom(
            foregroundColor: color,
            padding: const EdgeInsets.all(0),
            minimumSize: const Size(45, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            backgroundColor: color.withOpacity(0.1),
          ),
          child: Icon(
            icon,
            color: color,
            size: 17,
          ),
        );
}
