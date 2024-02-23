import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpecialKeySelector extends StatefulWidget {
  final List<LogicalKeyboardKey> specialKeys = const [
    LogicalKeyboardKey.f13,
    LogicalKeyboardKey.f14,
    LogicalKeyboardKey.f15,
    LogicalKeyboardKey.f16,
    LogicalKeyboardKey.f17,
    LogicalKeyboardKey.f18,
    LogicalKeyboardKey.f19,
    LogicalKeyboardKey.f20,
    LogicalKeyboardKey.f21,
    LogicalKeyboardKey.f22,
    LogicalKeyboardKey.f23,
    LogicalKeyboardKey.f24,
    LogicalKeyboardKey.printScreen,
    LogicalKeyboardKey.audioVolumeUp,
    LogicalKeyboardKey.audioVolumeDown,
    LogicalKeyboardKey.audioVolumeMute,
    LogicalKeyboardKey.mediaPlay,
    LogicalKeyboardKey.mediaTrackNext,
    LogicalKeyboardKey.mediaTrackPrevious,
    LogicalKeyboardKey.home,
    LogicalKeyboardKey.find,
  ];

  final Function(LogicalKeyboardKey key)? onSelectionChange;

  const SpecialKeySelector({super.key, this.onSelectionChange});

  @override
  State<SpecialKeySelector> createState() => _ButtonGridState();
}

class _ButtonGridState extends State<SpecialKeySelector> {
  LogicalKeyboardKey? selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      alignment: WrapAlignment.spaceBetween,
      children: [
        for (LogicalKeyboardKey key in widget.specialKeys)
          TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                backgroundColor: selected == key
                    ? Theme.of(context).colorScheme.background
                    : Colors.black12,
                foregroundColor: Colors.transparent),
            onPressed: () {
              setState(() => selected = key);
              widget.onSelectionChange?.call(key);
            },
            child: Text(
              key.keyLabel,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
      ],
    );
  }
}
