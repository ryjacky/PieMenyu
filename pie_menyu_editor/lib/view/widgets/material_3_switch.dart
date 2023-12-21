import 'package:flutter/material.dart';

class Material3Switch extends StatelessWidget {
  final bool value;
  final Function(bool value)? onChanged;
  final Color? activeColor;

  const Material3Switch(
      {super.key, required this.value, this.onChanged, this.activeColor});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            useMaterial3: true,
            colorScheme: Theme.of(context).colorScheme,
            textTheme: Theme.of(context).textTheme),
        child: Switch(
            value: value, onChanged: onChanged, activeColor: activeColor));
  }
}
