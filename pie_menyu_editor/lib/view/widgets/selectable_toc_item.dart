import 'package:flutter/material.dart';

class SelectableTOCItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onTap;

  const SelectableTOCItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface
            ),
          ),
        ),
      ),
    );
  }
}