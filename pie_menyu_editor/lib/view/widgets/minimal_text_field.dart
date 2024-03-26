import 'package:flutter/material.dart';

class MinimalTextField extends StatefulWidget {
  final Function(String)? onSubmitted;
  final String content;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const MinimalTextField({
    super.key,
    this.content = "",
    this.onSubmitted,
    this.keyboardType,
    this.controller,
  });

  @override
  State<MinimalTextField> createState() => _MinimalTextFieldState();
}

class _MinimalTextFieldState extends State<MinimalTextField> {
  String content = "";

  @override
  void initState() {
    super.initState();
    content = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus && widget.onSubmitted != null) {
          widget.onSubmitted!(content);
        }
      },
      child: TextField(
        onChanged: (String content) {
          this.content = content;
        },
        controller: widget.controller ?? TextEditingController(text: content),
        keyboardType: widget.keyboardType,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(10),
          isDense: true,
        ),
      ),
    );
  }
}
