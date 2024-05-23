import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_view.dart';
import 'package:pie_menyu_editor/view/coach/coach_provider.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/pie_menu_page_view_model.dart';
import 'package:pie_menyu_editor/view/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import 'package:spring/spring.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'escape_radius_preview.dart';

class PreviewPanel extends StatefulWidget {
  const PreviewPanel({super.key});

  @override
  State<PreviewPanel> createState() => _PreviewPanelState();
}

class _PreviewPanelState extends State<PreviewPanel> {
  final previewPieMenuKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final coachProvider = context.read<CoachProvider>();
      coachProvider.addTarget(
        CoachMark.pieMenuPreview,
        previewPieMenuKey,
        TargetContent(
          customPosition: CustomTargetContentPosition(top: 50, right: 35),
          align: ContentAlign.custom,
          padding: const EdgeInsets.only(left: 700),
          child: Text(
            "message-coach-pie-menu-preview".tr(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      );

      context
          .read<CoachProvider>()
          .showTutorial(context, mark: CoachMark.pieMenuPreview);
    });
  }

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
          key: previewPieMenuKey,
          state: pieMenuState,
          onTap: (instance) => pieMenuState.activePieItemDelegate = instance,
          pieSliceBuilder: (defaultPieSlice, index) => Draggable(
            onDragStarted: () => viewModel.isDragging = true,
            onDraggableCanceled: (_, __) => viewModel.isDragging = false,
            data: index,
            feedback: defaultPieSlice,
            childWhenDragging: Container(),
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
