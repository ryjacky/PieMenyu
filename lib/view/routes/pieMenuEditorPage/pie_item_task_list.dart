import 'package:flutter/widgets.dart';
import 'package:pie_menyu/db/pie_item_task.dart';
import 'package:pie_menyu/view/widgets/hotkey_task_card.dart';
import 'package:provider/provider.dart';

import 'pie_menu_editor_page_view_model.dart';

class PieItemTaskList extends StatelessWidget {
  const PieItemTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPieItemId = context.select<PieMenuEditorPageViewModel, int>(
            (value) => value.currentPieMenuId);

    final List<PieItemTask> pieItemTasks =
    context.select<PieMenuEditorPageViewModel, List<PieItemTask>>(
            (viewModel) => viewModel.tasksOfPieItem[currentPieItemId] ?? []);

    return ListView(
      children: [
        for (final PieItemTask pieItemTask in pieItemTasks)
          HotkeyTaskCard(pieItemTask: pieItemTask),
      ],
    );
  }
}
