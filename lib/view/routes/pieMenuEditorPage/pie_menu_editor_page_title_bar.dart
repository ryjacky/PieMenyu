import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class PieMenuEditorPageTitleBar extends StatelessWidget {
  const PieMenuEditorPageTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonColors = WindowButtonColors(
        iconNormal: Theme.of(context).colorScheme.primary,
        mouseOver: const Color(0x0DFFFFFF),
        mouseDown: const Color(0x1AFFFFFF),
        iconMouseOver: Theme.of(context).colorScheme.primary,
        iconMouseDown: Theme.of(context).colorScheme.primary);

    final closeButtonColors = WindowButtonColors(
        mouseOver: const Color(0xFFD32F2F),
        mouseDown: const Color(0xFFB71C1C),
        iconNormal: Theme.of(context).colorScheme.primary,
        iconMouseOver: Colors.white);

    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
      child: WindowTitleBarBox(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Row(
            children: [
              Expanded(child: MoveWindow()),
              MinimizeWindowButton(colors: buttonColors),
              MaximizeWindowButton(colors: buttonColors),
              CloseWindowButton(colors: closeButtonColors),
            ],
          ),
        ),
      ),
    );
  }
}
