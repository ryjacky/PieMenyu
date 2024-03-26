import 'package:flutter/material.dart';

class ModifierKeyToggleButtons extends StatefulWidget {
  final bool initialCtrlSelected; // Initial selection state for Ctrl
  final bool initialShiftSelected; // Initial selection state for Shift
  final bool initialAltSelected; // Initial selection state for Alt
  final void Function(bool ctrl, bool shift, bool alt)? onChanged; // Callback with individual selections

  const ModifierKeyToggleButtons({super.key,
    this.initialCtrlSelected = false,
    this.initialShiftSelected = false,
    this.initialAltSelected = false,
    this.onChanged,
  });

  @override
  State<ModifierKeyToggleButtons> createState() => _SpecialKeySelector();
}

class _SpecialKeySelector extends State<ModifierKeyToggleButtons> {
  final List<String> options = ["Ctrl", "Shift", "Alt"];
  List<bool> _selected = [false, false, false];

  @override
  void initState() {
    super.initState();
    _selected = [
      widget.initialCtrlSelected,
      widget.initialShiftSelected,
      widget.initialAltSelected,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: _selected,
      borderWidth: 2,
      color: Theme.of(context).colorScheme.primary, // Customize colors as needed
      fillColor: Theme.of(context).colorScheme.primary,
      selectedColor: Colors.white,
      borderRadius: BorderRadius.circular(6), // Set rounded border radius
      onPressed: (int index) {
        setState(() {
          _selected[index] = !_selected[index];
          widget.onChanged?.call(_selected[0], _selected[1], _selected[2]);
        });
      },
      children: options.map((option) => Text(option)).toList(),
    );
  }
}
