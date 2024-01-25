import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pie_menyu_editor/view/widgets/flat_button.dart';
import 'package:provider/provider.dart';

import '../home_page_view_model.dart';

class CreateProfileButton extends StatelessWidget {
  const CreateProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    final creatingProfile = context
        .select<HomePageViewModel, bool>((value) => value.creatingProfile);
    return FlatButton(
      onPressed: context.read<HomePageViewModel>().toggleCreateProfileMode,
      icon: creatingProfile ? Icons.arrow_back : Icons.create,
      label: Text((creatingProfile ? "button-back" : "button-create").i18n()),
    );
  }
}
