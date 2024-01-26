import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class TitleBar extends StatefulWidget {
  final Widget? leading;
  final Widget? title;

  const TitleBar({super.key, this.leading, this.title});

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  static const titlebarItemPadding = EdgeInsets.fromLTRB(5.0, 6.0, 5, 3);
  bool pieMenyuStatus = true;

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
              Padding(
                padding: titlebarItemPadding,
                child: widget.leading,
              ),
              if (widget.title != null) widget.title!,
              Expanded(child: MoveWindow()),
              Text(
                "label-pie-menyu-status".tr(),
                style: const TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: titlebarItemPadding,
                child: Transform.scale(
                  scale: 0.6,
                  child: Switch(
                    value: pieMenyuStatus,
                    onChanged: (bool value) {
                      setState(() => pieMenyuStatus = value);
                      launchUrl(
                          Uri.parse("piemenyu://${value ? "start" : "stop"}"));
                    },
                  ),
                ),
              ),
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
