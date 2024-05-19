import 'package:flutter/material.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_editor/versioning/update_status_provider.dart';
import 'package:pie_menyu_editor/view/routes/home/home_page.dart';
import 'package:provider/provider.dart';

import 'home_page_view_model.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<Database>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomePageViewModel(db)),
          ChangeNotifierProvider(create: (_) => UpdateStatusProvider())
        ],
        child: const HomePage(),
      ),
    );
  }
}
