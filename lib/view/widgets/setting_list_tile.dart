import 'package:flutter/material.dart';

class SettingListTile extends ListTile {
  SettingListTile({super.key,
    required String title,
    required String subtitle,
    required Widget trailing,
    Color? tileColor,
  }) : super(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          tileColor: tileColor,
          trailing: trailing,
        );
}