import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleKeyRecorder extends StatefulWidget {
  final Function(String value) onSubmitted;
  final String initialValue;
  final TextEditingController controller;

  const SingleKeyRecorder({super.key, required this.onSubmitted, required this.initialValue});
  const SingleKeyRecorder({
    super.key,
    required this.onSubmitted,
    required this.controller,
  });

  @override
  State<SingleKeyRecorder> createState() => _SingleKeyRecorderState();
}

class _SingleKeyRecorderState extends State<SingleKeyRecorder> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.onKeyEvent = (node, event) {
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        widget.controller.clear();
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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.text,
      showCursor: false,
      enableInteractiveSelection: false,
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
