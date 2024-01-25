import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pie_menyu_editor/system/task_bar_process_info/task_bar_process_info.dart';

class ProcessListTile extends StatefulWidget {
  final TaskBarProcessInfo processInfo;
  final Function(TaskBarProcessInfo info)? onTap;
  const ProcessListTile({super.key, required this.processInfo, this.onTap});

  @override
  State<ProcessListTile> createState() => _ProcessListTileState();
}

class _ProcessListTileState extends State<ProcessListTile> {
  Widget? image;

  @override
  void initState() {
    image ??= Image.memory(
      base64Decode(widget.processInfo.base64Icon),
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.question_mark,
            size: 32);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        title: Text(widget.processInfo.processName),
        subtitle: Text(widget.processInfo.exePath),
        leading: image,
        onTap: () => widget.onTap?.call(widget.processInfo),
      ),
    );
  }
}
