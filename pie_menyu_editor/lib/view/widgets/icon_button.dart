import 'package:flutter/material.dart';

class MonochromeIconButton extends TextButton {
  MonochromeIconButton({super.key, required IconData icon, super.onPressed})
      : super(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white70,
            padding: const EdgeInsets.all(0),
            minimumSize: const Size(45, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: const BorderSide(
              color: Colors.white24,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white70,
            size: 17,
          ),
        );
}
