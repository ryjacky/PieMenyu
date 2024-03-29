import 'dart:math';

import 'package:flutter/material.dart';

class DraggableNumberField extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final double step;
  final Function(double value) onChanged;

  const DraggableNumberField(
      {super.key,
      required this.value,
      required this.onChanged,
      this.step = 1,
      this.min = 0,
      this.max = 100});

  @override
  State<DraggableNumberField> createState() => _DraggableNumberFieldState();
}

class _DraggableNumberFieldState extends State<DraggableNumberField> {
  bool ignoreMouse = true;
  double value = 0;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          if (details.delta.dx != 0)  {
            value += details.delta.dx > 0 ? widget.step : -widget.step;
          }

          value = max(min(widget.max, value), widget.min);
          widget.onChanged(value);
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeLeft,
        child: IgnorePointer(
          child: TextField(
              onChanged: (String content) {
                double? value = double.tryParse(content);
                if (value != null) {
                  this.value = max(min(widget.max, value), widget.min);
                  widget.onChanged(value);
                }
              },
              controller: TextEditingController(text: "$value"),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
                isDense: true,
              )),
        ),
      ),
    );
  }
}
