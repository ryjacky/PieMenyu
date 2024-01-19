import 'package:isar/isar.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_editor/view/routes/pie_menu_editor/pie_menu_state.dart';

extension DBExtended on DB {
  static save(PieMenuState state) async {
    for (PieItem pieItem in state.pieItems) {
      List<PieItemTask> putTasks =
          await putPieItemTask(state.pieItemTasks[pieItem.id] ?? {});

      if (pieItem.id < 0) {
        pieItem.id = Isar.autoIncrement;
      }
      await DB.putPieItem(pieItem);

      await saveTaskTo(pieItem, putTasks);
    }

    state.pieMenu.pieItemInstances = state.pieItemInstances
        .map((e) => PieItemInstance(pieItemId: e.pieItemId, keyCode: e.keyCode))
        .toList();
    await DB.putPieMenu(state.pieMenu);
  }

  static Future<List<PieItemTask>> putPieItemTask(Set<PieItemTask> task) async {
    final List<PieItemTask> tasks = [];
    for (PieItemTask pieItemTask in task) {
      if (pieItemTask.id == PieMenuState.deleteId) {
        continue;
      }
      if (pieItemTask.id < 0) {
        pieItemTask.id = Isar.autoIncrement;
      }

      tasks.add(pieItemTask);
    }

    await DB.isar.writeTxn(() async {
      await DB.isar.pieItemTasks.putAll(tasks);
    });

    return tasks;
  }

  static saveTaskTo(PieItem pieItem, List<PieItemTask> tasks) async {
    await pieItem.tasks.load();
    final originalTasks = pieItem.tasks.toList();
    pieItem.tasks.removeAll(originalTasks);
    await DB.isar.writeTxn(() async {
      // Must save before add again or else addAll in next line will not work
      await pieItem.tasks.save();
    });

    pieItem.tasks.addAll(tasks);
    await DB.isar.writeTxn(() async {
      await pieItem.tasks.save();
    });
  }
}
