import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CollapsableColorPicker extends StatefulWidget {
  final Color color;
  final Widget title;
  final Function(Color) onColorChanged;

  const CollapsableColorPicker(
      {super.key,
      required this.color,
      required this.onColorChanged,
      required this.title});

  @override
  State<CollapsableColorPicker> createState() => _CollapsableColorPickerState();
}

class _CollapsableColorPickerState extends State<CollapsableColorPicker> {
  final double colorIndicatorSize = 26;
  Color _color = Colors.transparent;

  @override
  void initState() {
    _color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      dense: true,
      horizontalTitleGap: 10.0,
      child: ExpansionTile(
        backgroundColor: Colors.transparent,
        title: widget.title,
        leading: ColorIndicator(
          color: _color,
          width: colorIndicatorSize,
          height: colorIndicatorSize,
          borderColor: Colors.white24,
          hasBorder: true,
        ),
        children: [
          ColorPicker(
            color: _color,
            pickersEnabled: const {
              ColorPickerType.primary: true,
              ColorPickerType.wheel: true,
              ColorPickerType.accent: false,
            },
            subheading: Text("label-select-color-shade".tr()),
            width: colorIndicatorSize,
            height: colorIndicatorSize,
            onColorChanged: (Color color) {
              setState(() {
                _color = color;
              });
              widget.onColorChanged(color);
            },
          ),
        ],
      ),
    );
  }
}
