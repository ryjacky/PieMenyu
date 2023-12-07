import 'package:isar/isar.dart';
import 'package:pie_menyu/db/pie_item.dart';
import 'package:pie_menyu/db/profile.dart';

part 'pie_menu.g.dart';

@collection
class PieMenu {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String name;
  bool enabled;

  @enumerated
  PieMenuActivationMode activationMode;
  bool openInScreenCenter;
  int mainColor;
  int secondaryColor;
  int iconColor;
  int escapeRadius;
  int centerRadius;
  int centerThickness;
  int iconSize;
  int pieItemRoundness;
  int pieItemSpread;

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
    this.mainColor = 0x1DAEAA,
    this.secondaryColor = 0x282828,
    this.iconColor = 0xFFFFFF,
    this.centerRadius = 20,
    this.centerThickness = 10,
    this.iconSize = 16,
    this.pieItemRoundness = 7,
    this.pieItemSpread = 150,
  });
}

enum PieMenuActivationMode {
  activateOnKeyDown
}