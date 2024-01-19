import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleAlphanumericInputField extends StatefulWidget {
  final Function(String value) onSubmitted;
  final String initialValue;

  const SingleAlphanumericInputField({super.key, required this.onSubmitted, required this.initialValue});

  @override
  State<SingleAlphanumericInputField> createState() => _SingleAlphanumericInputFieldState();
}

class _SingleAlphanumericInputFieldState extends State<SingleAlphanumericInputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
    _focusNode.onKeyEvent = (node, event) {
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        _controller.clear();
        setState(() {});
        widget.onSubmitted("");
        _focusNode.unfocus();
      } else if (event.character != null &&
          RegExp(r'[a-zA-Z0-9]').hasMatch(event.character!)) {
        _controller.text = event.character!.toUpperCase();
        setState(() {});
        widget.onSubmitted(_controller.text);
        _focusNode.unfocus();
      }
      return KeyEventResult.handled;
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        isDense: true,
        border: OutlineInputBorder(),
      ),
      onTap: () {
        _focusNode.requestFocus();
      },
    );
  }
}
