import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlatButton extends StatelessWidget {
  final IconData icon;
  final Widget label;
  final VoidCallback onPressed;

  const FlatButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.from(
        colorScheme: Theme.of(context).colorScheme,
        useMaterial3: false,
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
          child: FaIcon(icon, size: 20),
        ),
        label: label,
      ),
    );
  }
}
