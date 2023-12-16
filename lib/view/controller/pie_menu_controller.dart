import 'package:flutter/widgets.dart';
import 'package:pie_menyu/db/pie_item.dart';
import 'package:pie_menyu/db/pie_menu.dart';

class PieMenuController extends ValueNotifier<PieMenu> {
  PieMenuController(super.value);

  void update(PieMenu pieMenu){
    value = pieMenu;
    notifyListeners();
  }

  void addPieItem(PieItem pieItem) {
    value.pieItems.add(pieItem);
    notifyListeners();
  }

  void updateProperties(
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
}
