import 'package:flutter/material.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_view.dart';
import 'package:provider/provider.dart';

import 'escape_radius_preview.dart';

class PreviewPanel extends StatelessWidget {
  const PreviewPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pieMenuState = context.watch<PieMenuState>();

    return Stack(
      alignment: Alignment.center,
      children: [
        if (pieMenuState.behavior.escapeRadius > 0)
          EscapeRadiusPreview(pieMenuState.behavior.escapeRadius),

        PieMenuView(
          state: pieMenuState,
          onTap: (instance) => pieMenuState.activePieItemDelegate = instance,
        ),
      ],
    );
  }
}
