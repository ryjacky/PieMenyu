import 'package:flutter/material.dart';
import 'package:pie_menyu_editor/view/widgets/compact_dropdown_menu.dart';

class LanguageDropdownMenu extends CompactDropdownMenu<String> {
  LanguageDropdownMenu({
    super.key,
    super.onSelected,
    super.initialSelection,
  }) : super(
          dropdownMenuEntries: const [
            DropdownMenuEntry(
              label: "English",
              value: "en",
            ),
            DropdownMenuEntry(
              label: "日本語",
              value: "ja",
            ),
          ],
        );
}
