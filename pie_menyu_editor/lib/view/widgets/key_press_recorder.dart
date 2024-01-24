import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

// From the hotkey_manager package.
class _VirtualKeyView extends StatelessWidget {
  const _VirtualKeyView({required this.keyLabel});

  final String keyLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(3),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0.0, 1.0),
          ),
        ],
      ),
      child: Text(
        keyLabel,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 12,
        ),
      ),
    );
  }
}

class KeyPressRecorder extends StatefulWidget {
  const KeyPressRecorder({
    super.key,
    this.initialHotkey,
    required this.onHotKeyRecorded,
    this.validation,
    this.onClear,
  });

  final HotKey? initialHotkey;
  final ValueChanged<HotKey> onHotKeyRecorded;
  final ValueChanged<HotKey>? onClear;
  final bool Function(HotKey hotkey)? validation;

  @override
  State<KeyPressRecorder> createState() => _KeyPressRecorderState();
}

class _KeyPressRecorderState extends State<KeyPressRecorder> {
  bool ctrl = false;
  bool alt = false;
  bool shift = false;
  KeyCode? key;

  bool prevCtrl = false;
  bool prevAlt = false;
  bool prevShift = false;
  KeyCode? prevKey;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.onKeyEvent = _handleKeyEvent;

    if (widget.initialHotkey != null) {
      final modifiers = widget.initialHotkey!.modifiers;
      if (modifiers != null) {
        ctrl = modifiers.contains(KeyModifier.control);
        alt = modifiers.contains(KeyModifier.alt);
        shift = modifiers.contains(KeyModifier.shift);
      }
      key = widget.initialHotkey!.keyCode;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent keyEvent) {
    var isKeyDown = keyEvent is KeyDownEvent || keyEvent is KeyRepeatEvent;
    switch (keyEvent.logicalKey) {
      case LogicalKeyboardKey.escape:
        if (!ctrl && !alt && !shift) {
          _focusNode.unfocus();
          return KeyEventResult.handled;
        }
      case LogicalKeyboardKey.delete:
        if (!ctrl && !alt && !shift) {
          _clear();
          return KeyEventResult.handled;
        }
      case LogicalKeyboardKey.control:
      case LogicalKeyboardKey.controlLeft:
      case LogicalKeyboardKey.controlRight:
        ctrl = isKeyDown;
        break;
      case LogicalKeyboardKey.alt:
      case LogicalKeyboardKey.altLeft:
      case LogicalKeyboardKey.altRight:
        alt = isKeyDown;
        break;
      case LogicalKeyboardKey.shift:
      case LogicalKeyboardKey.shiftLeft:
      case LogicalKeyboardKey.shiftRight:
        shift = isKeyDown;
        break;
      default:
        if (KeyModifierParser.fromLogicalKey(keyEvent.logicalKey) != null) {
          return KeyEventResult.handled;
        }

        if (isKeyDown) {
          key = KeyCodeParser.fromLogicalKey(keyEvent.logicalKey);
          _focusNode.unfocus();
        } else if (keyEvent is KeyUpEvent) {
          key = null;
        }
    }

    setState(() {});
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Wrap(
          spacing: 8,
          children: [
            if (ctrl) const _VirtualKeyView(keyLabel: 'Ctrl'),
            if (alt) const _VirtualKeyView(keyLabel: 'Alt'),
            if (shift) const _VirtualKeyView(keyLabel: 'Shift'),
            if (key != null) _VirtualKeyView(keyLabel: key!.keyLabel),
          ],
        ),
        Focus(
          focusNode: _focusNode,
          onFocusChange: (focused) {
            if (focused) {
              _onFocus();
            } else {
              _onBlur();
            }
          },
          child: const TextField(
            cursorHeight: 0,
            cursorWidth: 0,
            inputFormatters: [],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(10),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  void _onFocus() {
    prevCtrl = ctrl;
    prevAlt = alt;
    prevShift = shift;
    prevKey = key;
    ctrl = false;
    alt = false;
    shift = false;
    key = null;
    setState(() {});
  }

  void resetToPrevious() {
    ctrl = prevCtrl;
    alt = prevAlt;
    shift = prevShift;
    key = prevKey;
    setState(() {});

    _focusNode.unfocus();
  }

  void _clear() {
    widget.onClear?.call(HotKey(
      prevKey!,
      modifiers: [
        if (prevCtrl) KeyModifier.control,
        if (prevAlt) KeyModifier.alt,
        if (prevShift) KeyModifier.shift,
      ],
    ));

    prevAlt = false;
    prevCtrl = false;
    prevShift = false;
    prevKey = null;
    ctrl = false;
    alt = false;
    shift = false;
    key = null;

    _focusNode.unfocus();
  }

  void _onBlur() {
    if (key == null) {
      resetToPrevious();
      return;
    }

    final hotkey = HotKey(
      key!,
      modifiers: [
        if (ctrl) KeyModifier.control,
        if (alt) KeyModifier.alt,
        if (shift) KeyModifier.shift,
      ],
    );
    final validationResult = widget.validation?.call(hotkey) ?? true;
    if (validationResult) {
      widget.onHotKeyRecorded(hotkey);
    } else {
      resetToPrevious();
    }
  }
}
