import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CollapsableColorPicker extends StatelessWidget {
  final Color color;
  final Widget title;
  final Function(Color) onColorChanged;

  const CollapsableColorPicker(
      {super.key,
      required this.color,
      required this.onColorChanged,
      required this.title});

  final double colorIndicatorSize = 26;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      dense: true,
      horizontalTitleGap: 10.0,
      child: ExpansionTile(
        backgroundColor: Colors.transparent,
        title: title,
        leading: ColorIndicator(
          color: color,
          width: colorIndicatorSize,
          height: colorIndicatorSize,
          borderColor: Colors.white24,
          hasBorder: true,
        ),
        children: [
          ColorPicker(
            color: color,
            pickersEnabled: const {},
            subheading: Text("label-select-color-shade".i18n()),
            width: colorIndicatorSize,
            height: colorIndicatorSize,
            onColorChanged: onColorChanged,
          ),
        ],
      ),
    );
  }
}
