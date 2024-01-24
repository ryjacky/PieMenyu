import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:provider/provider.dart';

import '../home_page_view_model.dart';

class ProfileListItem extends StatefulWidget {
  final Profile profile;
  final VoidCallback onPressed;

  const ProfileListItem({super.key, required this.profile, required this.onPressed});

  @override
  State<ProfileListItem> createState() => _ProfileListItemState();
}

class _ProfileListItemState extends State<ProfileListItem> {
  double iconSize = 35;
  Image? icon;

  @override
  Widget build(BuildContext context) {
    final activeProfile = context
        .select<HomePageViewModel, Profile>((value) => value.activeProfile);

    icon ??= Image.memory(
      base64Decode(widget.profile.iconBase64),
      width: iconSize,
      filterQuality: FilterQuality.medium,
    );

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
        backgroundColor: widget.profile != activeProfile
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.background,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        alignment: Alignment.centerLeft,
      ),
      icon: icon!,
      label: Text(
        widget.profile.name,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
