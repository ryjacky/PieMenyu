import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pie_menyu_core/db/profile.dart';
import 'package:provider/provider.dart';

import '../home_page_view_model.dart';

class ProfileActionButtons extends StatefulWidget {
  final VoidCallback? onDelete;
  final VoidCallback onPause;

  const ProfileActionButtons({
    super.key,
    required this.onDelete,
    required this.onPause,
  });

  @override
  State<ProfileActionButtons> createState() => _ProfileActionButtonsState();
}

class _ProfileActionButtonsState extends State<ProfileActionButtons> {
  bool showConfirmation = false;
  Profile? prevProfile;

  @override
  Widget build(BuildContext context) {
    final activeProfile = context
        .select<HomePageViewModel, Profile>((value) => value.activeProfile);

    if (prevProfile != activeProfile) {
      prevProfile = activeProfile;
      showConfirmation = false;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white.withOpacity(0.05),
      ),
      padding: const EdgeInsets.all(4),
      child: showConfirmation
          ? buildConfirmDelete()
          : buildActionButtonPanel(activeProfile),
    );
  }

  Row buildActionButtonPanel(Profile activeProfile) {
    return Row(
      children: [
        IconButton(
          onPressed: widget.onPause,
          icon: Icon(
            activeProfile.enabled ? Icons.pause : Icons.play_arrow_outlined,
            size: 16,
          ),
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(5),
            minimumSize: const Size(0, 0),
          ),
        ),
        const Gap(4),
        IconButton(
          onPressed: widget.onDelete == null
              ? null
              : () => setState(() => showConfirmation = !showConfirmation),
          icon: const Icon(Icons.delete, size: 16),
          color: Colors.red,
          style: IconButton.styleFrom(
            backgroundColor: Colors.red.withOpacity(0.1),
            padding: const EdgeInsets.all(5),
            minimumSize: const Size(0, 0),
          ),
        ),
      ],
    );
  }

  Row buildConfirmDelete() {
    return Row(
      children: [
        const Gap(5),
        Text("label-sure-question".tr()),
        const Gap(5),
        IconButton(
          onPressed: () {
            widget.onDelete?.call();
            setState(() => showConfirmation = false);
          },
          icon: const Icon(Icons.check, size: 16),
          color: Colors.red,
          style: IconButton.styleFrom(
            backgroundColor: Colors.red.withOpacity(0.1),
            padding: const EdgeInsets.all(5),
            minimumSize: const Size(0, 0),
          ),
        ),
        const Gap(4),
        IconButton(
          onPressed: () => setState(() => showConfirmation = false),
          icon: const Icon(Icons.close, size: 16),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.05),
            padding: const EdgeInsets.all(5),
            minimumSize: const Size(0, 0),
          ),
        ),
      ],
    );
  }
}
