import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_menyu/hotkey/system_key_event.dart';
import 'package:pie_menyu/screens/pie_menu_screen/pie_menu_screen_view_model.dart';
import 'package:pie_menyu/screens/pie_menu_screen/pie_menu_state_provider.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_view.dart';
import 'package:provider/provider.dart';

class PieMenuScreen extends StatefulWidget {
  const PieMenuScreen({super.key});

  @override
  State<PieMenuScreen> createState() => _PieMenuScreenState();
}

class _PieMenuScreenState extends State<PieMenuScreen> {
  static const _animationDuration = Duration(milliseconds: 500);
  static const _animationCurve = Curves.easeOutCubic;

  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    final viewModel = context.read<PieMenuScreenViewModel>();
    context
        .read<SystemKeyEvent>()
        .addKeyUpListener(viewModel.systemKeyEventListener);

    HardwareKeyboard.instance.addHandler(viewModel.screenKeyEventHandler);

    super.initState();
  }

  _processMouseEvent(PointerEvent event) {
    final pieMenuStates = context.read<PieMenuStateProvider>().pieMenuStates;

    if (pieMenuStates.isEmpty) return;
    final lastPieMenuPos = context
        .read<PieMenuStateProvider>()
        .pieMenuPositions[pieMenuStates.last];

    if (lastPieMenuPos == null) return;

    _mousePosition = event.position;

    // Do nothing and hide the menu if the mouse is outside the escape radius
    // if the escape radius is set
    if (pieMenuStates.last.behavior.escapeRadius > 0 &&
        getPointerToPieCenterLength(_mousePosition, lastPieMenuPos) >
            pieMenuStates.last.behavior.escapeRadius) {
      context.read<PieMenuScreenViewModel>().clearStateAndHide();
      return;
    }

    final instance = getPieItemDelegateAt(
      _mousePosition,
      lastPieMenuPos,
      pieMenuStates.last.shape.centerRadius,
      pieMenuStates.last.pieItemDelegates,
    );

    if (instance != pieMenuStates.last.activePieItemDelegate &&
        instance != null) {
      pieMenuStates.last.activePieItemDelegate = instance;
    }
  }

  @override
  void dispose() {
    final viewModel = context.read<PieMenuScreenViewModel>();

    context
        .read<SystemKeyEvent>()
        .removeKeyUpListener(viewModel.systemKeyEventListener);
    HardwareKeyboard.instance.removeHandler(viewModel.screenKeyEventHandler);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pieMenuStates = context.watch<PieMenuStateProvider>().pieMenuStates;
    final pieMenuPos = context.read<PieMenuStateProvider>().pieMenuPositions;

    // When the top menu is a sub menu and the display position is not set,
    // we want to set it prior to rendering for a seamless user experience
    if (pieMenuStates.isNotEmpty &&
        pieMenuPos[pieMenuStates.last] == null &&
        pieMenuStates.last != pieMenuStates.first) {
      pieMenuPos[pieMenuStates.last] = _mousePosition;
    }

    return pieMenuStates.isEmpty
        ? Container()
        : MouseRegion(
            onHover: _processMouseEvent,
            onEnter: (e) => setState(() {
              if (pieMenuStates.last.behavior.openInScreenCenter) {
                pieMenuPos[pieMenuStates.last] = Offset(
                  MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height / 2,
                );
              } else {
                pieMenuPos[pieMenuStates.last] ??= e.position;
              }
            }),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: LayoutBuilder(builder: (_, constraint) {
                return Stack(
                  children: [
                    for (final state in pieMenuStates)
                      if (pieMenuPos[state] != null)
                        buildPieMenuView(
                          state,
                          constraint,
                          pieMenuPos[state]!,
                          state == pieMenuStates.last,
                        ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black54,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        margin: const EdgeInsets.all(10),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            key: ValueKey(pieMenuStates.length),
                            getPieMenuRoute(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
  }

  PieItemDelegate? getPieItemDelegateAt(
    Offset position,
    Offset pieCenterPosition,
    double pieCenterRadius,
    List<PieItemDelegate> instances,
  ) {
    if (instances.isEmpty) return null;

    if (getPointerToPieCenterLength(position, pieCenterPosition) <=
        pieCenterRadius) {
      return instances[0];
    }

    final dx = position.dx - pieCenterPosition.dx;
    // 0,0 is top left, so dy is inverted
    final dy = pieCenterPosition.dy - position.dy;
    // We want the angle of 12 o'clock to be 0, so we swap dx and dy
    double pieCenterRotation = atan2(dx, dy);

    if (dx < 0) {
      pieCenterRotation += 2 * pi;
    }

    final nPieItems = instances.length - 1;
    // Offset the rotation by half the angle of a pie item,
    // which is the detection range
    pieCenterRotation += 2 * pi / nPieItems / 2;

    var activeBtnIndex = (nPieItems * pieCenterRotation / (2 * pi)).floor();

    // Because we offset the rotation by half the angle of a pie item,
    // we need to mod by the number of pie items to get the correct index
    return instances[activeBtnIndex % nPieItems + 1];
  }

  Widget buildPieMenuView(
    PieMenuState state,
    BoxConstraints constraint,
    Offset position,
    bool inForeground,
  ) {
    final viewModel = context.read<PieMenuScreenViewModel>();
    final pieMenuStates = context.watch<PieMenuStateProvider>().pieMenuStates;

    return Positioned(
      left: position.dx - constraint.maxWidth / 2,
      top: position.dy - constraint.maxHeight / 2,
      child: SizedBox(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        child: AnimatedOpacity(
          opacity: inForeground ? 1.0 : 0,
          duration: _animationDuration,
          curve: _animationCurve,
          child: AnimatedScale(
            scale: inForeground ? 1.0 : 0.7,
            duration: _animationDuration,
            curve: _animationCurve,
            child: PieMenuView(
              state: state,
              onTap: (instance) {
                state.activePieItemDelegate = instance;
                viewModel.tryActivate(state, ActivationMode.onClick);
              },
              onHover: (instance) {
                if (state != pieMenuStates.last) return;

                state.activePieItemDelegate = instance;
                viewModel.tryActivate(state, ActivationMode.onHover);
              },
            ),
          ),
        ),
      ),
    );
  }

  double getBackgroundSlicePositionY(PieMenuState state) {
    double y = 0;
    for (final s
        in context.read<PieMenuStateProvider>().pieMenuStates.reversed) {
      if (s == state) break;
      y += s.runtimeHeight;
    }

    return y;
  }

  String getPieMenuRoute() {
    final pieMenuStates = context.read<PieMenuStateProvider>().pieMenuStates;
    final route = pieMenuStates.map((e) => e.name).join(" > ");
    return route;
  }

  double getPointerToPieCenterLength(Offset pos, Offset pieCenterPos) {
    return sqrt(
        pow(pos.dx - pieCenterPos.dx, 2) + pow(pos.dy - pieCenterPos.dy, 2));
  }
}
