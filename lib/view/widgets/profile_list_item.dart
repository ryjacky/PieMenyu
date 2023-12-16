import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pie_menyu/db/profile.dart';

class ProfileListItem extends StatefulWidget {
  final Profile profile;
  final bool active;
  final VoidCallback onPressed;

  const ProfileListItem({super.key, required this.profile, required this.active, required this.onPressed});

  @override
  State<ProfileListItem> createState() => _ProfileListItemState();
}

class _ProfileListItemState extends State<ProfileListItem> {
  double iconSize = 35;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.background,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: !widget.active
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.background,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        alignment: Alignment.centerLeft,
      ),
      icon: Image.memory(
        base64Decode(widget.profile.iconBase64),
        width: iconSize,
        filterQuality: FilterQuality.medium,
      ),
      label: Text(
        widget.profile.name,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
