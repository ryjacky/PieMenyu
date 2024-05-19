import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FilePickerDroppable extends StatelessWidget {
  final String? path;
  final bool isDirectory;
  final List<String>? allowedExtension;
  final Function(String path)? onPicked;

  const FilePickerDroppable(
      {super.key,
      this.path,
      this.onPicked,
      this.isDirectory = false,
      this.allowedExtension});

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (file) async {
        String? path = file.files.firstOrNull?.path;
        if (path == null) return;

        bool pValid = false;
        pValid = pValid || (isDirectory && await Directory(path).exists());
        pValid = pValid ||
            (!isDirectory &&
                await File(path).exists() &&
                (allowedExtension?.any((ext) => path.endsWith(ext)) ?? true));

        if (!pValid) return;

        onPicked?.call(path);
      },
      child: DottedBorder(
        stackFit: StackFit.passthrough,
        strokeWidth: 2,
        dashPattern: const [5, 2],
        borderType: BorderType.RRect,
        radius: const Radius.circular(5),
        padding: const EdgeInsets.all(5),
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          children: [
            Text("label-selected-file".tr()),
            Text(path ?? "message-drag-n-drop-to-pick-file".tr()),
            const Gap(5),
            TextButton(
              onPressed: () async {
                String? result;
                if (isDirectory) {
                  result = await FilePicker.platform.getDirectoryPath();
                } else {
                  result = (await FilePicker.platform.pickFiles(
                    allowedExtensions: allowedExtension,
                    type: allowedExtension == null
                        ? FileType.any
                        : FileType.custom,
                  ))
                      ?.files
                      .firstOrNull
                      ?.path;
                }

                if (result != null) onPicked?.call(result);
              },
              child: Text("label-pick-file".tr()),
            ),
          ],
        ),
      ),
    );
  }
}
