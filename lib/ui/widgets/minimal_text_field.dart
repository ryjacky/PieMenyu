import 'package:flutter/material.dart';

class MinimalTextField extends TextField {
  const MinimalTextField({super.key, super.controller})
      : super(
            decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(10),
          isDense: true,
        ));
}
