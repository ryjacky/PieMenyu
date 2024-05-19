import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pie_menyu_editor/preferences/editor_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

enum CoachMark { hotkeyRecorder, pieMenyuStatusSwitch }

class CoachProvider extends ChangeNotifier {
  final Map<CoachMark, TargetFocus> _targets = {};

  final EditorPreferences _prefs;

  bool _isCoachReady = false;

  bool get isCoachReady => _isCoachReady;

  set isCoachReady(bool value) {
    _isCoachReady = value;
    notifyListeners();
  }

  CoachProvider(this._prefs);

  void addTarget(CoachMark mark, GlobalKey keyTarget, TargetContent content) {
    _targets[mark] = TargetFocus(
      identify: mark.name,
      keyTarget: keyTarget,
      contents: [content],
      // shape: ShapeLightFocus.RRect,
      // radius: 10,
    );

    if (_targets.length == CoachMark.values.length) {
      isCoachReady = true;
    }
  }

  void showTutorial(BuildContext context, {CoachMark? mark}) {
    // We don't want to notify the listeners again to prevent
    // redundant build calls
    _isCoachReady = false;

    final List<TargetFocus> showTargets = [];
    if (mark != null) {
      if (_targets[mark] != null) showTargets.add(_targets[mark]!);
    } else {
      showTargets.addAll(_targets.values);
    }

    showTargets.removeWhere(
        (target)  => _prefs.seenCoachMarkList.contains(target.identify));

    if (showTargets.isEmpty) return;

    TutorialCoachMark(
      targets: showTargets,
      textSkip: "label-skip".tr(),
      hideSkip: true,
      colorShadow: Colors.teal,
      opacityShadow: 0.9,
      onClickTargetWithTapPosition: (target, tapDetails) {},
      onClickTarget: (target) {
        _prefs.seenCoachMarkList = [
          ..._prefs.seenCoachMarkList,
          target.identify
        ];
      },
    ).show(context: context);
  }
}
