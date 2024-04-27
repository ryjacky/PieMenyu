import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pie_menyu_core/db/db.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';
import 'package:pie_menyu_core/widgets/pieMenuView/pie_menu_state.dart';

void main() {
  group('PieMenuState', () {
    test('load initializes properties correctly', () async {
      final db = Database(Directory.systemTemp);
      PieMenu pieMenu = PieMenu()
        ..name = 'My Pie Menu'
        ..enabled = true
        ..colors = PieMenuColors()
        ..iconStyle = (PieMenuIconStyle()
          ..color = 0xFF000000 // Black color
          ..size = 24) // Smaller size
        ..font = (PieMenuFont()
          ..color = 0xFF000000 // Black color
          ..size = 16 // Larger size
          ..fontFamily = 'Arial') // Different font
        ..behavior = (PieMenuBehavior()
          ..escapeRadius = 10 // Larger escape radius
          ..openInScreenCenter = true // Open in screen center
          ..activationMode = ActivationMode.onClick // Activate on click
          ..subMenuActivationMode =
              ActivationMode.onClick) // Submenu activate on click
        ..shape = (PieMenuShape()
          ..centerRadius = 30 // Larger center radius
          ..centerThickness = 15 // Thicker center
          ..pieItemRoundness = 10 // More roundness
          ..pieItemSpread = 70) // Larger spread
        ..pieItemInstances = [
          PieItemDelegate(keyCode: 'c', pieItemId: 1),
          PieItemDelegate(keyCode: 'd', pieItemId: 2)
        ];
      final pieMenuState = PieMenuState.fromPieMenu(db, pieMenu);

      while (!pieMenuState.loaded) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      expect(pieMenuState.colors.primary, equals(0xFF1DAEAA));
      expect(pieMenuState.colors.secondary, equals(0xFF282828));
      expect(pieMenuState.icon.color, equals(0xFF000000));
      expect(pieMenuState.icon.size, equals(24.0));
      expect(pieMenuState.font.color, equals(0xFF000000));
      expect(pieMenuState.font.size, equals(16.0));
      expect(pieMenuState.font.fontFamily, equals('Arial'));
      expect(pieMenuState.behavior.escapeRadius, equals(10.0));
      expect(pieMenuState.behavior.openInScreenCenter, isTrue);
      expect(
          pieMenuState.behavior.activationMode, equals(ActivationMode.onClick));
      expect(pieMenuState.behavior.subMenuActivationMode,
          equals(ActivationMode.onClick));
      expect(pieMenuState.shape.centerRadius, equals(30.0));
      expect(pieMenuState.shape.centerThickness, equals(15.0));
      expect(pieMenuState.shape.pieItemRoundness, equals(10.0));
      expect(pieMenuState.shape.pieItemSpread, equals(70.0));
      expect(pieMenuState.pieItemDelegates.length, 2);
      expect(pieMenuState.activePieItemDelegate.keyCode, equals('c'));
      expect(pieMenuState.activePieItemDelegate.pieItemId, equals(1));
    });
  });
}
