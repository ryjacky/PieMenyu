import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_view.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/pie_menu_page_view_model.dart';
import 'package:pie_menyu_editor/view/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import 'package:spring/spring.dart';

import 'escape_radius_preview.dart';

class PreviewPanel extends StatefulWidget {
  const PreviewPanel({super.key});

  @override
  State<PreviewPanel> createState() => _PreviewPanelState();
}

class _PreviewPanelState extends State<PreviewPanel> {
  @override
  Widget build(BuildContext context) {
    final pieMenuState = context.watch<PieMenuState>();

    final viewModel = context.read<PieMenuEditorPageViewModel>();
    final dragging = context
        .select<PieMenuEditorPageViewModel, bool>((value) => value.isDragging);

    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: PrimaryButton(
              onPressed: () => pieMenuState
                  .putPieItem(PieItem(name: "label-new-pie-item".tr())),
              label: Text("label-new-pie-item".tr()),
              icon: FontAwesomeIcons.plus,
            ),
          ),
        ),
        if (pieMenuState.behavior.escapeRadius > 0)
          EscapeRadiusPreview(pieMenuState.behavior.escapeRadius),
        PieMenuView(
          state: pieMenuState,
          onTap: (instance) => pieMenuState.activePieItemDelegate = instance,
          pieSliceBuilder: (defaultPieSlice, index) => Draggable(
            onDragStarted: () => viewModel.isDragging = true,
            onDraggableCanceled: (_, __) => viewModel.isDragging = false,
            data: index,
            feedback: defaultPieSlice,
            childWhenDragging: Opacity(opacity: 0.3, child: defaultPieSlice),
            child: DragTarget<int>(
              builder: (_, __, ___) {
                return dragging
                    ? Spring.blink(
                        child: defaultPieSlice,
                        endOpacity: 0.6,
                        curve: Curves.easeInOut,
                        animDuration: const Duration(milliseconds: 500))
                    : defaultPieSlice;
              },
              onAcceptWithDetails: (details) {
                context.read<PieMenuState>().swapPieItem(details.data, index);
                viewModel.isDragging = false;
              },
            ),
          ),
        ),
      ],
    );
  }
}
