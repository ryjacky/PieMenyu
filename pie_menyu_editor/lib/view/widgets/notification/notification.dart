import 'package:flutter/material.dart';

enum NotificationType { info, warning, error }

extension NotificationColor on NotificationType {
  Color get color {
    switch (this) {
      case NotificationType.info:
        return Colors.blue;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.error:
        return Colors.red;
    }
  }
}

class NotificationDelegate {
  final String message;
  final VoidCallback onPressed;
  final Widget icon;
  final NotificationType type;
  final Curve? curve;

  NotificationDelegate({
    required this.message,
    required this.onPressed,
    required this.icon,
    required this.type,
    required this.curve,
  });
}
