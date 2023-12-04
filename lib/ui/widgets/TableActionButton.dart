import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TableActionButton extends TextButton {

  TableActionButton(
      {super.key,
      super.onLongPress,
      required IconData icon,
      required Color color,
      super.onPressed})
      : super(
            style: TextButton.styleFrom(
              foregroundColor: color,
              minimumSize: const Size(32, 32),
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: color,
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: FaIcon(
                icon,
                color: color,
                size: 15,
              ),
            ));
}
