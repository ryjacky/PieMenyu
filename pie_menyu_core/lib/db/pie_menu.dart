library pie_menyu_core;

import 'package:isar/isar.dart';

import 'pie_item.dart';
import 'profile.dart';

part 'pie_menu.g.dart';

@collection
class PieMenu {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String name;
  bool enabled;

  @enumerated
  PieMenuActivationMode activationMode;
  String fontName;
  bool openInScreenCenter;
  int mainColor;
  int secondaryColor;
  int fontColor;
  int iconColor;
  int escapeRadius;
  int centerRadius;
  int centerThickness;
  int iconSize;
  int fontSize;
  int pieItemRoundness;
  int pieItemSpread;
  List<int> pieItemOrder = [];

  final int pieItemWidth = 512;

  IsarLinks<PieItem> pieItems = IsarLinks<PieItem>();

  @Backlink(to: 'pieMenus')
  IsarLinks<Profile> profiles = IsarLinks<Profile>();

  PieMenu({
    this.name = 'New Pie Menu',
    this.enabled = true,
    this.activationMode = PieMenuActivationMode.activateOnKeyDown,
    this.escapeRadius = 0,
    this.openInScreenCenter = false,
    this.mainColor = 0xFF1DAEAA,
    this.secondaryColor = 0xFF282828,
    this.iconColor = 0xFFFFFFFF,
    this.fontColor = 0xFFFFFFFF,
    this.fontSize = 14,
    this.centerRadius = 20,
    this.centerThickness = 10,
    this.iconSize = 32,
    this.pieItemRoundness = 7,
    this.pieItemSpread = 150,
    this.fontName = 'Roboto',
  });

  PieMenu.from(PieMenu pieMenu)
      : name = pieMenu.name,
        enabled = pieMenu.enabled,
        activationMode = pieMenu.activationMode,
        escapeRadius = pieMenu.escapeRadius,
        openInScreenCenter = pieMenu.openInScreenCenter,
        mainColor = pieMenu.mainColor,
        secondaryColor = pieMenu.secondaryColor,
        iconColor = pieMenu.iconColor,
        centerRadius = pieMenu.centerRadius,
        centerThickness = pieMenu.centerThickness,
        iconSize = pieMenu.iconSize,
        pieItemRoundness = pieMenu.pieItemRoundness,
        pieItemSpread = pieMenu.pieItemSpread,
        fontName = pieMenu.fontName,
        fontSize = pieMenu.fontSize,
        fontColor = pieMenu.fontColor;
}

enum PieMenuActivationMode { activateOnKeyDown }
