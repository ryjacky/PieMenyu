import 'package:isar/isar.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_item_task.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_editor/view/routes/pieMenuEditorPage/pie_menu_state.dart';

extension DBExtended on DB {
  static save(PieMenuState state) async {
    for (PieItem pieItem in state.pieItems) {
      List<PieItemTask> putTasks =
          await putPieItemTask(state.pieItemTasks[pieItem.id] ?? {});

      if (pieItem.id < 0) {
        pieItem.id = Isar.autoIncrement;
        await DB.putPieItem(pieItem);
      }
      await saveTaskTo(pieItem, putTasks);

    }

    await DB.putPieMenu(state.pieMenu);
    await savePieItemsTo(state.pieMenu, state.pieItems.toList());
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

  static savePieItemsTo(PieMenu pieMenu, List<PieItem> pieItems) async {
    await pieMenu.pieItems.load();
    final originalPieItems = pieMenu.pieItems.toList();
    pieMenu.pieItems.removeAll(originalPieItems);
    await DB.isar.writeTxn(() async {
      // Must save before add again or else addAll in next line will not work
      await pieMenu.pieItems.save();
    });

    pieMenu.pieItems.addAll(pieItems);
    await DB.isar.writeTxn(() async {
      await pieMenu.pieItems.save();
    });
  }
}
