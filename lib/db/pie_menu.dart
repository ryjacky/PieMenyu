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
  String mainColor;
  String secondaryColor;
  String iconColor;
  int escapeRadius;
  int centerRadius;
  int centerThickness;
  int pieItemWidth;
  int iconSize;
  int pieItemRoundness;
  int pieItemSpread;

  IsarLinks<PieItem> pieItems = IsarLinks<PieItem>();

  @Backlink(to: 'pieMenus')
  IsarLinks<Profile> profiles = IsarLinks<Profile>();

  PieMenu({
    this.name = 'New Pie Menu',
    this.enabled = true,
    this.activationMode = PieMenuActivationMode.activateOnKeyDown,
    this.escapeRadius = 0,
    this.openInScreenCenter = false,
    this.mainColor = '#1DAEAA',
    this.secondaryColor = '#282828',
    this.iconColor = '#FFFFFF',
    this.centerRadius = 20,
    this.centerThickness = 10,
    this.pieItemWidth = 100,
    this.iconSize = 16,
    this.pieItemRoundness = 7,
    this.pieItemSpread = 150,
  });
}

enum PieMenuActivationMode {
  activateOnKeyDown
}