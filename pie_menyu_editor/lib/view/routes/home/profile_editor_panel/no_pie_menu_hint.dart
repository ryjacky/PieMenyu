import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoPieMenuHint extends StatelessWidget {
  const NoPieMenuHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          child: Text("label-no-pie-menu-hint".tr(),
              style: Theme.of(context).textTheme.labelMedium),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
          width: 350,
          height: 150,
          child: SvgPicture.asset(
            'assets/images/no_pie_menu_hint.svg',
            colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}
