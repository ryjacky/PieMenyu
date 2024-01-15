import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class KeyPressRecorder extends StatefulWidget {
  const KeyPressRecorder({
    Key? key,
    this.initalHotKey,
    required this.onHotKeyRecorded,
    this.validation,
  }) : super(key: key);
  final HotKey? initalHotKey;
  final ValueChanged<HotKey> onHotKeyRecorded;
  final bool Function(HotKey hotkey)? validation;

  @override
  State<KeyPressRecorder> createState() => _KeyPressRecorderState();
}

class _KeyPressRecorderState extends State<KeyPressRecorder> {
  HotKey? _hotKey;
  HotKey? _oldHotKey;

  bool _toReset = false;
  Set<KeyModifier> _keyModifiers = {};
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    if (widget.initalHotKey != null) {
      _hotKey = widget.initalHotKey!;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(KeyEvent keyEvent) {
    KeyCode keyCode = KeyCode.space;

    KeyModifier? keyModifier =
        KeyModifierParser.fromLogicalKey(keyEvent.logicalKey);

    if (keyEvent is KeyDownEvent) {
      if (_toReset) {
        setState(() {
          _toReset = false;
          _hotKey = null;
          _keyModifiers.clear();
        });
      }

      // Only set keyCode if the key pressed is not a modifier key.
      // Because we don't want to display two modifier keys in the widget.
      if (keyModifier == null) {
        final newKeyCode = KeyCodeParser.fromLogicalKey(keyEvent.logicalKey) ?? KeyCode.space;
        if ((widget.validation?.call(HotKey(newKeyCode, modifiers: _keyModifiers.toList())) ?? true)) {
          keyCode = newKeyCode;
        } else {
          _hotKey = _oldHotKey;
          setState(() {});
          _focusNode.unfocus();

          return KeyEventResult.handled;
        }
      } else {
        _keyModifiers.add(keyModifier);
      }
    } else if (keyEvent is KeyUpEvent) {
      if (keyModifier != null) {
        _keyModifiers.remove(keyModifier);
      }
    }

    // _hotkey is set in every key event so the widget display can respond
    // immediately to the user's input.
    _hotKey = HotKey(
      keyCode,
      modifiers: _keyModifiers.toList(),
    );

    // Remove the 'placeholder' empty block when no modifier keys are pressed.
    if (_keyModifiers.isEmpty && keyCode == KeyCode.space) {
      _hotKey = null;
    }

    // We use non-modifier keys as the 'trigger key' for
    if (keyCode != KeyCode.space && _hotKey != null) {
      widget.onHotKeyRecorded(_hotKey!);
      _focusNode.unfocus();
    }

    setState(() {});

    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (_hotKey == null)
          Container()
        else
          HotKeyVirtualView(hotKey: _hotKey!),
        Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              _toReset = true;
              _oldHotKey = _hotKey;
            }
          },
          focusNode: _focusNode,
          onKeyEvent: (focusNode, keyEvent) {
            return _handleKeyEvent(keyEvent);
          },
          child: TextField(
              controller: _textEditingController,
              cursorHeight: 0,
              cursorWidth: 0,
              onChanged: (value) => _textEditingController.clear(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
                isDense: true,
              )),
        ),
      ],
    );
  }
}
