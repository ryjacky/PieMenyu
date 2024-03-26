import 'package:flutter/material.dart';

class CompactDropdownMenu<T> extends DropdownMenu<T> {
  CompactDropdownMenu({
    super.key,
    required super.dropdownMenuEntries,
    super.onSelected,
    super.initialSelection,
    super.width,
  }) : super(
          menuHeight: 300,
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            constraints: BoxConstraints.tight(const Size.fromHeight(40)),
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
}
