import 'package:flutter/material.dart';
import 'package:pie_menyu/db/pie_menu.dart';

class PieMenuEditorPage extends StatefulWidget {
  final PieMenu pieMenu;
  const PieMenuEditorPage({super.key, required this.pieMenu});

  @override
  State<PieMenuEditorPage> createState() => _PieMenuEditorPageState();
}

class _PieMenuEditorPageState extends State<PieMenuEditorPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
