import 'package:flutter/material.dart';

extension ExtendedNavigatorState on NavigatorState {
  Future<dynamic> pushAndClearSnackBar(MaterialPageRoute route) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return push(route);
  }

  popAndClearSnackBar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    pop();
  }
}
