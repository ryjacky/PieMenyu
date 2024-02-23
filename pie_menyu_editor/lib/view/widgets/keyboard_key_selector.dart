import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pie_menyu_core/pieItemTasks/send_key_task.dart';
import 'package:pie_menyu_editor/view/widgets/key_press_recorder.dart';
import 'package:pie_menyu_editor/view/widgets/modifier_key_toggle_buttons.dart';
import 'package:pie_menyu_editor/view/widgets/special_key_selector.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class KeyboardKeySelector extends StatefulWidget {
  final Function(SendKeyTask hotkey)? onChange;

  const KeyboardKeySelector({
    super.key,
    this.onChange,
  });

  @override
  State<KeyboardKeySelector> createState() => _KeyboardKeySelectorState();
}

class _KeyboardKeySelectorState extends State<KeyboardKeySelector> {
  final SendKeyTask _hotkey = SendKeyTask();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.background),
            width: 300,
            height: 35,
            child: TabBar(
              dividerHeight: 0,
              tabs: [
                Tab(text: "label-simple".tr()),
                Tab(text: "label-advanced".tr()),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Gap(40),
                    Text(
                      "message-keyboard-selector-hint-simple-mode".tr(),
                      style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(40),
                    Transform.scale(
                      scale: 1.5,
                      child: SizedBox(
                        width: 450,
                        child: KeyPressRecorder(
                          onHotKeyRecorded: (event) {
                            _hotkey.ctrl = event.modifiers
                                    ?.contains(KeyModifier.control) ??
                                false;
                            _hotkey.shift =
                                event.modifiers?.contains(KeyModifier.shift) ??
                                    false;
                            _hotkey.alt =
                                event.modifiers?.contains(KeyModifier.alt) ??
                                    false;
                            _hotkey.key = event.keyCode.logicalKey;

                            widget.onChange?.call(_hotkey);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(10),
                    ModifierKeyToggleButtons(
                      onChanged: (ctrl, shift, alt) {
                        _hotkey.ctrl = ctrl;
                        _hotkey.shift = shift;
                        _hotkey.alt = alt;
                      },
                    ),
                    const Gap(10),
                    const Icon(Icons.add),
                    const Gap(10),
                    SizedBox(
                      width: 600,
                      child: SpecialKeySelector(
                        onSelectionChange: (key) {
                          _hotkey.key = key;
                          widget.onChange?.call(_hotkey);
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
