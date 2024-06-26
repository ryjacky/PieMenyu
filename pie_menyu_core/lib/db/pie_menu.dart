library pie_menyu_core;

import 'package:isar/isar.dart';

import 'pie_item.dart';
import 'profile.dart';

part 'pie_menu.g.dart';

@embedded
class PieMenuColors {
  int primary = 0xFF1DAEAA;
  int secondary = 0xFF282828;

  PieMenuColors();

  PieMenuColors.from(PieMenuColors colors)
      : primary = colors.primary,
        secondary = colors.secondary;

  @override
  operator ==(Object other) {
    return other is PieMenuColors &&
        primary == other.primary &&
        secondary == other.secondary;
  }
}

@embedded
class PieMenuIconStyle {
  int color = 0xFFFFFFFF;
  double size = 32;

  PieMenuIconStyle();

  PieMenuIconStyle.from(PieMenuIconStyle icon)
      : color = icon.color,
        size = icon.size;

  @override
  operator ==(Object other) {
    return other is PieMenuIconStyle &&
        color == other.color &&
        size == other.size;
  }
}

@embedded
class PieMenuFont {
  int color = 0xFFFFFFFF;
  double size = 14;
  String fontFamily = 'Roboto';

  PieMenuFont();

  PieMenuFont.from(PieMenuFont font)
      : color = font.color,
        size = font.size,
        fontFamily = font.fontFamily;

  @override
  operator ==(Object other) {
    return other is PieMenuFont &&
        color == other.color &&
        size == other.size &&
        fontFamily == other.fontFamily;
  }
}

enum ActivationMode { onRelease, onHover, onClick }

@embedded
class PieMenuBehavior {
  double escapeRadius = 0;
  bool openInScreenCenter = false;
  @enumerated
  ActivationMode activationMode = ActivationMode.onRelease;
  @enumerated
  ActivationMode subMenuActivationMode = ActivationMode.onHover;

  PieMenuBehavior();

  PieMenuBehavior.from(PieMenuBehavior behavior)
      : escapeRadius = behavior.escapeRadius,
        openInScreenCenter = behavior.openInScreenCenter,
        activationMode = behavior.activationMode,
        subMenuActivationMode = behavior.subMenuActivationMode;

  @override
  operator ==(Object other) {
    return other is PieMenuBehavior &&
        escapeRadius == other.escapeRadius &&
        openInScreenCenter == other.openInScreenCenter &&
        activationMode == other.activationMode &&
        subMenuActivationMode == other.subMenuActivationMode;
  }
}

@embedded
class PieMenuShape {
  double centerRadius = 20;
  double centerThickness = 10;
  double pieItemRoundness = 7;
  double pieItemSpread = 65;

  PieMenuShape();

  PieMenuShape.from(PieMenuShape shape)
      : centerRadius = shape.centerRadius,
        centerThickness = shape.centerThickness,
        pieItemRoundness = shape.pieItemRoundness,
        pieItemSpread = shape.pieItemSpread;

  @override
  operator ==(Object other) {
    return other is PieMenuShape &&
        centerRadius == other.centerRadius &&
        centerThickness == other.centerThickness &&
        pieItemRoundness == other.pieItemRoundness &&
        pieItemSpread == other.pieItemSpread;
  }
}

@embedded
class PieItemDelegate {
  String keyCode = "";
  int pieItemId;

  /// This will only be used if [isMenu] is true
  @enumerated
  ActivationMode activationMode = ActivationMode.onRelease;

  @ignore
  PieItem? pieItem;

  PieItemDelegate({this.keyCode = "", this.pieItemId = 0});

  factory PieItemDelegate.from(PieItemDelegate info) {
    final instance =
        PieItemDelegate(keyCode: info.keyCode, pieItemId: info.pieItemId);
    if (info.pieItem != null) {
      instance.pieItem = PieItem.from(info.pieItem!);
    }
    return instance;
  }
}

@collection
class PieMenu {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String name = 'New Pie Menu';
  bool enabled = true;

  PieMenuColors colors = PieMenuColors();
  PieMenuIconStyle iconStyle = PieMenuIconStyle();
  PieMenuFont font = PieMenuFont();
  PieMenuBehavior behavior = PieMenuBehavior();
  PieMenuShape shape = PieMenuShape();

  List<PieItemDelegate> pieItemInstances = [];

  @Backlink(to: 'pieMenus')
  IsarLinks<Profile> profiles = IsarLinks<Profile>();

  PieMenu();

  PieMenu.from(PieMenu pieMenu)
      : id = pieMenu.id,
        colors = PieMenuColors.from(pieMenu.colors),
        iconStyle = PieMenuIconStyle.from(pieMenu.iconStyle),
        font = PieMenuFont.from(pieMenu.font),
        behavior = PieMenuBehavior.from(pieMenu.behavior),
        shape = PieMenuShape.from(pieMenu.shape),
        pieItemInstances = pieMenu.pieItemInstances
            .map((e) => PieItemDelegate.from(e))
            .toList();
}
