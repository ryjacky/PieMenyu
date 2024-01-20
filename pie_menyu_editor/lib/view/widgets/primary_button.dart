import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrimaryButton extends StatelessWidget {
  final IconData icon;
  final Widget label;
  final VoidCallback onPressed;

  const PrimaryButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
        child: FaIcon(icon, size: 20),
      ),
      label: label,
    );
  }
}
