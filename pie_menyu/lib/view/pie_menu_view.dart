import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';

class PieMenuView extends StatefulWidget {
  final PieMenu pieMenu;

  const PieMenuView({super.key, required this.pieMenu});

  @override
  State<PieMenuView> createState() => _PieMenuViewState();
}

class _PieMenuViewState extends State<PieMenuView> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
