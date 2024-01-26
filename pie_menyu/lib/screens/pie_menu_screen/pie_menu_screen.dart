import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mouse_event/mouse_event.dart';
import 'package:pie_menyu/hotkey/key_event_notifier.dart';
import 'package:pie_menyu/screens/pie_menu_screen/pie_menu_state_provider.dart';
import 'package:pie_menyu/window/pie_menyu_window_manager.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/executor/executor_service.dart';
import 'package:pie_menyu_core/pieItemTasks/mouse_click_task.dart';
import 'package:pie_menyu_core/pieItemTasks/move_window_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_app_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_editor_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_folder_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_sub_menu_task.dart';
import 'package:pie_menyu_core/pieItemTasks/open_url_task.dart';
import 'package:pie_menyu_core/pieItemTasks/resize_window_task.dart';
import 'package:pie_menyu_core/pieItemTasks/run_file_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu_core/pieItemTasks/send_text_task.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_view.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class PieMenuScreen extends StatefulWidget {
  const PieMenuScreen({super.key});

  @override
  State<PieMenuScreen> createState() => _PieMenuScreenState();
}

class _PieMenuScreenState extends State<PieMenuScreen> {
  static const _animationDuration = Duration(milliseconds: 200);
  static const _animationCurve = Curves.easeOutCubic;

  List<PieMenuState> _pieMenuStates = [];
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    MouseEventPlugin.startListening((event) async {
      final pieMenuPos = context.read<PieMenuStateProvider>().pieMenuPositions;

      if (!(await windowManager.isFocused()) || !context.mounted || pieMenuPos.isEmpty) return;

      _mousePosition = Offset(event.x.toDouble(), event.y.toDouble());
      final instance = getPieItemInstanceAt(
        _mousePosition,
        pieMenuPos[_pieMenuStates.last] ??= _mousePosition,
        _pieMenuStates.last.pieItemInstances,
      );

      if (instance != _pieMenuStates.last.activePieItemInstance &&
          instance != null) {
        _pieMenuStates.last.activePieItemInstance = instance;
      }
    });

    final keyEvent = context.read<SystemKeyEvent>();
    keyEvent.addKeyUpListener((hotkey) {
      final pieMenuStates = _pieMenuStates;
      if (pieMenuStates.lastOrNull == null ||
          pieMenuStates.firstOrNull?.behavior.activationMode !=
              ActivationMode.onRelease) return false;

      tryActivate(
        pieMenuStates.last,
        ActivationMode.onRelease,
      );
      return true;
    });

    HardwareKeyboard.instance.addHandler(_screenKeyEventHandler);

    super.initState();
  }

  bool _screenKeyEventHandler(KeyEvent event) {
    if (event is KeyDownEvent) {
      final lastPieMenuState = _pieMenuStates.lastOrNull;
      if (lastPieMenuState == null) {
        context.read<PieMenyuWindowManager>().hide();
        return false;
      }

      PieItemInstance? instanceOfKey = lastPieMenuState.pieItemInstances
          .where((instance) =>
              instance.keyCode.toUpperCase() == event.character?.toUpperCase())
          .firstOrNull;
      if (instanceOfKey == null) {
        if (!_isModifierKey(event.logicalKey)) {
          context.read<PieMenyuWindowManager>().hide();
        }
        return false;
      }

      lastPieMenuState.activePieItemInstance = instanceOfKey;

      tryActivate(
        lastPieMenuState,
        ActivationMode.onRelease,
      );
      return true;
    }

    return false;
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_screenKeyEventHandler);
    MouseEventPlugin.cancelListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pieMenuStates = context.watch<PieMenuStateProvider>().pieMenuStates;
    final pieMenuPos = context.read<PieMenuStateProvider>().pieMenuPositions;

    if (_pieMenuStates.isEmpty) {
      dev.log("No state is found, closing the window");
      context.read<PieMenyuWindowManager>().hide();
      return Container();
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(builder: (_, constraint) {
        return Stack(
          children: [
            for (final state in _pieMenuStates)
              buildPieMenuView(
                state,
                constraint,
                pieMenuPos[state] ??= _mousePosition,
                state == _pieMenuStates.last,
              )
          ],
        );
      }),
    );
  }

  PieItemInstance? getPieItemInstanceAt(
    Offset position,
    Offset pieCenterPosition,
    List<PieItemInstance> instances,
  ) {
    if (instances.isEmpty) return null;

    final dx = position.dx - pieCenterPosition.dx;
    // 0,0 is top left, so dy is inverted
    final dy = pieCenterPosition.dy - position.dy;
    // We want the angle of 12 o'clock to be 0, so we swap dx and dy
    double pieCenterRotation = atan2(dx, dy);

    if (dx < 0) {
      pieCenterRotation += 2 * pi;
    }

    // Offset the rotation by half the angle of a pie item,
    // which is the detection range
    pieCenterRotation += 2 * pi / instances.length / 2;

    var activeBtnIndex =
        (instances.length * pieCenterRotation / (2 * pi)).floor();

    // Because we offset the rotation by half the angle of a pie item,
    // we need to mod by the number of pie items to get the correct index
    return instances[activeBtnIndex % instances.length];
  }

  Widget buildPieMenuView(
    PieMenuState state,
    BoxConstraints constraint,
    Offset position,
    bool inForeground,
  ) {
    return AnimatedPositioned(
      left: position.dx - constraint.maxWidth / 2 - (inForeground ? 0 : 200),
      top: position.dy - constraint.maxHeight / 2 + (inForeground ? 0 : 100),
      duration: _animationDuration,
      curve: _animationCurve,
      child: SizedBox(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        child: AnimatedOpacity(
          opacity: inForeground ? 1.0 : 0.5,
          duration: _animationDuration,
          curve: _animationCurve,
          child: AnimatedScale(
            scale: inForeground ? 1.0 : 0.7,
            duration: _animationDuration,
            curve: _animationCurve,
            child: PieMenuView(
              state: state,
              onTap: (instance) {
                state.activePieItemInstance = instance;
                tryActivate(state, ActivationMode.onClick);
              },
              onHover: (instance) {
                state.activePieItemInstance = instance;
                tryActivate(state, ActivationMode.onHover);
              },
            ),
          ),
        ),
      ),
    );
  }

  tryActivate(
    PieMenuState state,
    ActivationMode mode,
  ) async {
    dev.log("ActivationMode: $mode", name: "PieMenuScreen tryActivate()");

    final pieMenuStates = context.read<PieMenuStateProvider>().pieMenuStates;
    PieItem? activePieItem = state.activePieItemInstance.pieItem;

    if (state != pieMenuStates.last || activePieItem == null) return;

    final mainMenuState = pieMenuStates[0];
    final bool isSubMenuItem = activePieItem.tasks.firstOrNull?.taskType ==
        PieItemTaskType.openSubMenu;

    dev.log("isSubMenuItem: $isSubMenuItem");

    final activationMode = isSubMenuItem
        ? mainMenuState.behavior.subMenuActivationMode
        : mainMenuState.behavior.activationMode;

    if (mode == ActivationMode.onRelease){
      await context.read<PieMenyuWindowManager>().hide();
    }

    if (activationMode == mode){
      if (isSubMenuItem) {
        dev.log("Opening sub menu", name: "PieMenuScreen tryActivate()");
        openSubMenu(activePieItem);
      } else if (context.mounted) {
        dev.log("Executing tasks", name: "PieMenuScreen tryActivate()");
        final executorService = context.read<ExecutorService>();
        if (mainMenuState == state) executorService.cancelAll();

        await context.read<PieMenyuWindowManager>().hide();

        addToExecutorQueue(executorService, activePieItem.tasks);
        executorService.start();
      }
    }
  }

  void openSubMenu(PieItem activePieItem) async {
    final tasks = activePieItem.tasks;
    if (tasks.length != 1) return;

    final openSubMenuTask = OpenSubMenuTask.from(tasks.first);
    final db = context.read<Database>();
    final pieMenu =
        (await db.getPieMenus(ids: [openSubMenuTask.subMenuId])).firstOrNull;

    if (pieMenu == null || !context.mounted) return;

    final pieMenuState = PieMenuState(db, pieMenu);
    final pieMenuStateProvider = context.read<PieMenuStateProvider>();
    pieMenuStateProvider.addState(pieMenuState);
  }

  void addToExecutorQueue(
      ExecutorService executorService, List<PieItemTask> tasks) {
    for (PieItemTask task in tasks) {
      switch (task.taskType) {
        case PieItemTaskType.sendKey:
          executorService.execute(SendKeyTask.from(task));
        case PieItemTaskType.mouseClick:
          executorService.execute(MouseClickTask.from(task));
        case PieItemTaskType.runFile:
          executorService.execute(RunFileTask.from(task));

        case PieItemTaskType.openFolder:
          executorService.execute(OpenFolderTask.from(task));
        case PieItemTaskType.openApp:
          executorService.execute(OpenAppTask.from(task));
        case PieItemTaskType.openUrl:
          executorService.execute(OpenUrlTask.from(task));
        case PieItemTaskType.openEditor:
          executorService.execute(OpenEditorTask.from(task));
        case PieItemTaskType.resizeWindow:
          executorService.execute(ResizeWindowTask.from(task));
        case PieItemTaskType.moveWindow:
          executorService.execute(MoveWindowTask.from(task));
        case PieItemTaskType.sendText:
          executorService.execute(PasteTextTask.from(task));
        case PieItemTaskType.openSubMenu:
          break;
      }
    }
  }

  bool _isModifierKey(LogicalKeyboardKey logicalKey) {
    return [
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.controlRight,
      LogicalKeyboardKey.controlLeft,
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.shiftRight,
      LogicalKeyboardKey.shiftLeft,
      LogicalKeyboardKey.alt,
      LogicalKeyboardKey.altRight,
      LogicalKeyboardKey.altLeft,
      LogicalKeyboardKey.meta,
      LogicalKeyboardKey.metaRight,
      LogicalKeyboardKey.metaLeft,
    ].contains(logicalKey);
  }
}
