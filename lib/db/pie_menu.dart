import 'package:isar/isar.dart';

part 'pie_menu.g.dart';

@collection
class PieMenu {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String name;
  bool enabled;

  @enumerated
  PieMenuActivationMode activationMode;
  int escapeRadius;
  bool openInScreenCenter;
  String mainColor;
  String secondaryColor;
  String iconColor;
  List<int> pieItemIds;
  int centerRadius;
  int centerThickness;
  int pieItemWidth;
  int iconSize;
  int pieItemRoundness;
  int pieItemSpread;

  PieMenu({
    this.name = 'New Pie Menu',
    this.enabled = true,
    this.activationMode = PieMenuActivationMode.activateOnKeyDown,
    this.escapeRadius = 0,
    this.openInScreenCenter = false,
    this.mainColor = '#1DAEAA',
    this.secondaryColor = '#282828',
    this.iconColor = '#FFFFFF',
    this.pieItemIds = const [],
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