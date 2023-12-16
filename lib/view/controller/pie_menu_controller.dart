import 'package:flutter/widgets.dart';
import 'package:pie_menyu/db/pie_item.dart';
import 'package:pie_menyu/db/pie_item_task.dart';
import 'package:pie_menyu/db/pie_menu.dart';

class PieMenuController extends ValueNotifier<PieMenu> {
  PieMenuController(super.value);

  @override
  set value(PieMenu pieMenu){
    super.value = pieMenu;
    notifyListeners();
  }

  void addPieItem(PieItem pieItem) {
    value.pieItems.add(pieItem);
    notifyListeners();
  }

  void update(
      {String? name,
      bool? enabled,
      PieMenuActivationMode? activationMode,
      bool? openInScreenCenter,
      int? mainColor,
      int? secondaryColor,
      int? iconColor,
      int? escapeRadius,
      int? centerRadius,
      int? centerThickness,
      int? iconSize,
      int? pieItemRoundness,
      int? pieItemSpread}) {

    value
    ..name = name ?? value.name
    ..enabled = enabled ?? value.enabled
    ..activationMode = activationMode ?? value.activationMode
    ..openInScreenCenter = openInScreenCenter ?? value.openInScreenCenter
    ..mainColor = mainColor ?? value.mainColor
    ..secondaryColor = secondaryColor ?? value.secondaryColor
    ..iconColor = iconColor ?? value.iconColor
    ..escapeRadius = escapeRadius ?? value.escapeRadius
    ..centerRadius = centerRadius ?? value.centerRadius
    ..centerThickness = centerThickness ?? value.centerThickness
    ..iconSize = iconSize ?? value.iconSize
    ..pieItemRoundness = pieItemRoundness ?? value.pieItemRoundness
    ..pieItemSpread = pieItemSpread ?? value.pieItemSpread;

    notifyListeners();
  }

  void updatePieItem(PieItem pieItem, {
    String? iconBase64,
    String? displayName,
    bool? enabled,
    PieItemTask? pieItemTask,
  }) {
    pieItem
    ..iconBase64 = iconBase64 ?? pieItem.iconBase64
    ..displayName = displayName ?? pieItem.displayName
    ..enabled = enabled ?? pieItem.enabled;

    if (pieItemTask != null) {
      pieItem.beginningTask.value = pieItemTask;
    }

    notifyListeners();
  }
}
