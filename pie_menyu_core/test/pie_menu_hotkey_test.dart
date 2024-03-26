import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pie_menyu_core/db/profile.dart';

void main() {
  group('PieMenuHotkey', () {
    test('creates instances with default values', () {
      final hotkey = PieMenuHotkey();
      expect(hotkey.ctrl, false);
      expect(hotkey.shift, false);
      expect(hotkey.alt, false);
      expect(hotkey.keyId, null);
      expect(hotkey.pieMenuId, 0);
    });

    test('creates instances with specified values', () {
      final hotkey = PieMenuHotkey(
        ctrl: true,
        shift: true,
        alt: true,
        keyId: LogicalKeyboardKey.keyA.keyId,
        pieMenuId: 42,
      );
      expect(hotkey.ctrl, true);
      expect(hotkey.shift, true);
      expect(hotkey.alt, true);
      expect(hotkey.keyId, LogicalKeyboardKey.keyA.keyId);
      expect(hotkey.pieMenuId, 42);
    });

    test('implements equality correctly', () {
      final hotkey1 = PieMenuHotkey(keyId: LogicalKeyboardKey.keyS.keyId);
      final hotkey2 = PieMenuHotkey(keyId: LogicalKeyboardKey.keyS.keyId);
      final hotkey3 = PieMenuHotkey(keyId: LogicalKeyboardKey.keyA.keyId);
      expect(hotkey1, hotkey2);
      expect(hotkey1 != hotkey3, true);
    });

    test('generates correct LogicalKeySet', () {
      final hotkey = PieMenuHotkey(
        ctrl: true,
        shift: true,
        alt: true,
        keyId: LogicalKeyboardKey.keyZ.keyId,
      );
      final expectedKeySet = LogicalKeySet.fromSet({
        LogicalKeyboardKey.control,
        LogicalKeyboardKey.shift,
        LogicalKeyboardKey.alt,
        LogicalKeyboardKey.keyZ,
      });
      expect(hotkey.keySet, expectedKeySet);
    });

    test('returns null for keySet when keyId is null', () {
      final hotkey = PieMenuHotkey();
      expect(hotkey.keySet, null);
    });
  });
}
